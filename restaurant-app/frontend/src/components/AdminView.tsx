import React, { useState } from 'react';
import AdminPanel from './AdminPanel';

const AdminView = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const ADMIN_PASSWORD = 'admin'; 

  const handleLogin = (e: React.FormEvent) => {
    e.preventDefault();
    if (password === ADMIN_PASSWORD) {
      setIsAuthenticated(true);
      setError('');
    } else {
      setError('Błędne hasło!');
    }
  };

  if (isAuthenticated) {
    return (
      <div className="app-container">
        <button onClick={() => setIsAuthenticated(false)} className="back-btn">
          ← Wyloguj panel
        </button>
        <AdminPanel />
      </div>
    );
  }

  return (
    <div className="app-container">
      <div className="menu-view" style={{ maxWidth: '400px', margin: '40px auto' }}>
        <h2 style={{ textAlign: 'center', marginBottom: '30px' }}>Panel Administratora</h2>
        <form onSubmit={handleLogin}>
          <div>
            <label>Hasło dostępu:</label>
            <input
              type="password"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="Wpisz hasło..."
              required
            />
          </div>
          
          {error && <div className="message error">{error}</div>}
          
          <button type="submit" className="order-btn" style={{ marginTop: '10px' }}>
            Zaloguj się
          </button>
        </form>
      </div>
    </div>
  );
};

export default AdminView;