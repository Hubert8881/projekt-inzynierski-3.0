import { Request, Response } from 'express'
import { pool } from '../config/database'

export class RestaurantController {
  static async getByCity(req: Request, res: Response): Promise<void> {
    const { city_id } = req.query

    if (!city_id) {
      res.status(400).json({ success: false, message: 'Brak city_id' })
      return
    }

    const id = parseInt(city_id as string, 10)

    try {
      const result = await pool.query(
        `
        SELECT DISTINCT ON (name) id, name, latitude, longitude, description
        FROM restaurants
        WHERE city_id = $1
          AND description IS NOT NULL
          AND description <> ''
        ORDER BY name, id
        `,
        [id]
      )

      res.json({ success: true, data: result.rows })
    } catch (error: any) {
      console.error('Database error:', error.message, error.stack)
      res.status(500).json({ success: false, message: 'Błąd serwera' })
    }
  }

  static async getCount(req: Request, res: Response): Promise<void> {
    try {
      const result = await pool.query('SELECT COUNT(*) FROM restaurants')
      const count = parseInt(result.rows[0].count, 10)
      res.json({ success: true, count })
    } catch (error: any) {
      console.error('Database error:', error.message, error.stack)
      res.status(500).json({ success: false, message: 'Błąd serwera' })
    }
  }
}