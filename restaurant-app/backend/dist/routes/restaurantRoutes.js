"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const restaurantController_1 = require("../controllers/restaurantController");
const router = (0, express_1.Router)();
router.get('/by-city', restaurantController_1.RestaurantController.getByCity);
router.get('/count', restaurantController_1.RestaurantController.getCount);
exports.default = router;
//# sourceMappingURL=restaurantRoutes.js.map