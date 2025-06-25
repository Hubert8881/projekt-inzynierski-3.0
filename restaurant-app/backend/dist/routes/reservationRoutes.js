"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const reservationController_1 = require("../controllers/reservationController");
const router = (0, express_1.Router)();
router.get('/available-tables', reservationController_1.ReservationController.getAvailableTables);
router.post('/', reservationController_1.ReservationController.createReservation);
router.get('/by-date', reservationController_1.ReservationController.getReservationsByDate);
router.get('/:id', reservationController_1.ReservationController.getReservation);
router.put('/:id/status', reservationController_1.ReservationController.updateReservationStatus);
exports.default = router;
//# sourceMappingURL=reservationRoutes.js.map