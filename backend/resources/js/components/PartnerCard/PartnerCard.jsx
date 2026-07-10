import React from 'react';
import './PartnerCard.css';

export default function PartnerCard({ data }) {
  return (
    <div className="partner-card animate-in">
      <div className="partner-header">
        <div className="partner-avatar">
          <img src={data.avatar} alt={data.name} />
          {data.online && <span className="partner-online"></span>}
        </div>
        <div className="partner-info">
          <div className="partner-name">
            {data.name}
            {data.verified && (
              <span className="partner-verified">
                <svg fill="currentColor" viewBox="0 0 20 20">
                  <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
                </svg>
              </span>
            )}
          </div>
          <div className="partner-role">{data.department}</div>
          <div className="partner-location">
            <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" d="M17.657 16.657L13.414 20.9a1.998 1.998 0 01-2.827 0l-4.244-4.243a8 8 0 1111.314 0z" />
              <path strokeLinecap="round" strokeLinejoin="round" d="M15 11a3 3 0 11-6 0 3 3 0 016 0z" />
            </svg>
            {data.university}
          </div>
        </div>
        <div className="partner-match">
          <div className="partner-match-value">{data.matchPercentage}%</div>
          <div className="partner-match-label">Match</div>
        </div>
      </div>

      <div className="partner-quote">"{data.quote}"</div>

      <div className="partner-skills-section">
        <div className="partner-skills-label teach">
          <svg fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6" />
          </svg>
          BISA MENGAJARI
        </div>
        <div className="partner-skill-tags">
          {data.canTeach.map((skill, i) => (
            <span key={i} className="partner-skill-tag teach">{skill}</span>
          ))}
        </div>
      </div>

      <div className="partner-skills-section">
        <div className="partner-skills-label learn">
          <svg fill="none" stroke="currentColor" strokeWidth="2.5" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M19 14l-7 7m0 0l-7-7m7 7V3" />
          </svg>
          INGIN BELAJAR
        </div>
        <div className="partner-skill-tags">
          {data.wantToLearn.map((skill, i) => (
            <span key={i} className="partner-skill-tag learn">{skill}</span>
          ))}
        </div>
      </div>

      <div className="partner-actions">
        <button className="btn btn-primary">
          <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
          </svg>
          Kirim Request
        </button>
        <button className="btn btn-ghost btn-icon">
          <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" d="M8 12h.01M12 12h.01M16 12h.01M21 12c0 4.418-4.03 8-9 8a9.863 9.863 0 01-4.255-.949L3 20l1.395-3.72C3.512 15.042 3 13.574 3 12c0-4.418 4.03-8 9-8s9 3.582 9 8z" />
          </svg>
        </button>
      </div>
    </div>
  );
}
