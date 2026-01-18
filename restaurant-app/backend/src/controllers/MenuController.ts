import { Request, Response } from 'express';
import { pool } from '../config/database';

export class MenuController {
    static async addMenuItem(req: Request, res: Response): Promise<void> {
        const { restaurant_id, name, price } = req.body;

        if (!restaurant_id || !name || price === undefined) {
            res.status(400).json({ success: false, message: 'Brak wymaganych danych produktu.' });
            return;
        }

        try {
            const query = `
                INSERT INTO public.menu_items (restaurant_id, name, price)
                VALUES ($1, $2, $3)
                RETURNING *;
            `;
            const result = await pool.query(query, [restaurant_id, name, price]);
            
            res.status(201).json({
                success: true,
                message: 'Pozycja dodana do menu!',
                data: result.rows[0]
            });
        } catch (error: any) {
            if (error.code === '23505') {
                res.status(400).json({ success: false, message: 'Ta pozycja już istnieje w menu tej restauracji.' });
            } else {
                res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
            }
        }
    }

    static async getRestaurantMenu(req: Request, res: Response): Promise<void> {
        const { restaurantId } = req.params;
        try {
            const query = 'SELECT * FROM public.menu_items WHERE restaurant_id = $1 ORDER BY name ASC';
            const result = await pool.query(query, [restaurantId]);
            res.json({ success: true, data: result.rows });
        } catch (error: any) {
            res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
        }
    }

    static async deleteMenuItem(req: Request, res: Response): Promise<void> {
        const { id } = req.params;
        try {
            const result = await pool.query('DELETE FROM public.menu_items WHERE id = $1', [id]);
            if (result.rowCount === 0) {
                res.status(404).json({ success: false, message: 'Nie znaleziono pozycji.' });
                return;
            }
            res.json({ success: true, message: 'Pozycja usunięta.' });
        } catch (error: any) {
            res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
        }
    }
}