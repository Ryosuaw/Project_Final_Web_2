import React, { useState } from 'react';
import { studyClubs } from '../../data/mockData';
import './StudyClub.css';

export default function StudyClub() {
  const [clubs, setClubs] = useState(studyClubs);
  const [searchQuery, setSearchQuery] = useState('');

  const toggleJoin = (id) => {
    setClubs((prev) =>
      prev.map((club) =>
        club.id === id ? { ...club, joined: !club.joined } : club
      )
    );
  };

  const filtered = clubs.filter((c) => {
    return (
      searchQuery === '' ||
      c.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      c.topic.toLowerCase().includes(searchQuery.toLowerCase())
    );
  });

  return (
    <div className="studyclub-page">
      {/* Hero */}
      <div className="studyclub-hero animate-in">
        <div>
          <h2>📚 Study Club</h2>
          <p>
            Gabung grup belajar dan tukar ilmu mingguan bareng mentor mahasiswa.
            Kolaborasi, diskusi, dan berkembang bersama!
          </p>
        </div>
        <div className="hero-icon">📚</div>
      </div>

      {/* Filter */}
      <div className="filter-bar">
        <input
          type="text"
          placeholder="🔍 Cari study club berdasarkan nama atau topik..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <select defaultValue="">
          <option value="" disabled>📊 Urutkan</option>
          <option value="members">Anggota Terbanyak</option>
          <option value="newest">Terbaru</option>
          <option value="topic">Topik A-Z</option>
        </select>
      </div>

      {/* Grid */}
      <div className="club-grid">
        {filtered.map((club, idx) => (
          <div key={club.id} className="club-card animate-in" style={{ animationDelay: `${idx * 0.05}s` }}>
            <div className="club-accent" style={{ background: club.color }} />
            <div className="club-emoji">{club.emoji}</div>
            <h3>{club.name}</h3>
            <div className="club-desc">{club.description}</div>
            <div className="club-meta">
              <div className="club-meta-item">
                <div className="meta-icon" style={{ background: club.bgColor, color: club.color }}>
                  👥
                </div>
                {club.members} anggota
              </div>
              <div className="club-meta-item">
                <div className="meta-icon" style={{ background: club.bgColor, color: club.color }}>
                  📅
                </div>
                {club.schedule}
              </div>
              <div className="club-meta-item">
                <div className="meta-icon" style={{ background: club.bgColor, color: club.color }}>
                  📊
                </div>
                {club.level}
              </div>
            </div>
            <div className="club-tags">
              <span style={{ background: club.bgColor, color: club.color }}>{club.topic}</span>
            </div>
            <div className="club-footer">
              <button
                className={`btn-join-club ${club.joined ? 'joined' : 'join'}`}
                onClick={() => toggleJoin(club.id)}
              >
                {club.joined ? '✅ Sudah Bergabung' : '🚀 Gabung Sekarang'}
              </button>
            </div>
          </div>
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <div className="icon">📚</div>
          <h3>Tidak ada study club ditemukan</h3>
          <p>Coba ubah kata kunci pencarian.</p>
        </div>
      )}
    </div>
  );
}
