import React, { useState } from 'react';

interface ReservationFormProps {
  preselectedRestaurant: any;
  onSuccess: () => void;
}

const today = new Date();
const yyyy = today.getFullYear();
const mm = String(today.getMonth() + 1).padStart(2, '0');
const dd = String(today.getDate()).padStart(2, '0');
const minDate = `${yyyy}-${mm}-${dd}`;
const maxDate = `${yyyy + 1}-12-31`;

function ReservationForm({ preselectedRestaurant, onSuccess }: ReservationFormProps) {
  const [date, setDate] = useState('');
  const [time, setTime] = useState('');
  const [partySize, setPartySize] = useState(1);
  const [name, setName] = useState('');
  const [lastName, setLastName] = useState('');
  const [email, setEmail] = useState('');
  const [phone, setPhone] = useState('');
  const [message, setMessage] = useState('');
  const [isSubmitting, setIsSubmitting] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setMessage('');
    setIsSubmitting(true);

    if (!/^\d{9}$/.test(phone)) {
      setMessage('Numer telefonu musi zawierać dokładnie 9 cyfr.');
      setIsSubmitting(false);
      return;
    }

    const reservation = {
      restaurant_id: preselectedRestaurant.id,
      reservation_date: date,
      reservation_time: time,
      party_size: partySize,
      customer_first_name: name,
      customer_last_name: lastName,
      customer_phone: '+48' + phone,
      customer_email: email,
    };

    try {
      const res = await fetch('http://localhost:5001/api/reservations', {
        method: 'POST',
        headers: {
          'Content-Type': 'application/json',
        },
        body: JSON.stringify(reservation),
      });

      const data = await res.json();

      if (data.success) {
        setMessage('Rezerwacja zakończona sukcesem!');
        setTimeout(() => {
          onSuccess();
        }, 2000);
      } else {
        setMessage(data.message || 'Wystąpił błąd podczas rezerwacji.');
      }
    } catch (error) {
      setMessage('Błąd połączenia z serwerem.');
    } finally {
      setIsSubmitting(false);
    }
  };

  return (
    <div className="reservation-form-container">
      <div className="reservation-header">
        <h2>Zarezerwuj stolik</h2>
        <p>Restauracja: <strong>{preselectedRestaurant.name}</strong></p>
      </div>

      <form onSubmit={handleSubmit}>
        <div>
          <label>Data:</label>
          <input
            type="date"
            value={date}
            min={minDate}
            max={maxDate}
            onChange={(e) => setDate(e.target.value)}
            onClick={(e) => (e.target as any).showPicker?.()}
            onFocus={(e) => (e.target as any).showPicker?.()}
            required
          />
        </div>

        <div>
          <label>Godzina:</label>
          <input
            type="time"
            value={time}
            onChange={(e) => setTime(e.target.value)}
            onClick={(e) => (e.target as any).showPicker?.()}
            onFocus={(e) => (e.target as any).showPicker?.()}
            required
          />
        </div>

        <div>
          <label>Liczba osób:</label>
          <input
            type="number"
            value={partySize}
            min={1}
            max={20}
            onChange={(e) => setPartySize(Number(e.target.value))}
            required
          />
        </div>

        <div>
          <label>Imię:</label>
          <input
            type="text"
            value={name}
            onChange={(e) => setName(e.target.value)}
            placeholder="Wpisz imię"
            required
          />
        </div>

        <div>
          <label>Nazwisko:</label>
          <input
            type="text"
            value={lastName}
            onChange={(e) => setLastName(e.target.value)}
            placeholder="Wpisz nazwisko"
            required
          />
        </div>

        <div>
          <label>Email:</label>
          <input
            type="email"
            value={email}
            onChange={(e) => setEmail(e.target.value)}
            placeholder="twoj@email.com"
            required
          />
        </div>

        <div>
          <label>Telefon:</label>
          <div className="phone-input-container">
            <span className="phone-prefix">+48</span>
            <input
              type="tel"
              value={phone}
              placeholder="123456789"
              onChange={(e) => {
                const value = e.target.value.replace(/\D/g, '');
                if (value.length <= 9) setPhone(value);
              }}
              required
            />
          </div>
        </div>

        <button type="submit" disabled={isSubmitting}>
          {isSubmitting ? 'Wysyłanie...' : 'Potwierdź rezerwację'}
        </button>

        {message && (
          <div className={`message ${message.includes('sukcesem') ? 'success' : 'error'}`}>
            {message}
          </div>
        )}
      </form>
    </div>
  );
}

export default ReservationForm;