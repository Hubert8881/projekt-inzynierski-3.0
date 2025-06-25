import { Reservation, CreateReservationRequest, TableAvailability } from '../types';
export declare class ReservationModel {
    static getAvailableTables(restaurantId: number, date: string, time: string, partySize: number): Promise<TableAvailability[]>;
    static createReservation(reservationData: CreateReservationRequest): Promise<Reservation>;
    static getReservationById(id: number): Promise<Reservation | null>;
    static updateReservationStatus(id: number, status: string): Promise<Reservation | null>;
    static getReservationsByDate(restaurantId: number, date: string): Promise<Reservation[]>;
    static getAllReservations(): Promise<Reservation[]>;
}
//# sourceMappingURL=reservationModel.d.ts.map