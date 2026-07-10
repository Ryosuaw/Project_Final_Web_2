import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { currentUser } from '../../data/mockData';
import './Profile.css';

export default function Profile() {
  const navigate = useNavigate();
  const [activeTab, setActiveTab] = useState('Ringkasan');
  const [toast, setToast] = useState({ show: false, message: '' });

  const showToast = (message) => {
    setToast({ show: true, message });
    setTimeout(() => {
      setToast({ show: false, message: '' });
    }, 3000);
  };

  const formattedName = currentUser.name
    .split(' ')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
    .join(' ');

  const tabs = [
    {
      id: 'Ringkasan',
      label: 'Ringkasan',
      icon: (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <rect x="3" y="3" width="7" height="7" />
          <rect x="14" y="3" width="7" height="7" />
          <rect x="3" y="14" width="7" height="7" />
          <rect x="14" y="14" width="7" height="7" />
        </svg>
      ),
    },
    {
      id: 'Skill & Exchange',
      label: 'Skill & Exchange',
      icon: (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
          <circle cx="9" cy="7" r="4" />
          <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
          <path d="M16 3.13a4 4 0 0 1 0 7.75" />
        </svg>
      ),
    },
    {
      id: 'Peluang Tersimpan',
      label: 'Peluang Tersimpan',
      icon: (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" />
        </svg>
      ),
    },
    {
      id: 'Pencapaian',
      label: 'Pencapaian',
      icon: (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <circle cx="12" cy="8" r="7" />
          <path d="M8.21 13.89L7 23l5-3 5 3-1.21-9.12" />
        </svg>
      ),
    },
    {
      id: 'Study Club',
      label: 'Study Club',
      icon: (
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
        </svg>
      ),
    },
  ];

  // Saved Opportunities state
  const [savedOpportunities, setSavedOpportunities] = useState([
    {
      id: 1,
      name: 'Djarum Beasiswa Plus 2025',
      type: 'Beasiswa',
      date: '28 Mei',
      iconClass: 'beasiswa',
    },
    {
      id: 2,
      name: 'National UX Challenge 2025',
      type: 'Kompetisi',
      date: '10 Apr',
      iconClass: 'kompetisi',
    },
    {
      id: 3,
      name: 'Beasiswa Unggulan Kemendikbud',
      type: 'Beasiswa',
      date: '15 Jul',
      iconClass: 'beasiswa',
    },
  ]);

  const handleRemoveSaved = (id, name) => {
    setSavedOpportunities(savedOpportunities.filter((o) => o.id !== id));
    showToast(`Peluang "${name}" dihapus dari daftar tersimpan.`);
  };

  // Sections definitions for clean conditional rendering
  const renderTentangSaya = () => (
    <div className="card">
      <div className="card-header">
        <div className="card-title">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
            <circle cx="12" cy="7" r="4" />
          </svg>
          Tentang Saya
        </div>
        <button className="btn-edit-small" onClick={() => navigate('/settings')}>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
            <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
          </svg>
          Edit
        </button>
      </div>
      <p className="about-text">
        Mahasiswa Teknik Informatika semester 6 di UGM yang passionate di mobile development (Flutter) dan data analytics. Aktif mencari partner untuk kolaborasi project, lomba, dan pertukaran skill.
      </p>
      <div className="about-tags">
        <span className="about-tag">Flutter Developer</span>
        <span className="about-tag">Mobile App</span>
        <span className="about-tag">Data Enthusiast</span>
        <span className="about-tag">Open to Collaborate</span>
      </div>
    </div>
  );

  const renderRiwayatSkillExchange = () => (
    <div className="card">
      <div className="card-header">
        <div className="card-title">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2" />
            <circle cx="9" cy="7" r="4" />
            <path d="M23 21v-2a4 4 0 0 0-3-3.87" />
            <path d="M16 3.13a4 4 0 0 1 0 7.75" />
          </svg>
          Riwayat Skill Exchange
        </div>
        <a href="#" className="card-link" onClick={(e) => { e.preventDefault(); navigate('/skill-exchange'); }}>
          Lihat Semua →
        </a>
      </div>

      <div className="exchange-item">
        <div className="exchange-avatar">
          <img src="https://i.pravatar.cc/100?img=3" alt="avatar" />
        </div>
        <div className="exchange-info">
          <div className="exchange-name">Budi Santoso</div>
          <div className="exchange-dept">Sistem Informasi — UI</div>
        </div>
        <div>
          <div className="exchange-skill-label">SKILL DITUKAR</div>
          <div className="exchange-skill-name">UI/UX Design</div>
        </div>
        <span className="exchange-status done">Selesai</span>
        <a href="#" className="exchange-detail" onClick={(e) => { e.preventDefault(); showToast('Membuka detail riwayat exchange dengan Budi...'); }}>
          Detail →
        </a>
      </div>

      <div className="exchange-item">
        <div className="exchange-avatar">
          <img src="https://i.pravatar.cc/100?img=9" alt="avatar" />
        </div>
        <div className="exchange-info">
          <div className="exchange-name">Siti Aminah</div>
          <div className="exchange-dept">Manajemen Bisnis — UNAIR</div>
        </div>
        <div>
          <div className="exchange-skill-label">SKILL DITUKAR</div>
          <div className="exchange-skill-name">Pitch Deck + Figma</div>
        </div>
        <span className="exchange-status active">Aktif</span>
        <a href="#" className="exchange-detail" onClick={(e) => { e.preventDefault(); showToast('Membuka detail riwayat exchange dengan Siti...'); }}>
          Detail →
        </a>
      </div>

      <div className="exchange-item">
        <div className="exchange-avatar">
          <img src="https://i.pravatar.cc/100?img=12" alt="avatar" />
        </div>
        <div className="exchange-info">
          <div className="exchange-name">Rian Wijaya</div>
          <div className="exchange-dept">DKV — Universitas Telkom</div>
        </div>
        <div>
          <div className="exchange-skill-label">SKILL DITUKAR</div>
          <div className="exchange-skill-name">Video Editing</div>
        </div>
        <span className="exchange-status done">Selesai</span>
        <a href="#" className="exchange-detail" onClick={(e) => { e.preventDefault(); showToast('Membuka detail riwayat exchange dengan Rian...'); }}>
          Detail →
        </a>
      </div>
    </div>
  );

  const renderPeluangTersimpan = () => (
    <div className="card">
      <div className="card-header">
        <div className="card-title">
          <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <path d="M19 21l-7-5-7 5V5a2 2 0 0 1 2-2h10a2 2 0 0 1 2 2z" />
          </svg>
          Peluang Tersimpan
        </div>
        <a href="#" className="card-link" onClick={(e) => { e.preventDefault(); navigate('/peluang-beasiswa'); }}>
          Lihat Semua ({savedOpportunities.length}) →
        </a>
      </div>

      {savedOpportunities.length > 0 ? (
        savedOpportunities.map((item) => (
          <div key={item.id} className="saved-item">
            <div className={`saved-icon ${item.iconClass}`}>
              {item.type === 'Beasiswa' ? (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M22 10v6M2 10l10-5 10 5-10 5z" />
                  <path d="M6 12v5c3 3 9 3 12 0v-5" />
                </svg>
              ) : (
                <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="12" cy="8" r="7" />
                  <path d="M8.21 13.89L7 23l5-3 5 3-1.21-9.12" />
                </svg>
              )}
            </div>
            <div className="saved-info">
              <div className="saved-name">{item.name}</div>
              <div className="saved-type">{item.type}</div>
            </div>
            <div className="saved-date">
              <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <rect x="3" y="4" width="18" height="18" rx="2" />
                <line x1="16" y1="2" x2="16" y2="6" />
                <line x1="8" y1="2" x2="8" y2="6" />
                <line x1="3" y1="10" x2="21" y2="10" />
              </svg>
              {item.date}
            </div>
            <button className="saved-open" onClick={() => showToast(`Membuka detail peluang "${item.name}"...`)}>
              Buka
            </button>
            <button className="saved-remove" title="Hapus" onClick={() => handleRemoveSaved(item.id, item.name)}>
              &times;
            </button>
          </div>
        ))
      ) : (
        <div style={{ textAlign: 'center', padding: '20px 0', color: '#94a3b8', fontSize: '13px' }}>
          Tidak ada peluang disimpan.
        </div>
      )}
    </div>
  );

  const renderKelengkapanProfil = () => (
    <div className="card">
      <div className="card-title" style={{ marginBottom: '16px' }}>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14" />
          <polyline points="22 4 12 14.01 9 11.01" />
        </svg>
        Kelengkapan Profil
      </div>
      <div className="completeness-header">
        <div className="completeness-pct">{currentUser.profileCompletion}%</div>
        <div className="completeness-sub">4 item tersisa</div>
      </div>
      <div className="progress-bar-lg">
        <div className="progress-fill-lg" style={{ width: `${currentUser.profileCompletion}%` }} />
      </div>
      <ul className="completeness-list">
        <li className="done">
          <span className="check">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
              <polyline points="20 6 9 17 4 12" />
            </svg>
          </span>
          Foto Profil
        </li>
        <li className="done">
          <span className="check">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
              <polyline points="20 6 9 17 4 12" />
            </svg>
          </span>
          Bio & Deskripsi
        </li>
        <li className="done">
          <span className="check">
            <svg width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
              <polyline points="20 6 9 17 4 12" />
            </svg>
          </span>
          Skill Ditambahkan
        </li>
        <li>
          <span className="plus" onClick={() => navigate('/settings')}>+</span>
          Link Portofolio
        </li>
        <li>
          <span className="plus" onClick={() => navigate('/settings')}>+</span>
          Kontak & Sosial Media
        </li>
        <li>
          <span className="plus" onClick={() => navigate('/settings')}>+</span>
          Pengalaman Organisasi
        </li>
        <li>
          <span className="plus" onClick={() => navigate('/settings')}>+</span>
          Sertifikat Diunggah
        </li>
      </ul>
    </div>
  );

  const renderStatistikProfil = () => (
    <div className="card">
      <div className="card-title" style={{ marginBottom: '16px' }}>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <line x1="18" y1="20" x2="18" y2="10" />
          <line x1="12" y1="20" x2="12" y2="4" />
          <line x1="6" y1="20" x2="6" y2="14" />
        </svg>
        Statistik Profil
      </div>
      <div className="stats-grid">
        <div className="stat-box blue">
          <div className="num">156</div>
          <div className="lbl">Dilihat</div>
        </div>
        <div className="stat-box green">
          <div className="num">5</div>
          <div className="lbl">Exchange</div>
        </div>
        <div className="stat-box purple">
          <div className="num">12</div>
          <div className="lbl">Disimpan</div>
        </div>
        <div className="stat-box orange">
          <div className="num">91%</div>
          <div className="lbl">Match Rate</div>
        </div>
      </div>
    </div>
  );

  const renderPencapaian = () => (
    <div className="card">
      <div className="card-title" style={{ marginBottom: '16px' }}>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <circle cx="12" cy="8" r="7" />
          <path d="M8.21 13.89L7 23l5-3 5 3-1.21-9.12" />
        </svg>
        Pencapaian
      </div>
      <div className="achievement-item orange">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <circle cx="12" cy="8" r="7" />
          <path d="M8.21 13.89L7 23l5-3 5 3-1.21-9.12" />
        </svg>
        Finalis GEMASTIK XVI
      </div>
      <div className="achievement-item purple">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M6 9H4.5a2.5 2.5 0 0 1 0-5H6" />
          <path d="M18 9h1.5a2.5 2.5 0 0 0 0-5H18" />
          <path d="M4 22h16" />
          <path d="M10 14.66V17c0 .55-.47.98-.97 1.21C7.85 18.75 7 20 7 22" />
          <path d="M14 14.66V17c0 .55.47.98.97 1.21C16.15 18.75 17 20 17 22" />
          <path d="M18 2H6v7a6 6 0 0 0 12 0V2Z" />
        </svg>
        Penerima Beasiswa Unggulan 2024
      </div>
      <div className="achievement-item blue">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2" />
          <circle cx="12" cy="7" r="4" />
        </svg>
        Top Contributor Study Club Q1 2025
      </div>
      <div className="achievement-item green">
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2" />
        </svg>
        5 Skill Exchange Selesai
      </div>
    </div>
  );

  const renderStudyClubSaya = () => (
    <div className="card">
      <div className="card-title" style={{ marginBottom: '16px' }}>
        <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
          <path d="M4 19.5A2.5 2.5 0 0 1 6.5 17H20" />
          <path d="M6.5 2H20v20H6.5A2.5 2.5 0 0 1 4 19.5v-15A2.5 2.5 0 0 1 6.5 2z" />
        </svg>
        Study Club Saya
      </div>
      <div className="club-item">
        <div className="club-icon blue">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <polyline points="16 18 22 12 16 6" />
            <polyline points="8 6 2 12 8 18" />
          </svg>
        </div>
        <div className="club-name">Flutter Dev Club</div>
        <button className="club-join" onClick={() => navigate('/study-club')}>Masuk</button>
      </div>
      <div className="club-item">
        <div className="club-icon purple">
          <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <circle cx="12" cy="12" r="10" />
            <path d="M8 14s1.5 2 4 2 4-2 4-2" />
            <line x1="9" y1="9" x2="9.01" y2="9" />
            <line x1="15" y1="9" x2="15.01" y2="9" />
          </svg>
        </div>
        <div className="club-name">UI/UX Design Circle</div>
        <button className="club-join" onClick={() => navigate('/study-club')}>Masuk</button>
      </div>
      <button className="btn-browse-clubs" onClick={() => navigate('/study-club')}>
        + Jelajahi Study Club Lainnya
      </button>
    </div>
  );

  return (
    <div className="profile-page">
      {/* Cover */}
      <div className="cover">
        <div className="cover-pattern"></div>
        <button className="btn-change-cover" onClick={() => showToast('Mengunggah gambar cover baru... (Fitur Demo)')}>
          <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
            <rect x="3" y="3" width="18" height="18" rx="2" />
            <circle cx="8.5" cy="8.5" r="1.5" />
            <polyline points="21 15 16 10 5 21" />
          </svg>
          Ganti Cover
        </button>
      </div>

      {/* Profile Header */}
      <div className="profile-header-section">
        <div className="profile-header-top">
          <div className="profile-avatar-wrap">
            <div className="profile-avatar">
              <img src={currentUser.avatar} alt={currentUser.name} />
            </div>
            <div className="avatar-edit" onClick={() => navigate('/settings')}>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                <path d="M23 19a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V8a2 2 0 0 1 2-2h4l2-3h6l2 3h4a2 2 0 0 1 2 2z" />
                <circle cx="12" cy="13" r="4" />
              </svg>
            </div>
          </div>
          <div className="profile-info">
            <div className="profile-name-row">
              <h1>{formattedName}</h1>
              {currentUser.verified && (
                <div className="verified-badge">
                  <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="3">
                    <polyline points="20 6 9 17 4 12" />
                  </svg>
                </div>
              )}
            </div>
            <div className="profile-university">
              {currentUser.department} &middot; {currentUser.university === 'UGM' ? 'Universitas Gadjah Mada' : currentUser.university}
            </div>
            <div className="profile-meta">
              <span>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z" />
                  <circle cx="12" cy="10" r="3" />
                </svg>
                Yogyakarta, Indonesia
              </span>
              <span>
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <rect x="3" y="4" width="18" height="18" rx="2" />
                  <line x1="16" y1="2" x2="16" y2="6" />
                  <line x1="8" y1="2" x2="8" y2="6" />
                  <line x1="3" y1="10" x2="21" y2="10" />
                </svg>
                Bergabung Maret 2023
              </span>
              <span className="match-rate">
                <svg width="13" height="13" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <path d="M20.84 4.61a5.5 5.5 0 0 0-7.78 0L12 5.67l-1.06-1.06a5.5 5.5 0 0 0-7.78 7.78l1.06 1.06L12 21.23l7.78-7.78 1.06-1.06a5.5 5.5 0 0 0 0-7.78z" />
                </svg>
                91% Match Rate
              </span>
            </div>
          </div>
          <div className="profile-actions">
            <button className="btn-share" onClick={() => {
              navigator.clipboard.writeText(window.location.href);
              showToast('Tautan profil berhasil disalin! 🔗');
            }}>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                <circle cx="18" cy="5" r="3" />
                <circle cx="6" cy="12" r="3" />
                <circle cx="18" cy="19" r="3" />
                <line x1="8.59" y1="13.51" x2="15.42" y2="17.49" />
                <line x1="15.41" y1="6.51" x2="8.59" y2="10.49" />
              </svg>
              Bagikan Profil
            </button>
            <button className="btn-edit" onClick={() => navigate('/settings')}>
              <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2.5">
                <path d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7" />
                <path d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z" />
              </svg>
              Edit Profil
            </button>
          </div>
        </div>
      </div>

      {/* Tabs */}
      <div className="tabs">
        {tabs.map((tab) => (
          <button
            key={tab.id}
            className={`tab ${activeTab === tab.id ? 'active' : ''}`}
            onClick={() => setActiveTab(tab.id)}
          >
            {tab.icon}
            {tab.label}
          </button>
        ))}
      </div>

      {/* Content */}
      <div className="profile-content">
        {activeTab === 'Ringkasan' ? (
          <>
            <div className="profile-content-left">
              {renderTentangSaya()}
              {renderRiwayatSkillExchange()}
              {renderPeluangTersimpan()}
            </div>
            <div className="profile-content-right">
              {renderKelengkapanProfil()}
              {renderStatistikProfil()}
              {renderPencapaian()}
              {renderStudyClubSaya()}
              <button className="btn-account" onClick={() => navigate('/settings')}>
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <circle cx="12" cy="12" r="3" />
                  <path d="M19.4 15a1.65 1.65 0 0 0 .33 1.82l.06.06a2 2 0 0 1 0 2.83 2 2 0 0 1-2.83 0l-.06-.06a1.65 1.65 0 0 0-1.82-.33 1.65 1.65 0 0 0-1 1.51V21a2 2 0 0 1-2 2 2 2 0 0 1-2-2v-.09A1.65 1.65 0 0 0 9 19.4a1.65 1.65 0 0 0-1.82.33l-.06.06a2 2 0 0 1-2.83 0 2 2 0 0 1 0-2.83l.06-.06a1.65 1.65 0 0 0 .33-1.82 1.65 1.65 0 0 0-1.51-1H3a2 2 0 0 1-2-2 2 2 0 0 1 2-2h.09A1.65 1.65 0 0 0 4.6 9a1.65 1.65 0 0 0-.33-1.82l-.06-.06a2 2 0 0 1 0-2.83 2 2 0 0 1 2.83 0l.06.06a1.65 1.65 0 0 0 1.82.33H9a1.65 1.65 0 0 0 1-1.51V3a2 2 0 0 1 2-2 2 2 0 0 1 2 2v.09a1.65 1.65 0 0 0 1 1.51 1.65 1.65 0 0 0 1.82-.33l.06-.06a2 2 0 0 1 2.83 0 2 2 0 0 1 0 2.83l-.06.06a1.65 1.65 0 0 0-.33 1.82V9a1.65 1.65 0 0 0 1.51 1H21a2 2 0 0 1 2 2 2 2 0 0 1-2 2h-.09a1.65 1.65 0 0 0-1.51 1z" />
                </svg>
                Pengaturan Akun
              </button>
              <button className="btn-dashboard" onClick={() => navigate('/')}>
                <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" strokeWidth="2">
                  <rect x="3" y="3" width="7" height="7" />
                  <rect x="14" y="3" width="7" height="7" />
                  <rect x="3" y="14" width="7" height="7" />
                  <rect x="14" y="14" width="7" height="7" />
                </svg>
                Kembali ke Dashboard
              </button>
            </div>
          </>
        ) : (
          <div style={{ gridColumn: 'span 2' }}>
            {activeTab === 'Skill & Exchange' && renderRiwayatSkillExchange()}
            {activeTab === 'Peluang Tersimpan' && renderPeluangTersimpan()}
            {activeTab === 'Pencapaian' && renderPencapaian()}
            {activeTab === 'Study Club' && renderStudyClubSaya()}
          </div>
        )}
      </div>

      {/* Toast Notification */}
      {toast.show && (
        <div className="toast-notification">
          <div className="icon">✓</div>
          {toast.message}
        </div>
      )}
    </div>
  );
}
