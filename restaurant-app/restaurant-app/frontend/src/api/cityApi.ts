const BASE = 'http://localhost:5000/api/cities';
export async function getCities() {
  const res = await fetch(BASE);
  return res.json();
}
