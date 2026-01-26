import express from 'express'
import cors from 'cors'
import jwt from 'jsonwebtoken'
import helmet from 'helmet'
import dotenv from 'dotenv'
import bcrypt from 'bcryptjs'
import cookieParser from 'cookie-parser'
import rateLimit from 'express-rate-limit'
import { z } from 'zod'
import { initDatabase, pool } from './config/database'

dotenv.config()

const app = express()
const PORT = process.env.PORT || 5001
const JWT_SECRET = process.env.JWT_SECRET || 'fallback_secret_key_123'
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'refresh_secret_key_123'

const passwordSchema = z.string()
  .min(8)
  .regex(/[A-Z]/)
  .regex(/[0-9]/)
  .regex(/[^a-zA-Z0-9]/)

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 100,
  message: { success: false, message: 'Zbyt wiele zapytań z tego IP, spróbuj ponownie za 15 minut.' },
  standardHeaders: true,
  legacyHeaders: false,
})

const loginLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,
  max: 10,
  message: { success: false, message: 'Zbyt wiele prób logowania z tego IP. Blokada na 15 minut.' },
  standardHeaders: true,
  legacyHeaders: false,
})

app.use(helmet({
  contentSecurityPolicy: false,
  crossOriginResourcePolicy: false,
  crossOriginOpenerPolicy: false,
  crossOriginEmbedderPolicy: false
}))

app.use(cookieParser())
app.use(cors({
  origin: 'http://localhost:5173',
  methods: ['GET', 'POST', 'PUT', 'DELETE', 'OPTIONS'],
  allowedHeaders: ['Content-Type', 'Authorization'],
  credentials: true
}))

app.use(express.json())
app.use('/api/', apiLimiter)
app.use('/uploads', express.static('public/uploads'))

const logEvent = async (eventType: string, role: string | null, ip: string, details: string, success: boolean) => {
  try {
    await pool.query(
      'INSERT INTO public.audit_logs (event_type, user_role, ip_address, details, success) VALUES ($1, $2, $3, $4, $5)',
      [eventType, role, ip, details, success]
    )
  } catch (err) {
    console.error('Audit Log Error:', err)
  }
}

export const authenticateToken = (req: any, res: any, next: any) => {
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]
  if (!token) return res.status(401).json({ success: false, message: 'Access Denied' })
  
  jwt.verify(token, JWT_SECRET, (err: any, user: any) => {
    if (err) return res.status(403).json({ success: false, message: 'Invalid or Expired Token' })
    req.user = user
    next()
  })
}

import restaurantRoutes from './routes/restaurantRoutes'
import cityRoutes from './routes/cityRoutes'
import reservationRoutes from './routes/reservationRoutes'
import menuRoutes from './routes/menuRoutes'

app.post('/api/login', loginLimiter, async (req: any, res: any) => {
  const { password } = req.body
  const now = new Date()
  const userIp = req.ip || req.connection.remoteAddress || 'unknown'

  try {
    const validation = passwordSchema.safeParse(password)
    if (!validation.success) {
      await logEvent('LOGIN_ATTEMPT', null, userIp, 'Nieprawidłowy format hasła', false)
      return res.status(400).json({ 
        success: false, 
        message: 'Hasło nie spełnia wymogów bezpieczeństwa.' 
      })
    }

    const adminResult = await pool.query('SELECT * FROM public.admin_account WHERE id = 1')
    const admin = adminResult.rows[0]

    if (!admin) {
      return res.status(500).json({ success: false, message: 'Błąd konfiguracji konta administratora.' })
    }

    if (admin.lock_until && new Date(admin.lock_until) > now) {
      const diff = new Date(admin.lock_until).getTime() - now.getTime()
      const minutes = Math.ceil(diff / 60000)
      await logEvent('LOGIN_ATTEMPT', 'admin', userIp, 'Próba logowania na zablokowane konto', false)
      return res.status(403).json({ 
        success: false, 
        message: `Konto tymczasowo zablokowane. Spróbuj ponownie za ${minutes} min.` 
      })
    }

    const isMatch = await bcrypt.compare(password, admin.password_hash)

    if (isMatch) {
      await pool.query('UPDATE public.admin_account SET login_attempts = 0, lock_until = NULL WHERE id = 1')
      await logEvent('LOGIN_SUCCESS', 'admin', userIp, 'Poprawne logowanie administratora', true)

      const accessToken = jwt.sign({ role: 'admin' }, JWT_SECRET, { expiresIn: '15m' })
      const refreshToken = jwt.sign({ role: 'admin' }, JWT_REFRESH_SECRET, { expiresIn: '7d' })
      
      res.cookie('refreshToken', refreshToken, {
        httpOnly: true,
        secure: process.env.NODE_ENV === 'production',
        sameSite: 'strict',
        maxAge: 7 * 24 * 60 * 60 * 1000
      })

      res.json({ success: true, accessToken })
    } else {
      const newAttempts = admin.login_attempts + 1
      let lockUntil = admin.lock_until

      if (newAttempts >= 5) {
        lockUntil = new Date(now.getTime() + 30 * 60000)
      }

      await pool.query(
        'UPDATE public.admin_account SET login_attempts = $1, lock_until = $2 WHERE id = 1',
        [newAttempts, lockUntil]
      )

      await logEvent('LOGIN_FAILURE', 'admin', userIp, `Błędne hasło (próba ${newAttempts}/5)`, false)

      const remaining = Math.max(0, 5 - newAttempts)
      res.status(401).json({ 
        success: false, 
        message: newAttempts >= 5 
          ? 'Zbyt wiele prób logowania. Konto zablokowane na 30 minut.' 
          : `Błędne hasło. Pozostało prób: ${remaining}` 
      })
    }
  } catch (error) {
    await logEvent('SERVER_ERROR', null, userIp, 'Błąd podczas logowania', false)
    console.error('Login error:', error)
    res.status(500).json({ success: false, message: 'Błąd serwera podczas logowania' })
  }
})

app.get('/api/admin/audit-logs', authenticateToken, async (req: any, res: any) => {
  try {
    const logs = await pool.query('SELECT * FROM public.audit_logs ORDER BY timestamp DESC LIMIT 100')
    res.json({ success: true, logs: logs.rows })
  } catch (error) {
    res.status(500).json({ success: false, message: 'Nie udało się pobrać logów' })
  }
})

app.post('/api/refresh', (req: any, res: any) => {
  const refreshToken = req.cookies.refreshToken
  if (!refreshToken) return res.status(401).json({ success: false, message: 'Refresh Token Required' })

  jwt.verify(refreshToken, JWT_REFRESH_SECRET, (err: any, user: any) => {
    if (err) return res.status(403).json({ success: false, message: 'Invalid Refresh Token' })
    const newAccessToken = jwt.sign({ role: 'admin' }, JWT_SECRET, { expiresIn: '15m' })
    res.json({ success: true, accessToken: newAccessToken })
  })
})

app.post('/api/logout', (req: any, res: any) => {
  res.clearCookie('refreshToken')
  res.json({ success: true })
})

app.use('/api/restaurants', restaurantRoutes)
app.use('/api/cities', cityRoutes)
app.use('/api/reservations', reservationRoutes)
app.use('/api/menu', menuRoutes)

app.get('/api/health', (req, res) => {
  res.json({ success: true, message: 'API is running' })
})

const startServer = async () => {
  try {
    await initDatabase()
    app.listen(Number(PORT), '0.0.0.0', () => {
      console.log(`Backend listening on http://localhost:${PORT}`)
    })
  } catch (err) {
    console.error('Failed to start server:', err)
  }
}

void startServer()