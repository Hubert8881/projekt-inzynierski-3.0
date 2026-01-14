import { Router } from 'express';
import { ReservationController } from '../controllers/reservationController';

const router = Router();

router.get('/', ReservationController.getAllReservations);
router.post('/', ReservationController.createReservation);
router.delete('/:id', ReservationController.deleteReservation);

export default router;