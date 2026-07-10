import React from 'react';
import { Link } from 'react-router-dom';
import { currentUser } from '../../data/mockData';
import './Navbar.css';

export default function Navbar() {
  return (
    <nav className="navbar">
      <div className="navbar-left">
        <Link to="/" className="logo">
          <svg viewBox="0 0 100 100" className="logo-icon">
            <path d="M 72 46 C 78 30, 68 16, 50 16 C 32 16, 22 30, 28 46" fill="none" stroke="#c59b27" strokeWidth="3" strokeLinecap="round" />
            <path d="M 33 24 H 42 V 26 H 39 V 50 H 43 V 52 H 33 V 50 H 36 V 26 H 33 Z" fill="#0d233a" />
            <path d="M 39 24 L 60 52 H 63 L 41 24 Z" fill="#0d233a" />
            <path d="M 59 24 H 64 V 26 H 62 V 50 H 65 V 52 H 57 V 50 H 60 V 26 H 59 Z" fill="#0d233a" />
            <path d="M 53 42 C 50 39, 49 35, 52 31 C 54 27, 53 23, 50 19 C 54 22, 56 27, 55 32 C 54 37, 52 40, 50 42 C 52 42, 53 40, 54 38 C 56 34, 55 30, 53 28 C 55 30, 56 33, 55 36 C 54 39, 53 41, 53 42 Z" fill="#c59b27" />
            <path d="M 50 56 C 45 49, 32 47, 22 51 L 24 53.5 C 33 50.5, 45 52.5, 50 59 C 55 52.5, 67 50.5, 76 53.5 L 78 51 C 68 47, 55 49, 50 56 Z" fill="#0d233a" />
            <path d="M 50 59 C 45 52, 32 50, 20 54 L 22 56.5 C 33 53.5, 45 55.5, 50 62 C 55 55.5, 67 53.5, 78 56.5 L 80 54 C 68 50, 55 52, 50 59 Z" fill="#0d233a" />
            <path d="M 50 62 C 45 55, 32 53, 17 57 L 19 59.5 C 33 56.5, 45 58.5, 50 65 C 55 58.5, 67 56.5, 81 59.5 L 83 57 C 68 53, 55 55, 50 62 Z" fill="#0d233a" />
          </svg>
          <span className="logo-text">
            <span>N</span><span>O</span><span className="gold">E</span><span>R</span><span>A</span>
          </span>
        </Link>
        <div className="tagline">
          <strong>LEARN. CONNECT. GROW.</strong>
          <br />
          Student Skill Exchange
        </div>
      </div>

      <div className="search-bar">
        <span className="search-icon">🔍</span>
        <input
          type="text"
          placeholder='Cari mahasiswa, skill ("React", "UI Design")...'
        />
        <span className="search-shortcut">⌘K</span>
      </div>

      <div className="navbar-right">
        <div className="nav-icon">
          🔔
          <span className="badge">3</span>
        </div>
        <div className="nav-icon">
          💬
          <span className="badge">5</span>
        </div>
        <Link to="/profile" className="user-profile">
          <div className="user-avatar">
            <img src={currentUser.avatar} alt="avatar" />
          </div>
          <div className="user-info">
            <div className="name">{currentUser.name}</div>
            <div className="dept">{currentUser.department}</div>
          </div>
          <span>▾</span>
        </Link>
      </div>
    </nav>
  );
}
