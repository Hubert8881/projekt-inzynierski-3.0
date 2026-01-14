import { Router } from 'express';
import { CityController } from '../controllers/cityController';
import { RestaurantController } from '../controllers/restaurantController';

const router = Router();

router.get('/full-data', (req, res, next) => {
  console.log('[ROUTE] Accessing /api/cities/full-data');
  next();
}, RestaurantController.getAllForMainPage);

router.get('/', CityController.getAll);

export default router;