import React, { useState, useEffect } from 'react';
import { getAvailableTables } from '../api/ReservationApi';
import { getCities } from '../api/cityApi';
import { getRestaurantsByCity } from '../api/restaurantApi';

interface Restaurant {
  id: number;
  name: string;
}

interface City {
  id: number;
  name: string;
}

interface Table {
  table_id: number;
  table_number: number;
  capacity: number;
  is_available: boolean;
}

const AvailableTables: React.FC = () => {
  const [cities, setCities] = useState<City[]>([]);
  const [cityId, setCityId] = useState<number | ''>('');
  const [restaurants, setRestaurants] = useState<Restaurant[]>([]);
  const [restaurantId, setRestaurantId] = useState<number | ''>('');
  const [date, setDate] = useState('');
  const [time, setTime] = useState('');
  const [partySize, setPartySize] = useState(1);
  const [availableTables, setAvailableTables] = useState<Table[] | null>(null);
  const [error, setError] = useState('');
  const [loading, setLoading] = useState(false);

  const today = new Date();
  const maxDate = new Date(today.getFullYear() + 1, 11, 31).toISOString().split('T')[0];

  useEffect(() => {
    getCities()
      .then(res => {
        if (res.success) setCities(res.data);
        else setCities([]);
      })
      .catch(() => setCities([]));
  }, []);

  useEffect(() => {
    if (cityId) {
      getRestaurantsByCity(Number(cityId))
        .then(res => {
          if (res.success) setRestaurants(res.data);
          else setRestaurants([]);
        })
        .catch(() => setRestaurants([]));
      setRestaurantId('');
    } else {
      setRestaurants([]);
      setRestaurantId('');
    }
  }, [cityId]);

  const handleCheck = async () => {
    setError('');
    setAvailableTables(null);

    if (!cityId) {
      setError('Proszę wybrać miasto.');
      return;
    }
    if (!restaurantId) {
      setError('Proszę wybrać restaurację.');
      return;
    }
    if (!date) {
      setError('Proszę wybrać datę.');
      return;
    }
    if (!time) {
      setError('Proszę wybrać godzinę.');
      return;
    }
    if (partySize < 1) {
      setError('Liczba osób musi być co najmniej 1.');
      return;
    }

    setLoading(true);
    try {
      const result = await getAvailableTables(Number(restaurantId), date, time, partySize);
      if (result && result.data && Array.isArray(result.data.available_tables)) {
        setAvailableTables(result.data.available_tables.filter((t: { is_available: any; }) => t.is_available));
      } else {
        setError('Nieprawidłowa odpowiedź z serwera.');
      }
    } catch {
      setError('Błąd podczas pobierania danych');
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      <h2>Sprawdź dostępne stoliki</h2>

      <label>Miasto:</label>
      <select value={cityId} onChange={(e) => setCityId(Number(e.target.value))} required>
        <option value="">-- Wybierz Miasto --</option>
        {cities.map(city => (
          <option key={city.id} value={city.id}>{city.name}</option>
        ))}
      </select>

      <label>Restauracja:</label>
      <select
        value={restaurantId}
        onChange={(e) => setRestaurantId(Number(e.target.value))}
        disabled={!cityId}
        required
      >
        <option value="">-- Wybierz Restaurację --</option>
        {restaurants.map(r => (
          <option key={r.id} value={r.id}>{r.name}</option>
        ))}
      </select>

      <label>Data:</label>
      <input
        type="date"
        value={date}
        onChange={(e) => setDate(e.target.value)}
        min={today.toISOString().split('T')[0]}
        max={maxDate}
      />

      <label>Godzina:</label>
      <input
        type="time"
        value={time}
        onChange={(e) => setTime(e.target.value)}
      />

      <label>Liczba osób:</label>
      <input
        type="number"
        value={partySize}
        onChange={(e) => setPartySize(Number(e.target.value))}
        min={1}
      />

      <button onClick={handleCheck} disabled={loading}>
        {loading ? 'Sprawdzanie...' : 'Sprawdź'}
      </button>

      {availableTables !== null && !error && (
        <div>
          <h3>Dostępne stoliki:</h3>
          {availableTables.length > 0 ? (
            <ul>
              {availableTables.map(table => (
                <li key={table.table_id}>
                  Stolika nr {table.table_number}, pojemność: {table.capacity}
                </li>
              ))}
            </ul>
          ) : (
            <p>Brak dostępnych stolików dla podanych parametrów.</p>
          )}
        </div>
      )}

      {error && <div className="message error">{error}</div>}
    </div>
  );
};

export default AvailableTables;