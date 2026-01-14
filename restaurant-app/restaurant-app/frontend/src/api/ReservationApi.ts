const BASE_URL = 'http://localhost:5000/api/reservations';

export async function getAvailableTables(
  restaurantId: number,
  date: string,
  time: string,
  partySize: number
) {
  const res = await fetch(
    `${BASE_URL}/available-tables?restaurant_id=${restaurantId}&date=${date}&time=${time}&party_size=${partySize}`
  );
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export async function createReservation(data: any) {
  const res = await fetch(BASE_URL, {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify(data)
  });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export async function updateReservationStatus(id: number, status: string) {
  const res = await fetch(`${BASE_URL}/${id}/status`, {
    method: 'PUT',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ status })
  });
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export async function getReservationsByDate(restaurantId: number, date: string) {
  const res = await fetch(`${BASE_URL}/by-date?restaurant_id=${restaurantId}&date=${date}`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export async function getReservation(id: number) {
  const res = await fetch(`${BASE_URL}/${id}`);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}

export async function getAllReservations() {
  const res = await fetch(BASE_URL);
  if (!res.ok) throw new Error(`HTTP ${res.status}`);
  return res.json();
}
