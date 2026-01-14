import { Router } from 'express';
import reservationRoutes from './reservationRoutes';
import cityRoutes from './cityRoutes';
import restaurantRoutes from './restaurantRoutes';
const router = Router();

router.get('/health', (req, res) => {
  res.json({
    success: true,
    message: 'Restaurant API is running',
    timestamp: new Date().toISOString()
  });
});
router.use('/reservations', reservationRoutes);
router.use('/cities', cityRoutes);
router.use('/restaurants', restaurantRoutes);
export default router;