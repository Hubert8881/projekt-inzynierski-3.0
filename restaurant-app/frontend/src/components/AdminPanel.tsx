import React, { useEffect, useState } from 'react';

const AdminPanel = () => {
  const [reservations, setReservations] = useState<any[]>([]);
  const mainOrange = '#ff7b00';

  const fetchReservations = () => {
    const token = localStorage.getItem('adminToken');
    fetch('http://localhost:5001/api/reservations', {
      headers: {
        'Authorization': `Bearer ${token}`
      }
    })
      .then(res => res.json())
      .then(res => {
        if (res.success) setReservations(res.data);
      })
      .catch(err => console.error(err));
  };

  useEffect(() => { fetchReservations(); }, []);

  const handleDelete = (id: number) => {
    if (window.confirm('Czy na pewno chcesz usunąć tę rezerwację?')) {
      const token = localStorage.getItem('adminToken');
      fetch(`http://localhost:5001/api/reservations/${id}`, { 
        method: 'DELETE',
        headers: {
          'Authorization': `Bearer ${token}`
        }
      })
        .then(() => fetchReservations())
        .catch(err => console.error(err));
    }
  };

  const GRID_LAYOUT = 'minmax(200px, 1.5fr) minmax(180px, 1.2fr) minmax(160px, 1.2fr) minmax(100px, 1fr) 120px';

  const headerStyle = {
    display: 'grid',
    gridTemplateColumns: GRID_LAYOUT,
    gap: '40px',
    padding: '15px 25px',
    color: '#94a3b8',
    fontWeight: '700',
    fontSize: '0.75rem',
    textTransform: 'uppercase' as const,
    letterSpacing: '1px',
    borderBottom: '1px solid #f1f5f9',
    marginBottom: '10px'
  };

  const cardStyle = {
    background: '#ffffff',
    borderRadius: '20px',
    padding: '20px 25px',
    marginBottom: '12px',
    display: 'grid',
    gridTemplateColumns: GRID_LAYOUT,
    gap: '40px',
    alignItems: 'center',
    border: '1px solid #f1f5f9',
    boxShadow: '0 4px 12px rgba(0,0,0,0.03)'
  };

  return (
    <div style={{ fontFamily: "'Plus Jakarta Sans', sans-serif", width: '100%', overflowX: 'auto' }}>
      <div style={{ minWidth: '1000px' }}>
        <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '30px' }}>
          <h1 style={{ fontSize: '1.8rem', fontWeight: '900', color: '#1a1a1a', margin: 0 }}>Panel Rezerwacji</h1>
          <div style={{ background: '#fff7ed', color: mainOrange, padding: '8px 20px', borderRadius: '12px', fontWeight: '800' }}>
            Aktywne: {reservations.length}
          </div>
        </div>

        <div style={headerStyle}>
          <div>Dane kontaktowe</div>
          <div>Restauracja</div>
          <div>Data</div>
          <div>Ilość gości</div>
          <div style={{ textAlign: 'right' }}>Akcja</div>
        </div>

        <div style={{ display: 'grid' }}>
          {reservations.length > 0 ? (
            reservations.map(r => (
              <div key={r.id} style={cardStyle}>
                <div style={{ overflow: 'hidden' }}>
                  <div style={{ fontWeight: '800', color: '#1a1a1a', fontSize: '1rem', whiteSpace: 'nowrap', textOverflow: 'ellipsis' }}>
                    {r.first_name} {r.last_name}
                  </div>
                  <div style={{ color: mainOrange, fontWeight: '700', fontSize: '0.85rem' }}>
                    {r.phone}
                  </div>
                </div>

                <div style={{ fontWeight: '700', color: '#334155', whiteSpace: 'nowrap', textOverflow: 'ellipsis', overflow: 'hidden' }}>
                  {r.restaurant_name}
                </div>

                <div>
                  <div style={{ fontWeight: '700', color: '#1a1a1a' }}>
                    {r.reservation_date ? new Date(r.reservation_date).toLocaleDateString() : 'Brak daty'}
                  </div>
                  <div style={{ color: '#64748b', fontWeight: '600', fontSize: '0.85rem' }}>
                    {r.reservation_time}
                  </div>
                </div>

                <div style={{ fontWeight: '800', color: '#1a1a1a', fontSize: '1.1rem' }}>
                  {r.party_size} os.
                </div>

                <div style={{ textAlign: 'right' }}>
                  <button 
                    onClick={() => handleDelete(r.id)} 
                    style={{ 
                      background: '#fef2f2', 
                      color: '#ef4444', 
                      border: 'none', 
                      padding: '10px 18px', 
                      borderRadius: '12px', 
                      fontWeight: '800', 
                      cursor: 'pointer',
                      transition: 'background 0.2s'
                    }}
                  >
                    Usuń
                  </button>
                </div>
              </div>
            ))
          ) : (
            <div style={{ 
              textAlign: 'center', 
              padding: '80px 0', 
              color: '#94a3b8', 
              background: 'white', 
              borderRadius: '30px',
              border: '2px dashed #f1f5f9'
            }}>
              Brak aktywnych rezerwacji.
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default AdminPanel;