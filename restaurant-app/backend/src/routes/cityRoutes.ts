import { Router } from 'express';
import { CityController } from '../controllers/cityController';

const router = Router();

router.get('/', CityController.getAll);

export default router;