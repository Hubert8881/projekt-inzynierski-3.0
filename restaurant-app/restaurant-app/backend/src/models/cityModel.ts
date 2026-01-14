import { pool } from '../config/database';
export class CityModel {
  static async getAll() {
    const res = await pool.query('SELECT id, name FROM cities ORDER BY name');
    return res.rows;
  }
}