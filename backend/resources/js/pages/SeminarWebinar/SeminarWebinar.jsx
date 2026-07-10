import React, { useState } from 'react';
import './SeminarWebinar.css';

const seminarData = [
  {
    id: 1,
    title: 'Webinar: Flutter UI Slicing Pro',
    speaker: 'Rizky Pratama',
    org: 'NOERA Study Club',
    tags: ['Flutter', 'Online', 'Gratis'],
    date: '12 Mar 2025',
    time: '19:00 - 21:00 WIB',
    slots: { total: 200, filled: 156 },
    free: true,
    benefit: 'E-Sertifikat Gratis',
    description: 'Belajar teknik slicing UI dari desain Figma ke Flutter.',
  },
  {
    id: 2,
    title: 'Workshop: Machine Learning for Beginners',
    speaker: 'Dr. Sarah Wijaya',
    org: 'Google Developer Student Club',
    tags: ['AI/ML', 'Online', 'Workshop'],
    date: '5 Mar 2025',
    time: '10:00 - 15:00 WIB',
    slots: { total: 100, filled: 87 },
    free: true,
    benefit: 'E-Sertifikat + Portfolio Project',
    description: 'Hands-on workshop dasar Machine Learning dengan TensorFlow.',
  },
  {
    id: 3,
    title: 'Tech Talk: System Design at Scale',
    speaker: 'Ahmad Fauzan — Sr. Engineer',
    org: 'Tokopedia Engineering',
    tags: ['Backend', 'Online', 'Tech Talk'],
    date: '18 Mar 2025',
    time: '19:30 - 21:00 WIB',
    slots: { total: 300, filled: 210 },
    free: true,
    benefit: 'E-Sertifikat + Swag Kit',
    description: 'Bagaimana Tokopedia mendesain sistem yang scalable.',
  },
  {
    id: 4,
    title: 'Seminar: Product Management 101',
    speaker: 'Dina Ayu — PM at Gojek',
    org: 'BEM FEB UI',
    tags: ['Product', 'Offline', 'Networking'],
    date: '25 Mar 2025',
    time: '09:00 - 12:00 WIB',
    slots: { total: 150, filled: 98 },
    free: false,
    benefit: 'Sertifikat + Lunch',
    price: 'Rp 50.000',
    description: 'Belajar dasar product management dari praktisi industri.',
  },
  {
    id: 5,
    title: 'Workshop: Figma Advanced Prototyping',
    speaker: 'Bella Maharani — UX Lead',
    org: 'NOERA Design Lab',
    tags: ['Design', 'Online', 'Workshop'],
    date: '2 Apr 2025',
    time: '14:00 - 17:00 WIB',
    slots: { total: 80, filled: 64 },
    free: true,
    benefit: 'E-Sertifikat + Template Pack',
    description: 'Advanced prototyping dan micro-interaction di Figma.',
  },
  {
    id: 6,
    title: 'Webinar: Persiapan Karir di Tech Industry',
    speaker: 'Multiple Speakers',
    org: 'HMIF ITB',
    tags: ['Career', 'Online', 'Panel'],
    date: '10 Apr 2025',
    time: '19:00 - 21:30 WIB',
    slots: { total: 500, filled: 320 },
    free: true,
    benefit: 'E-Sertifikat + Career Kit',
    description: 'Panel discussion dengan alumni yang berkarir di Google, Tokopedia, Gojek.',
  },
];

const categories = ['Semua', 'Workshop', 'Webinar', 'Tech Talk', 'Seminar'];

export default function SeminarWebinar() {
  const [activeFilter, setActiveFilter] = useState('Semua');
  const [searchQuery, setSearchQuery] = useState('');

  const filtered = seminarData.filter((s) => {
    const matchesSearch =
      searchQuery === '' ||
      s.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      s.speaker.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesSearch;
  });

  return (
    <div className="seminar-page">
      {/* Hero */}
      <div className="seminar-hero animate-in">
        <div>
          <h2>🖥️ Seminar & Webinar</h2>
          <p>
            Ikuti seminar dan webinar dari para ahli industri dan akademisi.
            Tingkatkan wawasan dan perluas jaringanmu!
          </p>
        </div>
        <div className="hero-icon">🖥️</div>
      </div>

      {/* Filter */}
      <div className="filter-bar">
        <input
          type="text"
          placeholder="🔍 Cari seminar, webinar, atau speaker..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        {categories.map((cat) => (
          <button
            key={cat}
            className={`filter-chip ${activeFilter === cat ? 'active' : ''}`}
            onClick={() => setActiveFilter(cat)}
          >
            {cat}
          </button>
        ))}
      </div>

      {/* Grid */}
      <div className="seminar-grid">
        {filtered.map((item, idx) => (
          <div key={item.id} className="seminar-card animate-in" style={{ animationDelay: `${idx * 0.05}s` }}>
            <div className={`card-badge ${item.free ? 'free' : 'paid'}`}>
              {item.free ? '✅ GRATIS' : `💰 ${item.price}`}
            </div>
            <div className="card-date">📅 {item.date}</div>
            <h3>{item.title}</h3>
            <div className="speaker">🎤 {item.speaker}</div>
            <div className="org">🏢 {item.org}</div>
            <div className="card-tags">
              {item.tags.map((tag, i) => (
                <span key={i}>{tag}</span>
              ))}
            </div>
            <div className="card-footer">
              <div className="slots">
                🪑 <strong>{item.slots.total - item.slots.filled}</strong> slot tersisa
              </div>
              <button className="btn-join">📝 Daftar</button>
            </div>
          </div>
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <div className="icon">🖥️</div>
          <h3>Tidak ada event ditemukan</h3>
          <p>Coba ubah kata kunci pencarian atau filter.</p>
        </div>
      )}
    </div>
  );
}
