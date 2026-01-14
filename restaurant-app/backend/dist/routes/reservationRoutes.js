"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const reservationController_1 = require("../controllers/reservationController");
const router = (0, express_1.Router)();
router.get('/', reservationController_1.ReservationController.getAllReservations);
router.post('/', reservationController_1.ReservationController.createReservation);
router.delete('/:id', reservationController_1.ReservationController.deleteReservation);
exports.default = router;
//# sourceMappingURL=reservationRoutes.js.map