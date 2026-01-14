import React, { useEffect, useState } from 'react';

const AdminPanel = () => {
  const [reservations, setReservations] = useState<any[]>([]);

  const fetchReservations = () => {
    fetch('http://localhost:5001/api/reservations')
      .then(res => res.json())
      .then(res => {
        if (res.success) {
          setReservations(res.data);
        }
      })
      .catch(err => console.error(err));
  };

  useEffect(() => { fetchReservations(); }, []);

  const handleDelete = (id: number) => {
    if (window.confirm('Usunąć tę rezerwację?')) {
      fetch(`http://localhost:5001/api/reservations/${id}`, { method: 'DELETE' })
        .then(() => fetchReservations())
        .catch(err => console.error(err));
    }
  };

  return (
    <div className="admin-wrapper">
      <div className="admin-card">
        <h1>Panel Administratora</h1>
        <div className="table-container">
          <table>
            <thead>
              <tr>
                <th>Klient</th>
                <th>Kontakt</th>
                <th>Restauracja</th>
                <th>Termin</th>
                <th>Osoby</th>
                <th>Akcja</th>
              </tr>
            </thead>
            <tbody>
              {reservations.length > 0 ? (
                reservations.map(r => (
                  <tr key={r.id}>
                    <td><strong>{r.first_name} {r.last_name}</strong></td>
                    <td>
                      <div className="sub-text">{r.email}</div>
                      <div className="sub-text">{r.phone}</div>
                    </td>
                    <td>{r.restaurant_name}</td>
                    <td>
                      {r.reservation_date.split('T')[0]}
                      <div className="sub-text">{r.reservation_time}</div>
                    </td>
                    <td>{r.party_size} os.</td>
                    <td>
                      <button onClick={() => handleDelete(r.id)} className="delete-btn">
                        Usuń
                      </button>
                    </td>
                  </tr>
                ))
              ) : (
                <tr>
                  <td colSpan={6} style={{ textAlign: 'center', padding: '40px' }}>
                    Brak aktywnych rezerwacji
                  </td>
                </tr>
              )}
            </tbody>
          </table>
        </div>
      </div>
    </div>
  );
};

export default AdminPanel;