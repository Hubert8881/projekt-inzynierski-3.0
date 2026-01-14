"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
exports.ReservationController = void 0;
const reservationModel_1 = require("../models/reservationModel");
class ReservationController {
    static async getAvailableTables(req, res) {
        try {
            const { restaurant_id, date, time, party_size } = req.query;
            if (!restaurant_id || !date || !time || !party_size) {
                res.status(400).json({
                    success: false,
                    message: 'Missing required parameters: restaurant_id, date, time, party_size'
                });
                return;
            }
            const restaurantId = parseInt(restaurant_id);
            const partySize = parseInt(party_size);
            if (isNaN(restaurantId) || isNaN(partySize)) {
                res.status(400).json({
                    success: false,
                    message: 'restaurant_id and party_size must be valid numbers'
                });
                return;
            }
            const dateRegex = /^\d{4}-\d{2}-\d{2}$/;
            if (!dateRegex.test(date)) {
                res.status(400).json({
                    success: false,
                    message: 'Date must be in YYYY-MM-DD format'
                });
                return;
            }
            const timeRegex = /^([01]?[0-9]|2[0-3]):[0-5][0-9]$/;
            if (!timeRegex.test(time)) {
                res.status(400).json({
                    success: false,
                    message: 'Time must be in HH:MM format'
                });
                return;
            }
            const availableTables = await reservationModel_1.ReservationModel.getAvailableTables(restaurantId, date, time, partySize);
            res.json({
                success: true,
                data: {
                    available_tables: availableTables,
                    restaurant_id: restaurantId,
                    requested_date: date,
                    requested_time: time,
                    party_size: partySize
                }
            });
        }
        catch (error) {
            console.error('Error in getAvailableTables:', error);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        }
    }
    static async createReservation(req, res) {
        try {
            const reservationData = req.body;
            const requiredFields = [
                'customer_email',
                'customer_first_name',
                'customer_last_name',
                'restaurant_id',
                'reservation_date',
                'reservation_time',
                'party_size'
            ];
            const missingFields = requiredFields.filter(field => !reservationData[field]);
            if (missingFields.length > 0) {
                res.status(400).json({
                    success: false,
                    message: `Missing required fields: ${missingFields.join(', ')}`
                });
                return;
            }
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!emailRegex.test(reservationData.customer_email)) {
                res.status(400).json({
                    success: false,
                    message: 'Invalid email format'
                });
                return;
            }
            if (reservationData.party_size < 1 || reservationData.party_size > 20) {
                res.status(400).json({
                    success: false,
                    message: 'Party size must be between 1 and 20'
                });
                return;
            }
            const reservationDate = new Date(reservationData.reservation_date);
            const today = new Date();
            today.setHours(0, 0, 0, 0);
            if (reservationDate < today) {
                res.status(400).json({
                    success: false,
                    message: 'Reservation date cannot be in the past'
                });
                return;
            }
            const reservation = await reservationModel_1.ReservationModel.createReservation(reservationData);
            res.status(201).json({
                success: true,
                message: 'Reservation created successfully',
                data: reservation
            });
        }
        catch (error) {
            console.error('Error in createReservation:', error);
            if (error instanceof Error) {
                if (error.message.includes('No available tables')) {
                    res.status(409).json({
                        success: false,
                        message: 'No available tables for the requested time and party size'
                    });
                }
                else {
                    res.status(500).json({
                        success: false,
                        message: 'Failed to create reservation'
                    });
                }
            }
            else {
                res.status(500).json({
                    success: false,
                    message: 'Internal server error'
                });
            }
        }
    }
    static async getReservation(req, res) {
        try {
            const { id } = req.params;
            const reservationId = parseInt(id);
            if (isNaN(reservationId)) {
                res.status(400).json({
                    success: false,
                    message: 'Invalid reservation ID'
                });
                return;
            }
            const reservation = await reservationModel_1.ReservationModel.getReservationById(reservationId);
            if (!reservation) {
                res.status(404).json({
                    success: false,
                    message: 'Reservation not found'
                });
                return;
            }
            res.json({
                success: true,
                data: reservation
            });
        }
        catch (error) {
            console.error('Error in getReservation:', error);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        }
    }
    static async updateReservationStatus(req, res) {
        try {
            const { id } = req.params;
            const { status } = req.body;
            const reservationId = parseInt(id);
            if (isNaN(reservationId)) {
                res.status(400).json({
                    success: false,
                    message: 'Invalid reservation ID'
                });
                return;
            }
            const validStatuses = ['pending', 'confirmed', 'cancelled', 'completed'];
            if (!status || typeof status !== 'string' || !validStatuses.includes(status)) {
                res.status(400).json({
                    success: false,
                    message: 'Invalid status. Must be one of: ' + validStatuses.join(', ')
                });
                return;
            }
            const updatedReservation = await reservationModel_1.ReservationModel.updateReservationStatus(reservationId, status);
            if (!updatedReservation) {
                res.status(404).json({
                    success: false,
                    message: 'Reservation not found'
                });
                return;
            }
            res.json({
                success: true,
                message: 'Reservation status updated successfully',
                data: updatedReservation
            });
        }
        catch (error) {
            console.error('Error in updateReservationStatus:', error);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        }
    }
    static async getReservationsByDate(req, res) {
        try {
            const { restaurant_id, date } = req.query;
            if (!restaurant_id || !date) {
                res.status(400).json({
                    success: false,
                    message: 'Missing required parameters: restaurant_id, date'
                });
                return;
            }
            const restaurantId = parseInt(restaurant_id);
            if (isNaN(restaurantId)) {
                res.status(400).json({
                    success: false,
                    message: 'restaurant_id must be a valid number'
                });
                return;
            }
            const reservations = await reservationModel_1.ReservationModel.getReservationsByDate(restaurantId, date);
            res.json({
                success: true,
                data: reservations
            });
        }
        catch (error) {
            console.error('Error in getReservationsByDate:', error);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        }
    }
    static async getAllReservations(req, res) {
        try {
            const reservations = await reservationModel_1.ReservationModel.getAllReservations();
            res.json({
                success: true,
                data: reservations
            });
        }
        catch (error) {
            console.error('Error in getAllReservations:', error);
            res.status(500).json({
                success: false,
                message: 'Internal server error'
            });
        }
    }
}
exports.ReservationController = ReservationController;
//# sourceMappingURL=reservationController.js.map