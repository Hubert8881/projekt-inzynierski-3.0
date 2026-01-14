"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.CityController = void 0;
const cityModel_1 = require("../models/cityModel");
class CityController {
    static async getAll(req, res) {
        const cities = await cityModel_1.CityModel.getAll();
        res.json({ success: true, data: cities });
    }
}
exports.CityController = CityController;
//# sourceMappingURL=cityController.js.map