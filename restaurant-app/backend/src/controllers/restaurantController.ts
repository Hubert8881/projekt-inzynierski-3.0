import { Request, Response } from 'express';
import { pool } from '../config/database';

export class RestaurantController {
  static async getAllForMainPage(req: Request, res: Response): Promise<void> {
    console.log('[CTRL] Executing getAllForMainPage');
    try {
      const query = `
        SELECT 
          c.id AS city_id, c.name AS city_name,
          r.id AS rest_id, r.name AS rest_name, r.description, r.address, r.opening_hours,
          m.id AS item_id, m.name AS item_name, m.price
        FROM public.cities c
        LEFT JOIN public.restaurants r ON c.id = r.city_id
        LEFT JOIN public.menu_items m ON r.id = m.restaurant_id
        ORDER BY city_name, rest_name;
      `;
      
      const result = await pool.query(query);
      console.log(`[DB] Rows fetched: ${result.rows.length}`);

      const formattedData = result.rows.reduce((acc: any[], row: any) => {
        let city = acc.find(c => c.id === row.city_id);
        if (!city) {
          city = { id: row.city_id, name: row.city_name, restaurants: [] };
          acc.push(city);
        }
        if (row.rest_id) {
          let restaurant = city.restaurants.find((r: any) => r.id === row.rest_id);
          if (!restaurant) {
            restaurant = {
              id: row.rest_id,
              name: row.rest_name,
              description: row.description,
              address: row.address,
              hours: row.opening_hours,
              menu: []
            };
            city.restaurants.push(restaurant);
          }
          if (row.item_id) {
            restaurant.menu.push({ id: row.item_id, name: row.item_name, price: row.price });
          }
        }
        return acc;
      }, []);

      res.json({ success: true, data: formattedData });
    } catch (error: any) {
      console.error('[ERROR] Controller failed:', error);
      res.status(500).json({ success: false, error: error.message });
    }
  }

  static async getCount(req: Request, res: Response): Promise<void> {
    try {
      const result = await pool.query('SELECT COUNT(*) FROM public.restaurants');
      res.json({ success: true, count: parseInt(result.rows[0].count) });
    } catch (error: any) {
      res.status(500).json({ success: false, error: error.message });
    }
  }

  static async getByCity(req: Request, res: Response): Promise<void> {
    try {
      const { cityId } = req.query;
      const result = await pool.query('SELECT * FROM public.restaurants WHERE city_id = $1', [cityId]);
      res.json({ success: true, data: result.rows });
    } catch (error: any) {
      res.status(500).json({ success: false, error: error.message });
    }
  }
}