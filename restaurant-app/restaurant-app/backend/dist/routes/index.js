"use strict";
var __importDefault = (this && this.__importDefault) || function (mod) {
    return (mod && mod.__esModule) ? mod : { "default": mod };
};
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const reservationRoutes_1 = __importDefault(require("./reservationRoutes"));
const cityRoutes_1 = __importDefault(require("./cityRoutes"));
const restaurantRoutes_1 = __importDefault(require("./restaurantRoutes"));
const router = (0, express_1.Router)();
router.get('/health', (req, res) => {
    res.json({
        success: true,
        message: 'Restaurant API is running',
        timestamp: new Date().toISOString()
    });
});
router.use('/reservations', reservationRoutes_1.default);
router.use('/cities', cityRoutes_1.default);
router.use('/restaurants', restaurantRoutes_1.default);
exports.default = router;
//# sourceMappingURL=index.js.map