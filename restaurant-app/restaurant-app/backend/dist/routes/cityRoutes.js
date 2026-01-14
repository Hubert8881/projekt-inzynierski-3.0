"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const cityController_1 = require("../controllers/cityController");
const router = (0, express_1.Router)();
router.get('/', cityController_1.CityController.getAll);
exports.default = router;
//# sourceMappingURL=cityRoutes.js.map