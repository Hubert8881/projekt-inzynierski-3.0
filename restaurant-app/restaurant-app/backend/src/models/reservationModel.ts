import { pool } from '../config/database';
import { Reservation, CreateReservationRequest, TableAvailability, Customer } from '../types';

export class ReservationModel {
  static async getAvailableTables(
    restaurantId: number, 
    date: string, 
    time: string, 
    partySize: number
  ): Promise<TableAvailability[]> {
    try {
      const query = `
        SELECT t.id as table_id, t.table_number, t.capacity, t.is_available
        FROM tables t
        WHERE t.restaurant_id = $1 
          AND t.capacity >= $2 
          AND t.is_available = true
          AND t.id NOT IN (
            SELECT r.table_id 
            FROM reservations r 
            WHERE r.restaurant_id = $1 
              AND r.reservation_date = $3 
              AND r.reservation_time = $4 
              AND r.status IN ('pending', 'confirmed')
          )
        ORDER BY t.capacity ASC, t.table_number ASC
      `;
      
      const result = await pool.query(query, [restaurantId, partySize, date, time]);
      return result.rows;
    } catch (error) {
      console.error('Error getting available tables:', error);
      throw error;
    }
  }

  static async createReservation(reservationData: CreateReservationRequest): Promise<Reservation> {
    const client = await pool.connect();
    
    try {
      await client.query('BEGIN');
      let customer: Customer;
      const customerResult = await client.query(
        'SELECT * FROM customers WHERE email = $1',
        [reservationData.customer_email]
      );
      
      if (customerResult.rows.length > 0) {
        customer = customerResult.rows[0];
      } else {
        const newCustomerResult = await client.query(
          `INSERT INTO customers (first_name, last_name, email, phone) 
           VALUES ($1, $2, $3, $4) RETURNING *`,
          [
            reservationData.customer_first_name,
            reservationData.customer_last_name,
            reservationData.customer_email,
            reservationData.customer_phone
          ]
        );
        customer = newCustomerResult.rows[0];
      }
      const availableTables = await this.getAvailableTables(
        reservationData.restaurant_id,
        reservationData.reservation_date,
        reservationData.reservation_time,
        reservationData.party_size
      );
      
      if (availableTables.length === 0) {
        throw new Error('No available tables for the requested time and party size');
      }
      const selectedTable = availableTables[0];
      const reservationResult = await client.query(
        `INSERT INTO reservations 
         (customer_id, restaurant_id, table_id, reservation_date, reservation_time, party_size, special_requests, status) 
         VALUES ($1, $2, $3, $4, $5, $6, $7, 'pending') RETURNING *`,
        [
          customer.id,
          reservationData.restaurant_id,
          selectedTable.table_id,
          reservationData.reservation_date,
          reservationData.reservation_time,
          reservationData.party_size,
          reservationData.special_requests
        ]
      );
      
      await client.query('COMMIT');
      return reservationResult.rows[0];
      
    } catch (error) {
      await client.query('ROLLBACK');
      throw error;
    } finally {
      client.release();
    }
  }

  static async getReservationById(id: number): Promise<Reservation | null> {
    try {
      const query = `
        SELECT r.*, c.first_name, c.last_name, c.email, c.phone,
               res.name as restaurant_name, t.table_number
        FROM reservations r
        JOIN customers c ON r.customer_id = c.id
        JOIN restaurants res ON r.restaurant_id = res.id
        JOIN tables t ON r.table_id = t.id
        WHERE r.id = $1
      `;
      
      const result = await pool.query(query, [id]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error getting reservation:', error);
      throw error;
    }
  }

  static async updateReservationStatus(id: number, status: string): Promise<Reservation | null> {
    try {
      const query = `
        UPDATE reservations 
        SET status = $1, updated_at = CURRENT_TIMESTAMP 
        WHERE id = $2 
        RETURNING *
      `;
      
      const result = await pool.query(query, [status, id]);
      return result.rows[0] || null;
    } catch (error) {
      console.error('Error updating reservation status:', error);
      throw error;
    }
  }

  static async getReservationsByDate(restaurantId: number, date: string): Promise<Reservation[]> {
    try {
      const query = `
        SELECT r.*, c.first_name, c.last_name, c.email, c.phone, t.table_number
        FROM reservations r
        JOIN customers c ON r.customer_id = c.id
        JOIN tables t ON r.table_id = t.id
        WHERE r.restaurant_id = $1 AND r.reservation_date = $2
        ORDER BY r.reservation_time ASC
      `;
      
      const result = await pool.query(query, [restaurantId, date]);
      return result.rows;
    } catch (error) {
      console.error('Error getting reservations by date:', error);
      throw error;
    }
  }
static async getAllReservations(): Promise<Reservation[]> {
    try {
      const query = `
        SELECT r.*, c.first_name, c.last_name, c.email, c.phone,
               res.name as restaurant_name, t.table_number
        FROM reservations r
        JOIN customers c ON r.customer_id = c.id
        JOIN restaurants res ON r.restaurant_id = res.id
        JOIN tables t ON r.table_id = t.id
        ORDER BY r.reservation_date DESC, r.reservation_time DESC
      `;

      const result = await pool.query(query);
      return result.rows;
    } catch (error) {
      console.error('Error getting all reservations:', error);
      throw error;
    }
  }
}