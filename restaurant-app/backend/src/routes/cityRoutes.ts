import { Router } from 'express';
import { CityController } from '../controllers/cityController';
import { RestaurantController } from '../controllers/restaurantController';

const router = Router();

router.get('/full-data', RestaurantController.getAllForMainPage);
router.get('/', CityController.getAll);

export default router;