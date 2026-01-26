import React, { useEffect, useState } from 'react';
import api from '../api';

const AuditLogsView = () => {
  const [logs, setLogs] = useState<any[]>([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const fetchLogs = async () => {
      try {
        const res = await api.get('/admin/audit-logs');
        if (res.data.success) setLogs(res.data.logs);
      } catch (err) {
        console.error('Błąd pobierania logów:', err);
      } finally {
        setLoading(false);
      }
    };
    fetchLogs();
  }, []);

  if (loading) return <div style={{ padding: '20px', textAlign: 'center', color: '#64748b' }}>Ładowanie dziennika zdarzeń...</div>;

  return (
    <div style={{ marginTop: '40px' }}>
      <h3 style={{ fontSize: '1.8rem', fontWeight: '800', marginBottom: '25px', color: '#1e293b', letterSpacing: '-1px' }}>
        Dziennik Zdarzeń (Audit Logs)
      </h3>
      <div style={{ overflowX: 'auto', background: '#f8fafc', borderRadius: '24px', padding: '10px' }}>
        <table style={{ width: '100%', borderCollapse: 'separate', borderSpacing: '0 8px' }}>
          <thead>
            <tr style={{ textAlign: 'left', color: '#64748b', fontSize: '0.9rem' }}>
              <th style={{ padding: '15px' }}>Data</th>
              <th style={{ padding: '15px' }}>Zdarzenie</th>
              <th style={{ padding: '15px' }}>Adres IP</th>
              <th style={{ padding: '15px' }}>Szczegóły</th>
              <th style={{ padding: '15px' }}>Status</th>
            </tr>
          </thead>
          <tbody>
            {logs.map((log) => (
              <tr key={log.id} style={{ background: 'white', borderRadius: '16px', boxShadow: '0 2px 10px rgba(0,0,0,0.02)' }}>
                <td style={{ padding: '15px', fontSize: '0.85rem', color: '#94a3b8', borderTopLeftRadius: '16px', borderBottomLeftRadius: '16px' }}>
                  {new Date(log.timestamp).toLocaleString()}
                </td>
                <td style={{ padding: '15px', fontWeight: '700', color: '#1e293b' }}>
                  <span style={{ fontSize: '0.75rem', padding: '4px 8px', borderRadius: '8px', background: '#f1f5f9' }}>
                    {log.event_type}
                  </span>
                </td>
                <td style={{ padding: '15px', color: '#64748b', fontFamily: 'monospace' }}>{log.ip_address}</td>
                <td style={{ padding: '15px', color: '#334155', fontSize: '0.9rem' }}>{log.details}</td>
                <td style={{ padding: '15px', borderTopRightRadius: '16px', borderBottomRightRadius: '16px' }}>
                  <span style={{ 
                    padding: '6px 12px', 
                    borderRadius: '10px', 
                    fontSize: '0.75rem', 
                    fontWeight: '800',
                    background: log.success ? '#dcfce7' : '#fee2e2',
                    color: log.success ? '#166534' : '#991b1b'
                  }}>
                    {log.success ? 'SUKCES' : 'BŁĄD'}
                  </span>
                </td>
              </tr>
            ))}
          </tbody>
        </table>
      </div>
    </div>
  );
};

export default AuditLogsView;