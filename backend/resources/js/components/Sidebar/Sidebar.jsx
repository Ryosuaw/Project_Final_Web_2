import React from 'react';
import { NavLink, useNavigate } from 'react-router-dom';
import { menuItems } from '../../data/mockData';
import './Sidebar.css';

export default function Sidebar() {
  const navigate = useNavigate();

  return (
    <aside className="sidebar">
      <div className="sidebar-label">MAIN MENU</div>

      {menuItems.map((item) => (
        <NavLink
          key={item.path}
          to={item.path}
          end={item.path === '/'}
          className={({ isActive }) =>
            `menu-item ${isActive ? 'active' : ''}`
          }
        >
          <span className="icon">{item.icon}</span>
          {item.label}
          {item.badge === 'New' && (
            <span className="badge-new">New</span>
          )}
          {item.badge && item.badge !== 'New' && (
            <span className="badge-count">{item.badge}</span>
          )}
        </NavLink>
      ))}

      <div className="study-club-card">
        <h4>🌸 Daftar Study Club</h4>
        <p>Gabung grup belajar dan tukar ilmu mingguan bareng mentor mahasiswa.</p>
        <button
          className="btn-explore"
          onClick={() => navigate('/study-club')}
        >
          Explore Groups →
        </button>
      </div>

      <div className="sidebar-bottom">
        <div className="menu-item" onClick={() => navigate('/settings')}>
          <span className="icon">⚙️</span>
          Pengaturan Akun
        </div>
        <div className="menu-item logout">
          <span className="icon">🚪</span>
          Keluar Sesi
        </div>
      </div>
    </aside>
  );
}
