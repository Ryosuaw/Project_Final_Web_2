import React, { useState } from 'react';
import { peluangList } from '../../data/mockData';
import './InfoKompetisi.css';

const kompetisiData = [
  ...peluangList.filter((p) => p.type === 'kompetisi'),
  {
    id: 101,
    type: 'kompetisi',
    title: 'Google Solution Challenge 2025',
    org: 'Google Developer Student Clubs',
    tags: ['Tim', 'Global', 'Social Impact'],
    deadline: '15 Mar 2025',
    benefit: 'USD $3,000 + Mentoring',
    prize: 'USD $3,000',
    participants: 'Tim 2-4',
    level: 'All Levels',
    description: 'Build solutions using Google technologies that address UN Sustainable Development Goals.',
  },
  {
    id: 102,
    type: 'kompetisi',
    title: 'JOINTS UGM 2025 — CTF',
    org: 'HMEI UGM',
    tags: ['Individu', 'Cybersecurity'],
    deadline: '22 Apr 2025',
    benefit: 'Rp 10 Juta + Sertifikat',
    prize: 'Rp 10 Juta',
    participants: 'Individu',
    level: 'Advanced',
    description: 'Capture The Flag competition untuk menguji kemampuan cybersecurity.',
  },
  {
    id: 103,
    type: 'kompetisi',
    title: 'Compfest UI — Competitive Programming',
    org: 'BEM Fasilkom UI',
    tags: ['Tim', 'Algoritma'],
    deadline: '8 Mei 2025',
    benefit: 'Rp 20 Juta + Trophy',
    prize: 'Rp 20 Juta',
    participants: 'Tim 3',
    level: 'Advanced',
    description: 'Kompetisi competitive programming terbesar di Indonesia.',
  },
  {
    id: 104,
    type: 'kompetisi',
    title: 'Startup Weekend Indonesia',
    org: 'Techstars',
    tags: ['Tim', 'Startup', 'Pitching'],
    deadline: '30 Mar 2025',
    benefit: 'Inkubasi + Networking',
    prize: 'Inkubasi Program',
    participants: 'Tim 3-5',
    level: 'Beginner',
    description: 'Event 54 jam untuk validasi ide startup dan membangun MVP.',
  },
];

const categories = ['Semua', 'Design', 'Teknologi', 'Data Science', 'Cybersecurity', 'Startup'];

export default function InfoKompetisi() {
  const [activeFilter, setActiveFilter] = useState('Semua');
  const [searchQuery, setSearchQuery] = useState('');

  const filtered = kompetisiData.filter((k) => {
    const matchesSearch =
      searchQuery === '' ||
      k.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      k.org.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesSearch;
  });

  return (
    <div className="kompetisi-page">
      {/* Hero */}
      <div className="kompetisi-hero animate-in">
        <div>
          <h2>🏆 Info Kompetisi Mahasiswa</h2>
          <p>
            Temukan kompetisi bergengsi tingkat nasional dan internasional.
            Asah kemampuan dan buktikan potensimu!
          </p>
        </div>
        <div className="hero-icon">🏆</div>
      </div>

      {/* Filter */}
      <div className="filter-bar">
        <input
          type="text"
          placeholder="🔍 Cari kompetisi..."
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

      <div className="saved-count" style={{ marginBottom: 20, fontSize: 14, color: '#6b7280' }}>
        🏆 Menampilkan <strong style={{ color: '#ea580c' }}>{filtered.length}</strong> kompetisi
      </div>

      {/* Grid */}
      <div className="kompetisi-grid">
        {filtered.map((item, idx) => (
          <div key={item.id} className="kompetisi-card animate-in" style={{ animationDelay: `${idx * 0.05}s` }}>
            <div className="card-tag">🏆 KOMPETISI</div>
            <h3>{item.title}</h3>
            <div className="org">🏢 {item.org}</div>
            <div className="card-tags">
              {item.tags.map((tag, i) => (
                <span key={i}>{tag}</span>
              ))}
            </div>
            <div className="card-info">
              <div className="info-item">
                <div className="info-label">DEADLINE</div>
                <div className="info-value">📅 {item.deadline}</div>
              </div>
              <div className="info-item">
                <div className="info-label">HADIAH</div>
                <div className="info-value">{item.prize || item.benefit}</div>
              </div>
            </div>
            <button className="btn-register">🚀 Daftar Sekarang</button>
          </div>
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <div className="icon">🏆</div>
          <h3>Tidak ada kompetisi ditemukan</h3>
          <p>Coba ubah kata kunci pencarian.</p>
        </div>
      )}
    </div>
  );
}
