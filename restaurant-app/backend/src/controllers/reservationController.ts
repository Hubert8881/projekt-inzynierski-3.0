import { Request, Response } from 'express';
import { pool } from '../config/database';

export class ReservationController {
  static async createReservation(req: Request, res: Response): Promise<void> {
    const {
      restaurant_id,
      reservation_date,
      reservation_time,
      party_size,
      customer_first_name,
      customer_last_name,
      customer_email,
      customer_phone
    } = req.body;

    if (!restaurant_id || !reservation_date || !customer_email) {
      res.status(400).json({ success: false, message: 'Brak wymaganych danych rezerwacji.' });
      return;
    }

    const client = await pool.connect();

    try {
      await client.query('BEGIN');

      const restaurantRes = await client.query(
        'SELECT total_tables FROM public.restaurants WHERE id = $1',
        [restaurant_id]
      );
      const totalTables = restaurantRes.rows[0]?.total_tables || 10;

      const currentRes = await client.query(
        'SELECT COUNT(*) FROM public.reservations WHERE restaurant_id = $1 AND reservation_date = $2 AND reservation_time = $3',
        [restaurant_id, reservation_date, reservation_time]
      );
      const bookedTables = parseInt(currentRes.rows[0].count);

      if (bookedTables >= totalTables) {
        await client.query('ROLLBACK');
        res.status(400).json({ success: false, message: 'Brak wolnych stolikow na te godzine.' });
        return;
      }

      let customerResult = await client.query(
        'SELECT id FROM public.customers WHERE email = $1',
        [customer_email]
      );

      let customerId;
      if (customerResult.rows.length === 0) {
        const newCustomer = await client.query(
          'INSERT INTO public.customers (first_name, last_name, email, phone) VALUES ($1, $2, $3, $4) RETURNING id',
          [customer_first_name, customer_last_name, customer_email, customer_phone]
        );
        customerId = newCustomer.rows[0].id;
      } else {
        customerId = customerResult.rows[0].id;
      }

      const reservationQuery = `
        INSERT INTO public.reservations (
          customer_id, 
          restaurant_id, 
          reservation_date, 
          reservation_time, 
          party_size, 
          status
        ) VALUES ($1, $2, $3, $4, $5, 'confirmed')
        RETURNING id;
      `;
      
      const reservationValues = [customerId, restaurant_id, reservation_date, reservation_time, party_size];
      const result = await client.query(reservationQuery, reservationValues);

      await client.query('COMMIT');

      res.status(201).json({
        success: true,
        message: 'Rezerwacja zostala pomyslnie zapisana!',
        reservationId: result.rows[0].id
      });

    } catch (error: any) {
      await client.query('ROLLBACK');
      if (error.code === '23505') {
        res.status(400).json({ success: false, message: 'Masz juz rezerwacje w tej restauracji o tej godzinie.' });
      } else {
        res.status(500).json({ success: false, message: 'Blad serwera', error: error.message });
      }
    } finally {
      client.release();
    }
  }

  static async getAllReservations(req: Request, res: Response): Promise<void> {
    try {
      const query = `
        SELECT 
          r.id, 
          c.first_name, c.last_name, c.email, c.phone,
          res.name as restaurant_name,
          r.reservation_date, r.reservation_time, r.party_size
        FROM public.reservations r
        JOIN public.customers c ON r.customer_id = c.id
        JOIN public.restaurants res ON r.restaurant_id = res.id
        ORDER BY r.reservation_date ASC, r.reservation_time ASC;
      `;
      const result = await pool.query(query);
      res.json({ success: true, data: result.rows });
    } catch (error: any) {
      res.status(500).json({ success: false, message: error.message });
    }
  }

  static async deleteReservation(req: Request, res: Response): Promise<void> {
    const { id } = req.params;
    try {
      const result = await pool.query('DELETE FROM public.reservations WHERE id = $1', [id]);
      if (result.rowCount === 0) {
        res.status(404).json({ success: false, message: 'Nie znaleziono rezerwacji.' });
        return;
      }
      res.json({ success: true, message: 'Rezerwacja usunieta.' });
    } catch (error: any) {
      res.status(500).json({ success: false, message: error.message });
    }
  }
}