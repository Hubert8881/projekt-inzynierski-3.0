import React, { useState, useEffect } from 'react';
import ReservationForm from './components/ReservationForm';
import AdminView from './components/AdminView';
import './styles.css';

function App() {
  const [data, setData] = useState<any[]>([]);
  const [step, setStep] = useState(1);
  const [selectedRestaurant, setSelectedRestaurant] = useState<any>(null);
  const [showForm, setShowForm] = useState(false);
  const [view, setView] = useState<'user' | 'admin'>('user');

  useEffect(() => {
    fetch('http://localhost:5001/api/cities/full-data')
      .then(res => res.json())
      .then(res => {
        if (res.success) {
          setData(res.data);
        }
      })
      .catch(err => console.error(err));
  }, []);

  const handleSelectRestaurant = (restaurant: any) => {
    setSelectedRestaurant(restaurant);
    setStep(2);
  };

  if (view === 'admin') {
    return (
      <div className="app-container">
        <nav style={{ width: '100%', maxWidth: '1100px', display: 'flex', justifyContent: 'flex-start', marginBottom: '20px' }}>
          <button className="back-btn" onClick={() => setView('user')}>
            Powrot do serwisu
          </button>
        </nav>
        <AdminView />
      </div>
    );
  }

  return (
    <div className="app-container">
      <div style={{ position: 'absolute', top: '20px', right: '20px', zIndex: 10 }}>
        <button 
          onClick={() => setView('admin')}
          className="admin-login-tile"
        >
          Panel Admina
        </button>
      </div>

      {step === 1 && (
        <div className="city-grid">
          <h1>Wybierz restauracje w swoim miescie</h1>
          {data.map(city => (
            <div key={city.id} className="city-section">
              <h2>{city.name}</h2>
              <div className="restaurant-list">
                {city.restaurants?.map((r: any) => (
                  <button key={r.id} onClick={() => handleSelectRestaurant(r)}>
                    {r.name}
                  </button>
                ))}
              </div>
            </div>
          ))}
        </div>
      )}

      {step === 2 && selectedRestaurant && (
        <div className="menu-view">
          <button className="back-btn" onClick={() => { setStep(1); setShowForm(false); }}>
            Powrot do miast
          </button>
          
          <div className="menu-content">
            <h1>Menu: {selectedRestaurant.name}</h1>
            <p>{selectedRestaurant.description}</p>
            
            <ul>
              {selectedRestaurant.menu?.length > 0 ? (
                selectedRestaurant.menu.map((item: any, idx: number) => (
                  <li key={idx}>
                    <span>{item.name}</span>
                    <strong>{item.price} PLN</strong>
                  </li>
                ))
              ) : (
                <li>Brak dostepnych pozycji w menu</li>
              )}
            </ul>

            <button className="order-btn" onClick={() => setShowForm(true)}>
              Chce zarezerwowac stolik
            </button>
          </div>

          <div className={`bottom-sheet ${showForm ? 'open' : ''}`}>
            <button className="close-sheet" onClick={() => setShowForm(false)}>X</button>
            <ReservationForm 
              preselectedRestaurant={selectedRestaurant} 
              onSuccess={() => setShowForm(false)} 
            />
          </div>
        </div>
      )}
    </div>
  );
}

export default App;