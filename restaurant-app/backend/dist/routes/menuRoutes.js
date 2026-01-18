"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const MenuController_1 = require("../controllers/MenuController");
const router = (0, express_1.Router)();
router.post('/', MenuController_1.MenuController.addMenuItem);
router.get('/:restaurantId', MenuController_1.MenuController.getRestaurantMenu);
router.delete('/:id', MenuController_1.MenuController.deleteMenuItem);
exports.default = router;
//# sourceMappingURL=menuRoutes.js.map