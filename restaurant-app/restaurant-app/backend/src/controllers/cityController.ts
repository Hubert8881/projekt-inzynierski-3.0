import { Request, Response } from 'express';
import { CityModel } from '../models/cityModel';
export class CityController {
  static async getAll(req: Request, res: Response) {
    const cities = await CityModel.getAll();
    res.json({ success: true, data: cities });
  }
}