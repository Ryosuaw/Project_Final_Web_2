import React, { useState } from 'react';
import PartnerCard from '../../components/PartnerCard/PartnerCard';
import { partnerList } from '../../data/mockData';
import './SkillExchange.css';

const categories = ['Semua', 'Mobile Dev', 'Web Dev', 'Design', 'Data Science', 'IoT'];

export default function SkillExchange() {
  const [isModalOpen, setIsModalOpen] = useState(false);
  const [activeFilter, setActiveFilter] = useState('Semua');
  const [searchQuery, setSearchQuery] = useState('');

  const filteredPartners = partnerList.filter((p) => {
    const matchesSearch =
      searchQuery === '' ||
      p.name.toLowerCase().includes(searchQuery.toLowerCase()) ||
      p.canTeach.some((s) => s.toLowerCase().includes(searchQuery.toLowerCase())) ||
      p.wantToLearn.some((s) => s.toLowerCase().includes(searchQuery.toLowerCase()));
    return matchesSearch;
  });

  return (
    <div className="skill-exchange-page">
      {/* CTA Banner */}
      <div className="skill-exchange-cta animate-in">
        <div>
          <h2>🤝 Temukan Partner Belajar yang Tepat</h2>
          <p>
            Tukar skill dengan mahasiswa lain dari berbagai universitas. Kamu mengajari mereka,
            mereka mengajari kamu — sama-sama berkembang!
          </p>
          <button
            className="btn-create-request"
            onClick={() => setIsModalOpen(true)}
          >
            ✨ Buat Request Baru
          </button>
        </div>
        <div className="cta-icon">👥</div>
      </div>

      {/* Stats */}
      <div className="exchange-stats">
        <div className="exchange-stat animate-in">
          <div className="number">156</div>
          <div className="label">Mahasiswa Aktif</div>
        </div>
        <div className="exchange-stat animate-in">
          <div className="number">48</div>
          <div className="label">Skill Tersedia</div>
        </div>
        <div className="exchange-stat animate-in">
          <div className="number">89</div>
          <div className="label">Partner Terhubung</div>
        </div>
      </div>

      <div className="page-header">
        <h1>👥 Skill Exchange</h1>
        <p>Temukan partner belajar yang sesuai dengan skill dan kebutuhanmu.</p>
      </div>

      {/* Filter Bar */}
      <div className="filter-bar">
        <input
          type="text"
          placeholder="🔍 Cari berdasarkan nama, skill, atau universitas..."
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

      {/* Partner Grid */}
      <div className="partner-grid-full">
        {filteredPartners.map((partner) => (
          <PartnerCard key={partner.id} data={partner} />
        ))}
      </div>

      {filteredPartners.length === 0 && (
        <div className="empty-state">
          <div className="icon">🔍</div>
          <h3>Tidak ada partner ditemukan</h3>
          <p>Coba ubah kata kunci pencarian atau filter kategori.</p>
        </div>
      )}

      {/* Modal Buat Request Skill Exchange */}
      {isModalOpen && (
        <div
          style={{
            position: 'fixed',
            top: 0,
            left: 0,
            width: '100vw',
            height: '100vh',
            backgroundColor: 'rgba(0, 0, 0, 0.5)',
            display: 'flex',
            justifyContent: 'center',
            alignItems: 'center',
            zIndex: 9999,
          }}
        >
          <div
            style={{
              backgroundColor: 'white',
              padding: '30px',
              borderRadius: '12px',
              width: '450px',
              boxShadow: '0 4px 20px rgba(0,0,0,0.15)',
              color: '#333',
            }}
          >
            <h3 style={{ marginBottom: '15px', fontWeight: 'bold', fontSize: '18px' }}>
              ✨ Buat Request Skill Exchange
            </h3>

            <div style={{ marginBottom: '15px' }}>
              <label style={{ display: 'block', marginBottom: '5px', fontSize: '14px', textAlign: 'left' }}>
                Skill yang Ingin Kamu Pelajari:
              </label>
              <input
                type="text"
                placeholder="Contoh: React, UI/UX, Laravel"
                style={{ width: '100%', padding: '8px', borderRadius: '6px', border: '1px solid #ccc' }}
              />
            </div>

            <div style={{ marginBottom: '20px' }}>
              <label style={{ display: 'block', marginBottom: '5px', fontSize: '14px', textAlign: 'left' }}>
                Skill yang Bisa Kamu Ajarkan:
              </label>
              <input
                type="text"
                placeholder="Contoh: Figma, Python, Copywriting"
                style={{ width: '100%', padding: '8px', borderRadius: '6px', border: '1px solid #ccc' }}
              />
            </div>

            <div style={{ display: 'flex', justifyContent: 'flex-end', gap: '10px' }}>
              <button
                onClick={() => setIsModalOpen(false)}
                style={{
                  padding: '8px 16px',
                  borderRadius: '6px',
                  border: '1px solid #ccc',
                  backgroundColor: '#f5f5f5',
                  cursor: 'pointer',
                }}
              >
                Batal
              </button>
              <button
                onClick={() => {
                  alert('Request berhasil dibuat!');
                  setIsModalOpen(false);
                }}
                style={{
                  padding: '8px 16px',
                  borderRadius: '6px',
                  border: 'none',
                  backgroundColor: '#2563eb',
                  color: 'white',
                  cursor: 'pointer',
                }}
              >
                Kirim Request
              </button>
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
