import express from 'express'
import cors from 'cors'
import jwt from 'jsonwebtoken'
import helmet from 'helmet'
import dotenv from 'dotenv'
import { initDatabase } from './config/database'

dotenv.config()

const app = express()
const PORT = 5001
const JWT_SECRET = process.env.JWT_SECRET || 'fallback_secret_key_123'
const ADMIN_PASSWORD = process.env.ADMIN_PASSWORD || 'admin123'

app.use(helmet())
app.use(cors({
  origin: 'http://localhost:5173',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}))
app.use(express.json())
app.use('/uploads', express.static('public/uploads'))

export const authenticateToken = (req: any, res: any, next: any) => {
  const authHeader = req.headers['authorization']
  const token = authHeader && authHeader.split(' ')[1]
  if (!token) return res.status(401).json({ success: false, message: 'Access Denied' })
  jwt.verify(token, JWT_SECRET, (err: any, user: any) => {
    if (err) return res.status(403).json({ success: false, message: 'Invalid Token' })
    req.user = user
    next()
  })
}

import restaurantRoutes from './routes/restaurantRoutes'
import cityRoutes from './routes/cityRoutes'
import reservationRoutes from './routes/reservationRoutes'
import menuRoutes from './routes/menuRoutes'

app.post('/api/login', (req: any, res: any) => {
  const { password } = req.body
  if (password === ADMIN_PASSWORD) {
    const token = jwt.sign({ role: 'admin' }, JWT_SECRET, { expiresIn: '2h' })
    res.json({ success: true, token })
  } else {
    res.status(401).json({ success: false, message: 'Błędne hasło administratora' })
  }
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
    app.listen(PORT, '0.0.0.0', () => {
      console.log(`Backend listening on http://localhost:${PORT}`)
    })
  } catch (err) {
    console.error('Failed to start server:', err)
  }
}

void startServer()