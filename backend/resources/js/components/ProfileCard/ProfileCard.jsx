import React from 'react';
import { useNavigate } from 'react-router-dom';
import { currentUser } from '../../data/mockData';
import './ProfileCard.css';

export default function ProfileCard() {
  const navigate = useNavigate();
  
  const formattedName = currentUser.name
    .split(' ')
    .map((w) => w.charAt(0).toUpperCase() + w.slice(1).toLowerCase())
    .join(' ');

  return (
    <div className="profile-card">
      <div className="profile-card-header">
        <div className="profile-card-avatar">
          <img src={currentUser.avatar} alt={currentUser.name} />
        </div>
        <div>
          <div className="profile-card-name">{formattedName}</div>
          <div className="profile-card-role">
            {currentUser.department} — {currentUser.university}
          </div>
          {currentUser.verified && (
            <div className="profile-card-verified">
              <svg fill="currentColor" viewBox="0 0 20 20">
                <path fillRule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clipRule="evenodd" />
              </svg>
              Terverifikasi
            </div>
          )}
        </div>
      </div>

      <div className="profile-progress">
        <div className="profile-progress-header">
          <span className="profile-progress-label">Kelengkapan Profil</span>
          <span className="profile-progress-value">{currentUser.profileCompletion}%</span>
        </div>
        <div className="profile-progress-bar">
          <div
            className="profile-progress-fill"
            style={{ width: `${currentUser.profileCompletion}%` }}
          />
        </div>
        <p className="profile-progress-hint">
          Tambahkan 2 skill lagi untuk match lebih banyak partner.
        </p>
      </div>

      <div className="profile-skills">
        <div className="profile-skills-title">SKILL SAYA</div>
        <div className="profile-skill-tags">
          {currentUser.skills.map((skill, i) => (
            <span key={i} className="profile-skill-tag">{skill}</span>
          ))}
          <span className="profile-skill-add">+ Tambah</span>
        </div>
      </div>

      <button className="btn btn-primary" style={{ width: '100%', justifyContent: 'center' }} onClick={() => navigate('/profile')}>
        <svg fill="none" stroke="currentColor" strokeWidth="2" viewBox="0 0 24 24">
          <path strokeLinecap="round" strokeLinejoin="round" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z" />
        </svg>
        Edit Profil
      </button>
    </div>
  );
}
