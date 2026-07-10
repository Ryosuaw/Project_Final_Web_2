import React, { useState } from 'react';
import './PeluangCard.css';

const tagIcons = {
  beasiswa: (
    <svg fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" d="M12 14l9-5-9-5-9 5 9 5z" />
    </svg>
  ),
  kompetisi: (
    <svg fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" d="M5 3v4M3 5h4M6 17v4m-2-2h4m5-16l2.286 6.857L21 12l-5.714 2.143L13 21l-2.286-6.857L5 12l5.714-2.143L13 3z" />
    </svg>
  ),
  seminar: (
    <svg fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
      <path strokeLinecap="round" strokeLinejoin="round" d="M15 10l4.553-2.276A1 1 0 0121 8.618v6.764a1 1 0 01-1.447.894L15 14M5 18h8a2 2 0 002-2V8a2 2 0 00-2-2H5a2 2 0 00-2 2v8a2 2 0 002 2z" />
    </svg>
  ),
};

const tagLabels = {
  beasiswa: 'Beasiswa',
  kompetisi: 'Kompetisi',
  seminar: 'Seminar',
};

export default function PeluangCard({ data }) {
  const [bookmarked, setBookmarked] = useState(data.bookmarked || false);

  return (
    <div className="opp-card animate-in">
      <div className="opp-card-header">
        <span className={`opp-tag opp-tag-${data.type}`}>
          {tagIcons[data.type]}
          {tagLabels[data.type]}
        </span>
        <button
          className={`opp-bookmark ${bookmarked ? 'bookmarked' : ''}`}
          onClick={() => setBookmarked(!bookmarked)}
          title={bookmarked ? 'Hapus bookmark' : 'Simpan'}
        >
          <svg fill={bookmarked ? 'currentColor' : 'none'} stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z" />
          </svg>
        </button>
      </div>
      
      <h3 className="opp-title">{data.title}</h3>
      
      <div className="opp-org">
        <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4" />
        </svg>
        {data.org}
      </div>
      
      <div className="opp-tags">
        {data.tags.map((tag, i) => (
          <span key={i} className="opp-tag-sm">{tag}</span>
        ))}
      </div>
      
      <div className="opp-meta">
        <div className="opp-meta-item">
          <label>Deadline</label>
          <span className="deadline">{data.deadline}</span>
        </div>
        <div className="opp-meta-item" style={{ textAlign: 'right' }}>
          <label>Benefit</label>
          <span className={`benefit ${data.benefitColor === 'green' ? 'green' : ''}`}>
            {data.benefit}
          </span>
        </div>
      </div>
      
      <button className="btn btn-primary" style={{ width: '100%', justifyContent: 'center' }}>
        Lihat Detail
      </button>
    </div>
  );
}
