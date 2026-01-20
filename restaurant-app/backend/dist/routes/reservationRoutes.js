"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const reservationController_1 = require("../controllers/reservationController");
const index_1 = require("../index");
const router = (0, express_1.Router)();
router.get('/', index_1.authenticateToken, reservationController_1.ReservationController.getAllReservations);
router.post('/', reservationController_1.ReservationController.createReservation);
router.delete('/:id', index_1.authenticateToken, reservationController_1.ReservationController.deleteReservation);
exports.default = router;
//# sourceMappingURL=reservationRoutes.js.map