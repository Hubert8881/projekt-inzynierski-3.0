import { Router } from 'express';
import { MenuController } from '../controllers/MenuController';

const router = Router();

router.post('/', MenuController.addMenuItem);
router.get('/:restaurantId', MenuController.getRestaurantMenu);
router.delete('/:id', MenuController.deleteMenuItem);

export default router;