import React, { useState } from 'react';
import PeluangCard from '../../components/PeluangCard/PeluangCard';
import { peluangList } from '../../data/mockData';
import './PeluangBeasiswa.css';

const tabs = ['Semua', 'Beasiswa', 'Kompetisi', 'Seminar'];

export default function PeluangBeasiswa() {
  const [activeTab, setActiveTab] = useState('Semua');
  const [searchQuery, setSearchQuery] = useState('');

  const filtered = peluangList.filter((p) => {
    const matchesTab =
      activeTab === 'Semua' ||
      p.type.toLowerCase() === activeTab.toLowerCase();
    const matchesSearch =
      searchQuery === '' ||
      p.title.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.org.toLowerCase().includes(searchQuery.toLowerCase());
    return matchesTab && matchesSearch;
  });

  const beasiswaCount = peluangList.filter((p) => p.type === 'beasiswa').length;
  const kompetisiCount = peluangList.filter((p) => p.type === 'kompetisi').length;
  const seminarCount = peluangList.filter((p) => p.type === 'seminar').length;

  return (
    <div className="beasiswa-page">
      {/* Hero Banner */}
      <div className="beasiswa-hero animate-in">
        <div>
          <h2>🎓 Peluang Beasiswa & Pengembangan</h2>
          <p>
            Temukan beasiswa, kompetisi, dan seminar terbaru yang sesuai dengan
            skill dan minat kamu. Jangan lewatkan kesempatan untuk berkembang!
          </p>
          <div className="hero-stats">
            <div className="hero-stat">
              <div className="num">{beasiswaCount}</div>
              <div className="lbl">Beasiswa</div>
            </div>
            <div className="hero-stat">
              <div className="num">{kompetisiCount}</div>
              <div className="lbl">Kompetisi</div>
            </div>
            <div className="hero-stat">
              <div className="num">{seminarCount}</div>
              <div className="lbl">Seminar</div>
            </div>
          </div>
        </div>
        <div className="hero-icon">🎓</div>
      </div>

      {/* Tabs */}
      <div className="tabs">
        {tabs.map((tab) => (
          <button
            key={tab}
            className={`tab ${activeTab === tab ? 'active' : ''}`}
            onClick={() => setActiveTab(tab)}
          >
            {tab}
          </button>
        ))}
      </div>

      {/* Filter */}
      <div className="filter-bar">
        <input
          type="text"
          placeholder="🔍 Cari beasiswa, kompetisi, atau seminar..."
          value={searchQuery}
          onChange={(e) => setSearchQuery(e.target.value)}
        />
        <select defaultValue="">
          <option value="" disabled>📅 Urutkan</option>
          <option value="deadline">Deadline Terdekat</option>
          <option value="newest">Terbaru</option>
          <option value="benefit">Benefit Tertinggi</option>
        </select>
      </div>

      <div className="saved-count">
        🔖 Menampilkan <strong>{filtered.length}</strong> peluang
        {activeTab !== 'Semua' && ` dalam kategori ${activeTab}`}
      </div>

      {/* Grid */}
      <div className="peluang-grid-full">
        {filtered.map((peluang) => (
          <PeluangCard key={peluang.id} data={peluang} />
        ))}
      </div>

      {filtered.length === 0 && (
        <div className="empty-state">
          <div className="icon">📭</div>
          <h3>Belum ada peluang</h3>
          <p>Coba ubah filter atau kata kunci pencarian.</p>
        </div>
      )}
    </div>
  );
}
