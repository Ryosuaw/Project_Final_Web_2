import React from 'react';
import { useNavigate } from 'react-router-dom';
import StatCard from '../../components/StatCard/StatCard';
import PeluangCard from '../../components/PeluangCard/PeluangCard';
import PartnerCard from '../../components/PartnerCard/PartnerCard';
import ProfileCard from '../../components/ProfileCard/ProfileCard';
import ActivityCard from '../../components/ActivityCard/ActivityCard';
import {
  currentUser,
  dashboardStats,
  peluangList,
  partnerList,
} from '../../data/mockData';
import './Dashboard.css';

export default function Dashboard() {
  const navigate = useNavigate();

  const formattedName = currentUser.name
    .split(' ')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
    .join(' ');

  return (
    <div className="dashboard-page">
      {/* Welcome */}
      <div className="welcome-row">
        <div>
          <h1>Selamat datang kembali, {formattedName}!</h1>
          <p>
            Ada 3 partner request baru & 5 peluang yang cocok dengan skill kamu
            hari ini.
          </p>
        </div>
        <div className="welcome-buttons">
          <button
            className="btn btn-secondary"
            onClick={() => navigate('/skill-exchange')}
          >
            <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            Cari Partner
          </button>
          <button
            className="btn btn-primary"
            onClick={() => navigate('/peluang-beasiswa')}
          >
            <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" d="M12 14l9-5-9-5-9 5 9 5z" />
              <path strokeLinecap="round" strokeLinejoin="round" d="M12 14l6.16-3.422a12.083 12.083 0 01.665 6.479A11.952 11.952 0 0012 20.055a11.952 11.952 0 00-6.824-2.998 12.078 12.078 0 01.665-6.479L12 14z" />
            </svg>
            Lihat Peluang
          </button>
        </div>
      </div>

      {/* Stats */}
      <div className="stats-row">
        {dashboardStats.map((stat, i) => (
          <StatCard key={i} {...stat} />
        ))}
      </div>

      {/* Content Grid */}
      <div className="content-grid">
        <div className="content-left">
          {/* Peluang Terbaru */}
          <div className="section-card">
            <div className="section-header">
              <h2>
                <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24" style={{ color: 'var(--warning)', marginRight: '8px', verticalAlign: 'middle', width: '20px', height: '20px', display: 'inline-block' }}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9" />
                </svg>
                Peluang Terbaru Untukmu
              </h2>
              <a href="#" onClick={(e) => { e.preventDefault(); navigate('/peluang-beasiswa'); }}>
                Lihat Semua →
              </a>
            </div>
            <div className="peluang-grid">
              {peluangList.slice(0, 3).map((peluang) => (
                <PeluangCard key={peluang.id} data={peluang} />
              ))}
            </div>
          </div>

          {/* Partner Terbaik */}
          <div className="section-card">
            <div className="section-header">
              <h2>
                <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24" style={{ color: 'var(--primary)', marginRight: '8px', verticalAlign: 'middle', width: '20px', height: '20px', display: 'inline-block' }}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M17 20h5v-2a3 3 0 00-5.356-1.857M17 20H7m10 0v-2c0-.656-.126-1.283-.356-1.857M7 20H2v-2a3 3 0 015.356-1.857M7 20v-2c0-.656.126-1.283.356-1.857m0 0a5.002 5.002 0 019.288 0M15 7a3 3 0 11-6 0 3 3 0 016 0z" />
                </svg>
                Partner Terbaik Untukmu
              </h2>
              <a href="#" onClick={(e) => { e.preventDefault(); navigate('/skill-exchange'); }}>
                Skill Exchange →
              </a>
            </div>
            <div className="partner-grid">
              {partnerList.slice(0, 2).map((partner) => (
                <PartnerCard key={partner.id} data={partner} />
              ))}
            </div>
          </div>
        </div>

        {/* Right Sidebar */}
        <div className="content-right">
          <ProfileCard />
          <ActivityCard />
        </div>
      </div>
    </div>
  );
}
