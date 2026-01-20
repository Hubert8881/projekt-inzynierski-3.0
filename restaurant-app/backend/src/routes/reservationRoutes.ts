import { Router } from 'express';
import { ReservationController } from '../controllers/reservationController';
import { authenticateToken } from '../index';

const router = Router();

router.get('/', authenticateToken, ReservationController.getAllReservations);
router.post('/', ReservationController.createReservation);
router.delete('/:id', authenticateToken, ReservationController.deleteReservation);

export default router;