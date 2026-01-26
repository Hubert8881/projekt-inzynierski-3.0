import React from 'react';
import AdminPanel from './AdminPanel';
import AuditLogsView from './AuditLogsView';

const AdminView = () => {
  return (
    <div style={{ display: 'flex', flexDirection: 'column', gap: '40px' }}>
      <section>
        <div style={{ display: 'flex', alignItems: 'center', gap: '15px', marginBottom: '25px' }}>
          <div style={{ width: '12px', height: '35px', background: '#ff7b00', borderRadius: '6px' }}></div>
          <h2 style={{ fontSize: '2.2rem', fontWeight: '900', color: '#1e293b', margin: 0, letterSpacing: '-1.5px' }}>
            Aktywne Rezerwacje
          </h2>
        </div>
        <AdminPanel />
      </section>

      <div style={{ height: '2px', background: 'linear-gradient(90deg, rgba(226,232,240,1) 0%, rgba(226,232,240,0) 100%)', margin: '20px 0' }}></div>

      <section>
        <div style={{ display: 'flex', alignItems: 'center', gap: '15px', marginBottom: '25px' }}>
          <div style={{ width: '12px', height: '35px', background: '#64748b', borderRadius: '6px' }}></div>
          <h2 style={{ fontSize: '2.2rem', fontWeight: '900', color: '#1e293b', margin: 0, letterSpacing: '-1.5px' }}>
            Monitoring Systemu
          </h2>
        </div>
        <div style={{ 
          background: 'rgba(255, 255, 255, 0.5)', 
          backdropFilter: 'blur(10px)', 
          borderRadius: '35px', 
          padding: '20px', 
          border: '1px solid rgba(226, 232, 240, 0.8)' 
        }}>
          <AuditLogsView />
        </div>
      </section>
    </div>
  );
};

export default AdminView;