"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const cityController_1 = require("../controllers/cityController");
const restaurantController_1 = require("../controllers/restaurantController");
const router = (0, express_1.Router)();
router.get('/full-data', (req, res, next) => {
    console.log('[ROUTE] Accessing /api/cities/full-data');
    next();
}, restaurantController_1.RestaurantController.getAllForMainPage);
router.get('/', cityController_1.CityController.getAll);
exports.default = router;
//# sourceMappingURL=cityRoutes.js.map