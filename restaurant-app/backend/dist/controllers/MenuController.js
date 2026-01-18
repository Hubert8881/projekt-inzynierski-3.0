"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.MenuController = void 0;
const database_1 = require("../config/database");
class MenuController {
    static async addMenuItem(req, res) {
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
            const result = await database_1.pool.query(query, [restaurant_id, name, price]);
            res.status(201).json({
                success: true,
                message: 'Pozycja dodana do menu!',
                data: result.rows[0]
            });
        }
        catch (error) {
            if (error.code === '23505') {
                res.status(400).json({ success: false, message: 'Ta pozycja już istnieje w menu tej restauracji.' });
            }
            else {
                res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
            }
        }
    }
    static async getRestaurantMenu(req, res) {
        const { restaurantId } = req.params;
        try {
            const query = 'SELECT * FROM public.menu_items WHERE restaurant_id = $1 ORDER BY name ASC';
            const result = await database_1.pool.query(query, [restaurantId]);
            res.json({ success: true, data: result.rows });
        }
        catch (error) {
            res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
        }
    }
    static async deleteMenuItem(req, res) {
        const { id } = req.params;
        try {
            const result = await database_1.pool.query('DELETE FROM public.menu_items WHERE id = $1', [id]);
            if (result.rowCount === 0) {
                res.status(404).json({ success: false, message: 'Nie znaleziono pozycji.' });
                return;
            }
            res.json({ success: true, message: 'Pozycja usunięta.' });
        }
        catch (error) {
            res.status(500).json({ success: false, message: 'Błąd serwera', error: error.message });
        }
    }
}
exports.MenuController = MenuController;
//# sourceMappingURL=MenuController.js.map