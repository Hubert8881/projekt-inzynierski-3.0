import { Request, Response } from 'express';
export declare class ReservationController {
    static getAvailableTables(req: Request, res: Response): Promise<void>;
    static createReservation(req: Request, res: Response): Promise<void>;
    static getReservation(req: Request, res: Response): Promise<void>;
    static updateReservationStatus(req: Request, res: Response): Promise<void>;
    static getReservationsByDate(req: Request, res: Response): Promise<void>;
    static getAllReservations(req: Request, res: Response): Promise<void>;
}
//# sourceMappingURL=reservationController.d.ts.map