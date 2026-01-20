import React, { useState, useEffect } from 'react';
import ReservationForm from './components/ReservationForm';
import AdminView from './components/AdminView';
import './styles.css';

const getCityVisuals = (cityName: string) => {
  const visuals: { [key: string]: { bg: string, neon: string } } = {
    'Gdańsk': { bg: 'linear-gradient(135deg, #00f2ff 0%, #0072ff 100%)', neon: '0 0 25px rgba(0, 242, 255, 0.5)' },
    'Kraków': { bg: 'linear-gradient(135deg, #ff0055 0%, #990033 100%)', neon: '0 0 25px rgba(255, 0, 85, 0.5)' },
    'Poznań': { bg: 'linear-gradient(135deg, #00ff88 0%, #009955 100%)', neon: '0 0 25px rgba(0, 255, 136, 0.5)' },
    'Warszawa': { bg: 'linear-gradient(135deg, #bc13fe 0%, #7a0bc0 100%)', neon: '0 0 25px rgba(188, 19, 254, 0.5)' },
    'Toruń': { bg: 'linear-gradient(135deg, #ffcc00 0%, #ff8800 100%)', neon: '0 0 25px rgba(255, 204, 0, 0.5)' }
  };
  return visuals[cityName] || { bg: 'linear-gradient(135deg, #ff7b00 0%, #ff4500 100%)', neon: '0 0 20px rgba(255, 123, 0, 0.4)' };
};

function App() {
  const [data, setData] = useState<any[]>([]);
  const [step, setStep] = useState(0); 
  const [selectedCity, setSelectedCity] = useState<any>(null);
  const [selectedRestaurant, setSelectedRestaurant] = useState<any>(null);
  const [showForm, setShowForm] = useState(false);
  const [view, setView] = useState<'user' | 'admin'>('user');
  const [adminToken, setAdminToken] = useState<string | null>(localStorage.getItem('adminToken'));
  const [adminPassword, setAdminPassword] = useState('');

  const mainOrange = '#ff7b00';

  useEffect(() => {
    fetch('http://localhost:5001/api/cities/full-data')
      .then(res => res.json())
      .then(res => {
        if (res.success) setData(res.data);
      })
      .catch(err => console.error(err));
  }, []);

  const handleLogin = async (e?: React.FormEvent) => {
    if (e) e.preventDefault();
    try {
      const res = await fetch('http://localhost:5001/api/login', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ password: adminPassword })
      });
      
      const result = await res.json();

      if (!res.ok) {
        alert(result.message || 'Błędne hasło administratora');
        return;
      }

      if (result.success) {
        localStorage.setItem('adminToken', result.token);
        setAdminToken(result.token);
        setAdminPassword('');
        setView('admin');
      }
    } catch (err) {
      alert('Błąd połączenia z serwerem. Upewnij się, że backend działa.');
    }
  };

  const handleLogout = () => {
    localStorage.removeItem('adminToken');
    setAdminToken(null);
    setView('user');
  };

  const handleSelectCity = (city: any) => {
    setSelectedCity(city);
    setStep(1);
  };

  const handleSelectRestaurant = (restaurant: any) => {
    setSelectedRestaurant(restaurant);
    setStep(2);
  };

  if (view === 'admin') {
    if (!adminToken) {
      return (
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', minHeight: '100vh', background: '#f8fafc' }}>
          <div style={{ background: 'white', padding: '40px', borderRadius: '30px', width: '100%', maxWidth: '400px', textAlign: 'center', boxShadow: '0 20px 40px rgba(0,0,0,0.05)' }}>
            <h2 style={{ fontSize: '1.8rem', fontWeight: '900', marginBottom: '10px' }}>Panel Administratora</h2>
            <form onSubmit={handleLogin}>
              <input 
                type="password" 
                value={adminPassword} 
                onChange={(e) => setAdminPassword(e.target.value)} 
                placeholder="Hasło" 
                style={{ width: '100%', padding: '16px', borderRadius: '16px', border: '1px solid #e2e8f0', marginBottom: '20px', outline: 'none', boxSizing: 'border-box' }} 
                required 
              />
              <button type="submit" style={{ width: '100%', background: mainOrange, color: 'white', border: 'none', padding: '18px', borderRadius: '18px', fontWeight: '800', cursor: 'pointer', marginBottom: '10px' }}>Zaloguj się</button>
              <button type="button" onClick={() => setView('user')} style={{ width: '100%', background: '#f1f5f9', color: '#64748b', border: 'none', padding: '12px', borderRadius: '18px', fontWeight: '700', cursor: 'pointer' }}>Anuluj</button>
            </form>
          </div>
        </div>
      );
    }

    return (
      <div className="app-container" style={{ background: '#f8fafc', minHeight: '100vh', padding: '40px 20px' }}>
        <div style={{ maxWidth: '1200px', margin: '0 auto' }}>
          <nav style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '30px', background: 'white', padding: '20px 30px', borderRadius: '24px', boxShadow: '0 4px 20px rgba(0,0,0,0.05)' }}>
            <h2 style={{ color: '#1e293b', margin: 0, fontWeight: '800', letterSpacing: '-1px' }}>System Panel</h2>
            <div style={{ display: 'flex', gap: '10px' }}>
              <button onClick={handleLogout} style={{ background: '#ef4444', color: 'white', border: 'none', padding: '12px 24px', borderRadius: '14px', fontWeight: '600', cursor: 'pointer' }}>Wyloguj</button>
              <button className="back-btn" onClick={() => setView('user')} style={{ background: '#1e293b', color: 'white', border: 'none', padding: '12px 24px', borderRadius: '14px', fontWeight: '600', cursor: 'pointer' }}>Wróć do serwisu</button>
            </div>
          </nav>
          <div style={{ background: 'white', borderRadius: '32px', padding: '40px', boxShadow: '0 20px 40px rgba(0,0,0,0.04)' }}>
            <AdminView />
          </div>
        </div>
      </div>
    );
  }

  const currentCityVisual = selectedCity ? getCityVisuals(selectedCity.name) : getCityVisuals('');
  const cityColor = currentCityVisual.bg.split(',')[1]?.trim().split(' ')[0] || '#ff7b00';

  return (
    <div className="app-container" style={{ minHeight: '100vh', paddingBottom: '100px', position: 'relative' }}>
      <div className="modern-mascot left">
        <div className="character-wrapper">
          <svg viewBox="0 0 200 200" className="character-svg">
            <circle cx="100" cy="100" r="90" fill={cityColor} fillOpacity="0.1" />
            <text x="50%" y="60%" fontSize="100" textAnchor="middle" dominantBaseline="middle">👨‍🍳</text>
          </svg>
          <div className="food-bubble">🍕</div>
        </div>
      </div>
      <div className="modern-mascot right">
        <div className="character-wrapper">
          <svg viewBox="0 0 200 200" className="character-svg">
            <circle cx="100" cy="100" r="90" fill={cityColor} fillOpacity="0.1" />
            <text x="50%" y="60%" fontSize="100" textAnchor="middle" dominantBaseline="middle">👩‍💻</text>
          </svg>
          <div className="food-bubble">🍹</div>
        </div>
      </div>
      <button 
        onClick={() => setView('admin')} 
        style={{ position: 'fixed', top: '25px', right: '25px', zIndex: 100, background: 'rgba(255,255,255,0.9)', backdropFilter: 'blur(10px)', border: '1px solid #eee', padding: '10px 20px', borderRadius: '50px', fontWeight: '700', cursor: 'pointer', color: '#64748b', boxShadow: '0 4px 12px rgba(0,0,0,0.05)' }}
      >
        Admin Access
      </button>
      {step === 0 && (
        <div className="city-selection" style={{ padding: '80px 20px', maxWidth: '1200px', margin: '0 auto' }}>
          <div style={{ textAlign: 'center', marginBottom: '60px' }}>
            <h1 style={{ fontSize: '3.5rem', fontWeight: '900', color: '#ff7b00', margin: 0, letterSpacing: '-2px', textTransform: 'uppercase' }}>
              Gdzie chcesz zjeść?
            </h1>
            <p style={{ fontSize: '1.1rem', color: '#64748b', fontWeight: '500' }}>Wybierz miasto i odkryj najlepsze smaki.</p>
          </div>
          <div className="city-grid-main" style={{ display: 'grid', gridTemplateColumns: 'repeat(auto-fit, minmax(220px, 1fr))', gap: '25px' }}>
            {data.map(city => {
              const visual = getCityVisuals(city.name);
              return (
                <div 
                  key={city.id} 
                  style={{ 
                    background: city.image_url ? `url(${city.image_url}) center/cover no-repeat` : visual.bg,
                    height: '240px',
                    borderRadius: '30px',
                    position: 'relative',
                    overflow: 'hidden',
                    boxShadow: visual.neon,
                    display: 'flex',
                    alignItems: 'flex-end',
                    transition: 'all 0.3s ease-in-out',
                    border: '1px solid rgba(255,255,255,0.2)'
                  }}
                  className="city-card-hover"
                >
                  <div style={{ position: 'absolute', inset: 0, background: 'linear-gradient(to top, rgba(0,0,0,0.6) 0%, transparent 70%)' }} />
                  <div style={{ width: '100%', padding: '15px', background: 'rgba(255,255,255,0.1)', backdropFilter: 'blur(10px)', display: 'flex', justifyContent: 'space-between', alignItems: 'center', borderTop: '1px solid rgba(255,255,255,0.2)' }}>
                    <h2 style={{ color: 'white', fontSize: '1.3rem', fontWeight: '800', margin: 0 }}>{city.name}</h2>
                    <button 
                      onClick={() => handleSelectCity(city)}
                      style={{ background: 'white', color: '#1a1a1a', border: 'none', padding: '8px 16px', borderRadius: '12px', fontWeight: '700', cursor: 'pointer', fontSize: '0.85rem' }}
                    >
                      ODKRYJ
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      )}
      {step === 1 && selectedCity && (
        <div style={{ padding: '80px 20px', maxWidth: '800px', margin: '0 auto' }}>
          <button onClick={() => setStep(0)} style={{ border: 'none', background: 'white', padding: '12px 24px', borderRadius: '15px', fontWeight: '700', cursor: 'pointer', color: '#64748b', boxShadow: '0 4px 12px rgba(0,0,0,0.05)', marginBottom: '40px' }}>
            ← Powrót do miast
          </button>
          <h1 style={{ fontSize: '3.5rem', fontWeight: '900', color: '#1e293b', marginBottom: '40px', letterSpacing: '-2px' }}>
            Restauracje: <span style={{ color: cityColor }}>{selectedCity.name}</span>
          </h1>
          <div style={{ display: 'grid', gap: '20px' }}>
            {selectedCity.restaurants?.map((r: any) => (
              <div 
                key={r.id} 
                onClick={() => handleSelectRestaurant(r)}
                style={{ 
                  background: 'white', 
                  padding: '35px', 
                  borderRadius: '30px', 
                  cursor: 'pointer', 
                  display: 'flex', 
                  justifyContent: 'space-between', 
                  alignItems: 'center', 
                  boxShadow: currentCityVisual.neon, 
                  border: `1px solid ${cityColor}33`, 
                  transition: '0.3s' 
                }}
              >
                <span style={{ fontSize: '1.6rem', fontWeight: '800', color: '#1e293b' }}>{r.name}</span>
                <span style={{ background: currentCityVisual.bg, color: 'white', padding: '10px 20px', borderRadius: '12px', fontWeight: '700' }}>Wybierz →</span>
              </div>
            ))}
          </div>
        </div>
      )}
      {step === 2 && selectedRestaurant && (
        <div style={{ padding: '60px 20px', maxWidth: '1200px', margin: '0 auto', display: 'grid', gridTemplateColumns: '1.2fr 1fr', gap: '50px' }}>
          <div>
            <button onClick={() => setStep(1)} style={{ border: 'none', background: 'none', fontWeight: '700', color: '#64748b', cursor: 'pointer', marginBottom: '20px' }}>← Wróć do listy</button>
            <h1 style={{ fontSize: '4.5rem', fontWeight: '900', color: '#1e293b', margin: '0 0 20px 0', letterSpacing: '-3px' }}>{selectedRestaurant.name}</h1>
            <p style={{ fontSize: '1.3rem', color: '#64748b', lineHeight: '1.6', marginBottom: '50px' }}>{selectedRestaurant.description}</p>
            <div style={{ background: 'white', padding: '50px', borderRadius: '45px', boxShadow: currentCityVisual.neon, border: `1px solid ${cityColor}22` }}>
              <h3 style={{ fontSize: '1.8rem', fontWeight: '800', marginBottom: '40px', borderBottom: `4px solid ${cityColor}`, paddingBottom: '20px' }}>Karta Dań</h3>
              {selectedRestaurant.menu?.map((item: any, idx: number) => (
                <div key={idx} style={{ display: 'flex', justifyContent: 'space-between', padding: '25px 0', borderBottom: '1px solid #f1f5f9' }}>
                  <span style={{ fontSize: '1.2rem', fontWeight: '600', color: '#334155' }}>{item.name}</span>
                  <span style={{ color: cityColor, fontWeight: '900', fontSize: '1.2rem' }}>{item.price} PLN</span>
                </div>
              ))}
            </div>
          </div>
          <div style={{ position: 'sticky', top: '40px', height: 'fit-content' }}>
            <div style={{ background: '#1e293b', padding: '60px', borderRadius: '50px', color: 'white', boxShadow: `0 40px 80px rgba(0,0,0,0.2)`, border: `2px solid ${cityColor}` }}>
              <h2 style={{ fontSize: '2.5rem', fontWeight: '800', marginBottom: '20px', letterSpacing: '-1px' }}>Zarezerwuj stolik</h2>
              <p style={{ fontSize: '1.1rem', opacity: 0.7, marginBottom: '40px' }}>Zarezerwuj miejsce w kilka sekund i ciesz się wyjątkową kolacją.</p>
              <button 
                onClick={() => setShowForm(true)}
                style={{ width: '100%', background: currentCityVisual.bg, color: 'white', border: 'none', padding: '25px', borderRadius: '22px', fontSize: '1.4rem', fontWeight: '800', cursor: 'pointer', boxShadow: currentCityVisual.neon }}
              >
                Rezerwuj teraz
              </button>
            </div>
          </div>
          {showForm && (
            <div style={{ position: 'fixed', inset: 0, background: 'rgba(15, 23, 42, 0.6)', backdropFilter: 'blur(15px)', zIndex: 1000, display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '20px' }}>
              <div style={{ background: 'white', width: '100%', maxWidth: '650px', borderRadius: '50px', padding: '60px', position: 'relative', maxHeight: '90vh', overflowY: 'auto', boxShadow: '0 50px 100px rgba(0,0,0,0.3)' }}>
                <button 
                  onClick={() => setShowForm(false)} 
                  style={{ 
                    position: 'absolute', 
                    top: '30px', 
                    right: '30px', 
                    background: '#1a1a1a', 
                    color: 'white',
                    border: 'none', 
                    width: '50px', 
                    height: '50px', 
                    borderRadius: '50%', 
                    cursor: 'pointer', 
                    fontSize: '1.5rem', 
                    display: 'flex',
                    alignItems: 'center',
                    justifyContent: 'center',
                    boxShadow: '0 10px 20px rgba(0,0,0,0.2)',
                    zIndex: 10
                  }}
                >
                  ✕
                </button>
                <ReservationForm 
                  preselectedRestaurant={selectedRestaurant} 
                  onSuccess={() => setShowForm(false)} 
                  cityVisual={currentCityVisual}
                />
              </div>
            </div>
          )}
        </div>
      )}
    </div>
  );
}

export default App;