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

    if (!restaurant_id || !reservation_date || !reservation_time || !customer_email || !customer_first_name) {
      res.status(400).json({ success: false, message: 'Wypełnij wszystkie wymagane pola formularza.' });
      return;
    }

    const client = await pool.connect();

    try {
      await client.query('BEGIN');

      const restaurantRes = await client.query(
        'SELECT total_tables FROM public.restaurants WHERE id = $1',
        [restaurant_id]
      );
      
      const totalTables = restaurantRes.rows[0]?.total_tables ?? 10;

      const currentRes = await client.query(
        'SELECT COUNT(*) FROM public.reservations WHERE restaurant_id = $1 AND reservation_date = $2 AND reservation_time = $3',
        [restaurant_id, reservation_date, reservation_time]
      );
      const bookedTables = parseInt(currentRes.rows[0].count);

      if (bookedTables >= totalTables) {
        await client.query('ROLLBACK');
        res.status(400).json({ success: false, message: 'Brak wolnych stolików na wybraną godzinę.' });
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
      
      const reservationValues = [customerId, restaurant_id, reservation_date, reservation_time, party_size || 1];
      const result = await client.query(reservationQuery, reservationValues);

      await client.query('COMMIT');

      res.status(201).json({
        success: true,
        message: 'Rezerwacja została pomyślnie zapisana!',
        reservationId: result.rows[0].id
      });

    } catch (error: any) {
      await client.query('ROLLBACK');
      console.error('Database Error:', error);
      if (error.code === '23505') {
        res.status(400).json({ success: false, message: 'Masz już rezerwację w tym miejscu o tej porze.' });
      } else {
        res.status(500).json({ success: false, message: 'Błąd serwera podczas zapisu.' });
      }
    } finally {
      client.release();
    }
  }
}