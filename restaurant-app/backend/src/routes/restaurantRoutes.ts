import { Router } from 'express';
import { RestaurantController } from '../controllers/restaurantController';

const router = Router();

router.get('/', RestaurantController.getAllForMainPage);
router.get('/by-city', RestaurantController.getByCity);
router.get('/count', RestaurantController.getCount);

export default router;