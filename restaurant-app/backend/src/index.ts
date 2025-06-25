import express from 'express'
import cors from 'cors'
import { initDatabase, pool } from './config/database'
import restaurantRoutes from './routes/restaurantRoutes'
import cityRoutes from './routes/cityRoutes'
import reservationRoutes from './routes/reservationRoutes'

const app = express()
const PORT = process.env.PORT || 5000

app.use(cors())

app.get('/test-count', async (req, res) => {
  try {
    const result = await pool.query('SELECT COUNT(*) FROM restaurants')
    const count = parseInt(result.rows[0].count, 10)
    res.json({ success: true, count })
  } catch (error) {
    console.error('Database error:', error)
    res.status(500).json({ success: false, message: 'Błąd serwera' })
  }
})

app.use(express.json())

app.use('/api/restaurants', restaurantRoutes)
app.use('/api/cities', cityRoutes)
app.use('/api/reservations', reservationRoutes)

app.get('/api/health', (req, res) => {
  res.json({
    success: true,
    message: 'API is running',
    timestamp: new Date().toISOString(),
  })
})

void (async () => {
  try {
    await initDatabase()
    console.log('Database initialized')

    app.listen(PORT, () => {
      console.log(`Server listening on port ${PORT}`)
    })
  } catch (err) {
    console.error('Failed to initialize database:', err)
    process.exit(1)
  }
})()