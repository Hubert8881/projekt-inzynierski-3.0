import React, { useState } from 'react';

interface ReservationFormProps {
  preselectedRestaurant: any;
  onSuccess: () => void;
  cityVisual: { bg: string, neon: string };
}

const ReservationForm: React.FC<ReservationFormProps> = ({ preselectedRestaurant, onSuccess, cityVisual }) => {
  const [formData, setFormData] = useState({
    customer_first_name: '',
    customer_last_name: '',
    customer_email: '',
    customer_phone: '',
    reservation_date: new Date().toISOString().split('T')[0],
    reservation_time: '18:00',
    party_size: ''
  });
  const [loading, setLoading] = useState(false);
  const [message, setMessage] = useState<{ type: 'success' | 'error', text: string } | null>(null);

  const cityColor = cityVisual.bg.split(',')[1]?.trim().split(' ')[0] || '#ff7b00';
  const today = new Date().toISOString().split('T')[0];

  const generateTimeOptions = () => {
    const times = [];
    for (let hour = 12; hour <= 22; hour++) {
      times.push(`${hour}:00`);
      times.push(`${hour}:30`);
    }
    return times;
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    
    if (formData.customer_phone.length !== 9) {
      setMessage({ type: 'error', text: 'Numer telefonu musi mieć dokładnie 9 cyfr.' });
      return;
    }

    setLoading(true);
    setMessage(null);

    const payload = {
      restaurant_id: preselectedRestaurant.id,
      ...formData,
      party_size: parseInt(formData.party_size) || 1
    };

    try {
      const response = await fetch('http://localhost:5001/api/reservations', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(payload),
      });

      const result = await response.json();

      if (result.success) {
        setMessage({ type: 'success', text: result.message });
        setTimeout(() => onSuccess(), 2000);
      } else {
        setMessage({ type: 'error', text: result.message || 'Wystąpił błąd.' });
      }
    } catch (error) {
      setMessage({ type: 'error', text: 'Błąd połączenia z serwerem.' });
    } finally {
      setLoading(false);
    }
  };

  const inputStyle = {
    width: '100%',
    padding: '14px 18px',
    borderRadius: '14px',
    border: '1px solid #e2e8f0',
    fontSize: '0.95rem',
    fontFamily: "'Plus Jakarta Sans', sans-serif",
    outline: 'none',
    background: '#f8fafc',
    boxSizing: 'border-box' as const,
    transition: 'all 0.2s'
  };

  const labelStyle = {
    fontSize: '0.85rem',
    fontWeight: '700',
    color: '#64748b',
    marginBottom: '6px',
    display: 'block'
  };

  return (
    <div style={{ fontFamily: "'Plus Jakarta Sans', sans-serif" }}>
      <header style={{ marginBottom: '25px', textAlign: 'center' }}>
        <h2 style={{ fontSize: '1.8rem', fontWeight: '900', color: '#1a1a1a', margin: 0 }}>Rezerwacja</h2>
        <p style={{ color: cityColor, fontWeight: '700', margin: 0 }}>{preselectedRestaurant.name}</p>
      </header>

      <form onSubmit={handleSubmit} style={{ display: 'grid', gap: '15px' }}>
        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
          <div>
            <label style={labelStyle}>Imię</label>
            <input type="text" required style={inputStyle} value={formData.customer_first_name} onChange={(e) => setFormData({ ...formData, customer_first_name: e.target.value })} />
          </div>
          <div>
            <label style={labelStyle}>Nazwisko</label>
            <input type="text" required style={inputStyle} value={formData.customer_last_name} onChange={(e) => setFormData({ ...formData, customer_last_name: e.target.value })} />
          </div>
        </div>

        <div>
          <label style={labelStyle}>Adres Email</label>
          <input type="email" required placeholder="jan@kowalski.pl" style={inputStyle} value={formData.customer_email} onChange={(e) => setFormData({ ...formData, customer_email: e.target.value })} />
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '15px' }}>
          <div>
            <label style={labelStyle}>Data</label>
            <input type="date" required min={today} style={inputStyle} value={formData.reservation_date} onChange={(e) => setFormData({ ...formData, reservation_date: e.target.value })} />
          </div>
          <div>
            <label style={labelStyle}>Godzina</label>
            <select style={inputStyle} value={formData.reservation_time} onChange={(e) => setFormData({ ...formData, reservation_time: e.target.value })}>
              {generateTimeOptions().map(time => <option key={time} value={time}>{time}</option>)}
            </select>
          </div>
        </div>

        <div style={{ display: 'grid', gridTemplateColumns: '1fr 1.5fr', gap: '15px' }}>
          <div>
            <label style={labelStyle}>Liczba gości</label>
            <input type="number" required min="1" max="20" placeholder="0" style={inputStyle} value={formData.party_size} onChange={(e) => setFormData({ ...formData, party_size: e.target.value })} />
          </div>
          <div>
            <label style={labelStyle}>Numer telefonu</label>
            <div style={{ display: 'flex', position: 'relative', alignItems: 'center' }}>
              <span style={{ position: 'absolute', left: '15px', fontWeight: '700', color: '#64748b', borderRight: '1px solid #e2e8f0', paddingRight: '10px' }}>+48</span>
              <input 
                type="tel" 
                required 
                placeholder="9 cyfr" 
                pattern="[0-9]{9}"
                minLength={9}
                maxLength={9}
                style={{ ...inputStyle, paddingLeft: '65px' }} 
                value={formData.customer_phone} 
                onChange={(e) => {
                  const val = e.target.value.replace(/\D/g, '').slice(0, 9);
                  setFormData({ ...formData, customer_phone: val });
                }} 
              />
            </div>
          </div>
        </div>

        {message && (
          <div style={{ 
            padding: '12px', 
            borderRadius: '12px', 
            textAlign: 'center', 
            fontWeight: '600', 
            background: message.type === 'success' ? '#f0fdf4' : '#fef2f2', 
            color: message.type === 'success' ? '#166534' : '#991b1b',
            border: `1px solid ${message.type === 'success' ? '#bbf7d0' : '#fecaca'}`
          }}>
            {message.text}
          </div>
        )}

        <button 
          type="submit" 
          disabled={loading} 
          style={{ 
            marginTop: '5px', 
            padding: '18px', 
            borderRadius: '16px', 
            border: 'none', 
            background: cityVisual.bg,
            color: 'white', 
            fontSize: '1.1rem', 
            fontWeight: '800', 
            cursor: loading ? 'not-allowed' : 'pointer', 
            boxShadow: cityVisual.neon 
          }}
        >
          {loading ? 'Przetwarzanie...' : 'Zatwierdź Rezerwację'}
        </button>
      </form>
    </div>
  );
};

export default ReservationForm;