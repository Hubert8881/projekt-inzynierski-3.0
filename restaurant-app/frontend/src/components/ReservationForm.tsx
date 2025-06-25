import React, { useState, useEffect } from 'react';
import { createReservation } from '../api/ReservationApi';
import { getCities } from '../api/cityApi';
import { getRestaurantsByCity } from '../api/restaurantApi';

const today = new Date();
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, '0');
const dd = String(today.getDate()).padStart(2, '0');
const minDate = `${yyyy}-${mm}-${dd}`;
const maxDate = `${yyyy + 1}-12-31`;

function ReservationForm() {
  const [date, setDate] = useState('');
  const [time, setTime] = useState('');
  const [partySize, setPartySize] = useState(1);
  const [name, setName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [message, setMessage] = useState('');
  const [cities, setCities] = useState<any[]>([]);
  const [cityId, setCityId] = useState('');
  const [restaurants, setRestaurants] = useState<any[]>([]);
  const [restaurantId, setRestaurantId] = useState('');

  useEffect(() => {
    console.log('Fetching cities...');
    getCities().then((res) => {
      console.log('getCities response:', res);
      if (res.success) {
        setCities(res.data);
      } else {
        setMessage('Nie udało się pobrać miast.');
        setCities([]);
      }
    }).catch((err) => {
      console.error('Error fetching cities:', err);
      setMessage('Błąd połączenia podczas pobierania miast.');
    });
  }, []);

  useEffect(() => {
    if (cityId) {
      console.log('Fetching restaurants for city:', cityId);
      getRestaurantsByCity(Number(cityId)).then((res) => {
        console.log('getRestaurantsByCity response:', res);
        if (res.success) {
          setRestaurants(res.data);
        } else {
          setRestaurants([]);
          setMessage('Nie udało się pobrać restauracji.');
        }
      }).catch((err) => {
        console.error('Error fetching restaurants:', err);
        setMessage('Błąd połączenia podczas pobierania restauracji.');
        setRestaurants([]);
      });
      setRestaurantId('');
    } else {
      setRestaurants([]);
      setRestaurantId('');
    }
  }, [cityId]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMessage('');

    if (!/^\d{9}$/.test(phone)) {
      setMessage('Numer telefonu musi zawierać dokładnie 9 cyfr.');
      return;
    }

    if (!cityId) {
      setMessage('Proszę wybrać miasto.');
      return;
    }

    if (!restaurantId) {
      setMessage('Proszę wybrać restaurację.');
      return;
    }

    const reservation = {
      restaurant_id: Number(restaurantId),
      city_id: Number(cityId),
      reservation_date: date,
      reservation_time: time,
      party_size: partySize,
      customer_first_name: name,
      customer_last_name: lastName,
      customer_phone: '+48' + phone,
      customer_email: email,
    };

    console.log('Submitting reservation:', reservation);

    try {
      const res = await createReservation(reservation);
      console.log('createReservation response:', res);
      if (res.success) {
        setMessage('Rezerwacja zakończona sukcesem.');
      } else {
        setMessage(res.message || 'Wystąpił błąd.');
      }
    } catch (error) {
      console.error('Error creating reservation:', error);
      setMessage('Błąd połączenia z serwerem.');
    }
  };

  return (
    <form onSubmit={handleSubmit}>
      <label>Miasto:</label>
      <select
        value={cityId}
        onChange={(e) => setCityId(e.target.value)}
        required
      >
        <option value="">-- Wybierz Miasto --</option>
        {cities.map((item) => (
          <option key={item.id} value={item.id}>
            {item.name}
          </option>
        ))}
      </select>

      <label>Restauracja:</label>
      <select
        value={restaurantId}
        onChange={(e) => setRestaurantId(e.target.value)}
        disabled={!cityId}
        required
      >
        <option value="">-- Wybierz Restaurację --</option>
        {restaurants.map((item) => (
          <option key={item.id} value={item.id}>
            {item.name}
          </option>
        ))}
      </select>

      <label>Data:</label>
      <input
        type="date"
        value={date}
        min={minDate}
        max={maxDate}
        onChange={(e) => setDate(e.target.value)}
        required
      />

      <label>Godzina:</label>
      <input
        type="time"
        value={time}
        onChange={(e) => setTime(e.target.value)}
        required
      />

      <label>Liczba osób:</label>
      <input
        type="number"
        value={partySize}
        min={1}
        onChange={(e) => setPartySize(Number(e.target.value))}
        required
      />

      <label>Imię:</label>
      <input
        type="text"
        value={name}
        onChange={(e) => setName(e.target.value)}
        required
      />

      <label>Nazwisko:</label>
      <input
        type="text"
        value={lastName}
        onChange={(e) => setLastName(e.target.value)}
        required
      />

      <label>Email:</label>
      <input
        type="email"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        required
      />

      <label>Telefon:</label>
      <div style={{ display: 'flex', alignItems: 'center', gap: '8px' }}>
        <span>+48</span>
        <input
          type="tel"
          value={phone}
          onChange={(e) => {
            const value = e.target.value.replace(/\D/g, '');
            if (value.length <= 9) setPhone(value);
          }}
          required
        />
      </div>

      <button type="submit">Zarezerwuj</button>

      {message && <div className="message">{message}</div>}
    </form>
  );
}

export default ReservationForm;