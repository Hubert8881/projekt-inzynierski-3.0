import express from 'express'
import cors from 'cors'
import { initDatabase, pool } from './config/database'
import restaurantRoutes from './routes/restaurantRoutes'
import cityRoutes from './routes/cityRoutes'
import reservationRoutes from './routes/reservationRoutes'

const app = express()
const PORT = 5001

app.use(cors({
  origin: 'http://localhost:5173',
  methods: ['GET', 'POST', 'PUT', 'DELETE'],
  allowedHeaders: ['Content-Type', 'Authorization']
}))

app.use(express.json())

app.use((req, res, next) => {
  console.log(`[DEBUG] ${req.method} ${req.url}`);
  next();
})

app.use('/api/restaurants', restaurantRoutes)
app.use('/api/cities', cityRoutes)
app.use('/api/reservations', reservationRoutes)

app.get('/api/health', (req, res) => {
  res.json({ success: true, message: 'API is running' })
})

const cleanOldReservations = async () => {
  try {
    const query = `
      DELETE FROM public.reservations 
      WHERE (reservation_date::timestamp + reservation_time::interval) < (NOW() - INTERVAL '1 hour')
    `;
    await pool.query(query);
    console.log('[CLEANUP] Stare rezerwacje zostaly usuniete');
  } catch (err) {
    console.error('[CLEANUP ERROR]', err);
  }
};

const startServer = async () => {
  try {
    await initDatabase()
    console.log('Database initialized')
    
    await cleanOldReservations();
    setInterval(cleanOldReservations, 30 * 60 * 1000);

    app.listen(PORT, '127.0.0.1', () => {
      console.log(`Backend listening on http://localhost:${PORT}`)
    })
  } catch (err) {
    console.error('Failed to start server:', err)
  }
}

void startServer()