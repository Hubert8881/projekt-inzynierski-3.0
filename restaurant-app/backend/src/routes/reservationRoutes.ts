import { Router } from 'express';
import { ReservationController } from '../controllers/reservationController';

const router = Router();

router.get('/available-tables', ReservationController.getAvailableTables);
router.post('/', ReservationController.createReservation);
router.get('/by-date', ReservationController.getReservationsByDate);  // przeniesione wyżej
router.get('/:id', ReservationController.getReservation);
router.put('/:id/status', ReservationController.updateReservationStatus);

export default router;