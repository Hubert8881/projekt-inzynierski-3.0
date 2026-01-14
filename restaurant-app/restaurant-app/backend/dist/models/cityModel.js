"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CityModel = void 0;
const database_1 = require("../config/database");
class CityModel {
    static async getAll() {
        const res = await database_1.pool.query('SELECT id, name FROM cities ORDER BY name');
        return res.rows;
    }
}
exports.CityModel = CityModel;
//# sourceMappingURL=cityModel.js.map