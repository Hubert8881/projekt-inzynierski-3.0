"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.RestaurantController = void 0;
const database_1 = require("../config/database");
class RestaurantController {
    static async getByCity(req, res) {
        const { city_id } = req.query;
        if (!city_id) {
            res.status(400).json({ success: false, message: 'Brak city_id' });
            return;
        }
        const id = parseInt(city_id, 10);
        try {
            const result = await database_1.pool.query(`
        SELECT DISTINCT ON (name) id, name, latitude, longitude, description
        FROM restaurants
        WHERE city_id = $1
          AND description IS NOT NULL
          AND description <> ''
        ORDER BY name, id
        `, [id]);
            res.json({ success: true, data: result.rows });
        }
        catch (error) {
            console.error('Database error:', error.message, error.stack);
            res.status(500).json({ success: false, message: 'Błąd serwera' });
        }
    }
    static async getCount(req, res) {
        try {
            const result = await database_1.pool.query('SELECT COUNT(*) FROM restaurants');
            const count = parseInt(result.rows[0].count, 10);
            res.json({ success: true, count });
        }
        catch (error) {
            console.error('Database error:', error.message, error.stack);
            res.status(500).json({ success: false, message: 'Błąd serwera' });
        }
    }
}
exports.RestaurantController = RestaurantController;
//# sourceMappingURL=restaurantController.js.map