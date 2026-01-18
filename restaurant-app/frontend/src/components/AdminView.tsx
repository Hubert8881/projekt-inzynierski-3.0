import React, { useState } from 'react';
import AdminPanel from './AdminPanel';

const AdminView = () => {
  const [isAuthenticated, setIsAuthenticated] = useState(false);
  const [password, setPassword] = useState('');
  const [error, setError] = useState('');

  const ADMIN_PASSWORD = 'admin';
  const mainOrange = '#ff7b00';

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
      <div style={{ padding: '20px' }}>
        <button onClick={() => setIsAuthenticated(false)} style={{ background: '#f1f5f9', border: 'none', padding: '10px 20px', borderRadius: '12px', cursor: 'pointer', fontWeight: '700', marginBottom: '20px' }}>← Wyloguj panel</button>
        <AdminPanel />
      </div>
    );
  }

  return (
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'center', padding: '40px 0' }}>
      <div style={{ background: 'white', padding: '40px', borderRadius: '30px', width: '100%', maxWidth: '400px', textAlign: 'center' }}>
        <div style={{ fontSize: '3rem', marginBottom: '10px' }}></div>
        <h2 style={{ fontSize: '1.8rem', fontWeight: '900', marginBottom: '10px' }}>Panel Administratora</h2>
        <form onSubmit={handleLogin}>
          <input type="password" value={password} onChange={(e) => setPassword(e.target.value)} placeholder="Hasło" style={{ width: '100%', padding: '16px', borderRadius: '16px', border: '1px solid #e2e8f0', marginBottom: '20px', outline: 'none', boxSizing: 'border-box' }} required />
          {error && <div style={{ color: '#ef4444', marginBottom: '20px', fontWeight: '600' }}>{error}</div>}
          <button type="submit" style={{ width: '100%', background: mainOrange, color: 'white', border: 'none', padding: '18px', borderRadius: '18px', fontWeight: '800', cursor: 'pointer' }}>Zaloguj się</button>
        </form>
      </div>
    </div>
  );
};

export default AdminView;