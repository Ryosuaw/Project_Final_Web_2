import React, { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { currentUser } from '../../data/mockData';
import './Settings.css';

export default function Settings() {
  const navigate = useNavigate();

  // Toast Notification state
  const [toast, setToast] = useState({ show: false, message: '' });

  const showToast = (message) => {
    setToast({ show: true, message });
    setTimeout(() => {
      setToast({ show: false, message: '' });
    }, 3000);
  };

  // 1. Profil & Identitas states
  const [profileName, setProfileName] = useState(currentUser.name);
  const [username, setUsername] = useState('kakakcica');
  const [department, setDepartment] = useState(currentUser.department);
  const [university, setUniversity] = useState(currentUser.university);
  const [semester, setSemester] = useState('Semester 6');
  const [domicile, setDomicile] = useState('Yogyakarta');
  const [bio, setBio] = useState('Mahasiswa TI UGM semester 6, passionate di Flutter & data analytics. Open to collaborate!');
  const [portfolio, setPortfolio] = useState('https://kakakcica.dev');
  const [linkedin, setLinkedin] = useState('linkedin.com/in/kakakcica');
  const [avatar, setAvatar] = useState(currentUser.avatar);

  // 2. Skill & Minat states
  const [offeredSkills, setOfferedSkills] = useState([...currentUser.skills]);
  const [wantedSkills, setWantedSkills] = useState([
    'React Native',
    'TypeScript',
    'Machine Learning',
    'UI/UX Advanced',
  ]);

  // Input states for adding tags inline
  const [newOfferedSkill, setNewOfferedSkill] = useState('');
  const [showAddOfferedInput, setShowAddOfferedInput] = useState(false);
  const [newWantedSkill, setNewWantedSkill] = useState('');
  const [showAddWantedInput, setShowAddWantedInput] = useState(false);

  // 3. Akun & Keamanan states
  const [email] = useState('kakakcica@mail.ugm.ac.id');
  const [whatsapp, setWhatsapp] = useState('+62 812 3456 7890');
  const [currentPassword, setCurrentPassword] = useState('');
  const [newPassword, setNewPassword] = useState('');
  const [confirmPassword, setConfirmPassword] = useState('');

  // 4. Pengaturan Notifikasi states
  const [notifications, setNotifications] = useState({
    partnerRequests: true,
    deadlines: true,
    recommendations: true,
    studyClubs: true,
    updates: false,
    newsletter: false,
  });

  // 5. Bahasa & Tampilan states
  const [language, setLanguage] = useState('Bahasa Indonesia');
  const [theme, setTheme] = useState('light');

  // Detect initial theme on load
  useEffect(() => {
    const isDark = document.documentElement.classList.contains('dark') || document.body.classList.contains('dark');
    setTheme(isDark ? 'dark' : 'light');
  }, []);

  // --- Handlers ---
  const handleSaveProfile = (e) => {
    e.preventDefault();
    // Sync to global mock data
    currentUser.name = profileName;
    currentUser.department = department;
    currentUser.university = university;
    showToast('Profil berhasil diperbarui! 👤');
  };

  const handleAddOfferedSkill = (e) => {
    e.preventDefault();
    if (newOfferedSkill.trim() && !offeredSkills.includes(newOfferedSkill.trim())) {
      const updated = [...offeredSkills, newOfferedSkill.trim()];
      setOfferedSkills(updated);
      currentUser.skills = updated; // Sync to global
      showToast(`Skill "${newOfferedSkill.trim()}" ditambahkan!`);
      setNewOfferedSkill('');
    }
    setShowAddOfferedInput(false);
  };

  const handleRemoveOfferedSkill = (skillToRemove) => {
    const updated = offeredSkills.filter((s) => s !== skillToRemove);
    setOfferedSkills(updated);
    currentUser.skills = updated; // Sync to global
    showToast(`Skill "${skillToRemove}" dihapus.`);
  };

  const handleAddWantedSkill = (e) => {
    e.preventDefault();
    if (newWantedSkill.trim() && !wantedSkills.includes(newWantedSkill.trim())) {
      setWantedSkills([...wantedSkills, newWantedSkill.trim()]);
      showToast(`Skill minat "${newWantedSkill.trim()}" ditambahkan!`);
      setNewWantedSkill('');
    }
    setShowAddWantedInput(false);
  };

  const handleRemoveWantedSkill = (skillToRemove) => {
    setWantedSkills(wantedSkills.filter((s) => s !== skillToRemove));
    showToast(`Skill minat "${skillToRemove}" dihapus.`);
  };

  const handleSaveSecurity = (e) => {
    e.preventDefault();
    if (newPassword || confirmPassword) {
      if (newPassword !== confirmPassword) {
        showToast('⚠️ Konfirmasi password baru tidak cocok!');
        return;
      }
      if (newPassword.length < 8) {
        showToast('⚠️ Password baru harus minimal 8 karakter!');
        return;
      }
    }
    showToast('Keamanan dan nomor WhatsApp berhasil disimpan! 🔒');
    setCurrentPassword('');
    setNewPassword('');
    setConfirmPassword('');
  };

  const toggleNotification = (key) => {
    const updated = !notifications[key];
    setNotifications({ ...notifications, [key]: updated });
    showToast(`Notifikasi ${key === 'updates' || key === 'newsletter' ? 'newsletter' : 'sistem'} ${updated ? 'diaktifkan' : 'dimatikan'}.`);
  };

  const handleThemeChange = (newTheme) => {
    setTheme(newTheme);
    if (newTheme === 'dark') {
      document.documentElement.classList.add('dark');
      document.body.classList.add('dark');
      showToast('Tema Gelap diaktifkan! 🌙');
    } else {
      document.documentElement.classList.remove('dark');
      document.body.classList.remove('dark');
      showToast('Tema Terang diaktifkan! ☀️');
    }
  };

  const handleSaveTampilan = (e) => {
    e.preventDefault();
    showToast('Preferensi bahasa & tampilan disimpan! 🌐');
  };

  const handleLogout = () => {
    showToast('Mengeluarkan sesi... Keluar berhasil! 🚪');
    setTimeout(() => {
      navigate('/');
    }, 1500);
  };

  const handleDeleteAccount = () => {
    if (window.confirm('Apakah Anda yakin ingin menghapus akun secara permanen? Tindakan ini tidak dapat dibatalkan.')) {
      showToast('Menghapus akun... Sampai jumpa! 👋');
      setTimeout(() => {
        navigate('/');
      }, 2000);
    }
  };

  return (
    <div className="settings-page">
      {/* Breadcrumb & Title */}
      <div className="page-header">
        <div className="breadcrumb">
          <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M10.325 4.317c.426-1.756 2.924-1.756 3.35 0a1.724 1.724 0 002.573 1.066c1.543-.94 3.31.826 2.37 2.37a1.724 1.724 0 001.065 2.572c1.756.426 1.756 2.924 0 3.35a1.724 1.724 0 00-1.066 2.573c.94 1.543-.826 3.31-2.37 2.37a1.724 1.724 0 00-2.572 1.065c-.426 1.756-2.924 1.756-3.35 0a1.724 1.724 0 00-2.573-1.066c-1.543.94-3.31-.826-2.37-2.37a1.724 1.724 0 00-1.065-2.572c-1.756-.426-1.756-2.924 0-3.35a1.724 1.724 0 001.066-2.573c-.94-1.543.826-3.31 2.37-2.37.996.608 2.296.07 2.572-1.065z"></path>
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
          </svg>
          Pengaturan
        </div>
        <h1 className="page-title">Pengaturan Akun</h1>
        <p className="page-description">Kelola profil, keamanan, notifikasi, dan preferensi tampilan akunmu.</p>
      </div>

      {/* 1. Profil & Identitas Card */}
      <div className="card">
        <div className="card-header">
          <div className="card-icon">
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M16 7a4 4 0 11-8 0 4 4 0 018 0zM12 14a7 7 0 00-7 7h14a7 7 0 00-7-7z"></path>
            </svg>
          </div>
          <div className="card-title-group">
            <h2>Profil & Identitas</h2>
            <p>Informasi yang akan terlihat oleh pengguna lain di NOERA.</p>
          </div>
        </div>

        <div className="photo-upload">
          <div className="photo-preview">
            <img src={avatar} alt="Profile Photo" />
          </div>
          <div className="photo-info">
            <label style={{ display: 'block', marginBottom: '4px' }}>Foto Profil</label>
            <p style={{ fontSize: '13px', color: '#64748b', marginBottom: '12px' }}>
              JPG, PNG maks. 2MB. Disarankan ukuran 400x400px.
            </p>
            <div className="photo-actions">
              <button className="btn btn-primary" onClick={() => showToast('Pilih file foto profil... (Fitur Demo)')}>
                Ganti Foto
              </button>
              <button
                className="btn btn-secondary"
                onClick={() => {
                  setAvatar('https://i.pravatar.cc/100?img=9');
                  showToast('Foto profil di-reset.');
                }}
              >
                Reset
              </button>
            </div>
          </div>
        </div>

        <form onSubmit={handleSaveProfile}>
          <div className="form-grid">
            <div className="form-group">
              <label>Nama Lengkap</label>
              <input
                type="text"
                value={profileName}
                onChange={(e) => setProfileName(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Username</label>
              <input
                type="text"
                value={username}
                onChange={(e) => setUsername(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Jurusan / Program Studi</label>
              <input
                type="text"
                value={department}
                onChange={(e) => setDepartment(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Universitas</label>
              <select value={university} onChange={(e) => setUniversity(e.target.value)}>
                <option value="Universitas Gadjah Mada">Universitas Gadjah Mada</option>
                <option value="Universitas Indonesia">Universitas Indonesia</option>
                <option value="Institut Teknologi Bandung">Institut Teknologi Bandung</option>
                <option value="Universitas Airlangga">Universitas Airlangga</option>
                <option value="Universitas Brawijaya">Universitas Brawijaya</option>
              </select>
            </div>
            <div className="form-group">
              <label>Semester Aktif</label>
              <select value={semester} onChange={(e) => setSemester(e.target.value)}>
                <option value="Semester 1">Semester 1</option>
                <option value="Semester 2">Semester 2</option>
                <option value="Semester 3">Semester 3</option>
                <option value="Semester 4">Semester 4</option>
                <option value="Semester 5">Semester 5</option>
                <option value="Semester 6">Semester 6</option>
                <option value="Semester 7">Semester 7</option>
                <option value="Semester 8">Semester 8</option>
              </select>
            </div>
            <div className="form-group">
              <label>Kota / Domisili</label>
              <input
                type="text"
                value={domicile}
                onChange={(e) => setDomicile(e.target.value)}
                required
              />
            </div>
            <div className="form-group full-width">
              <label>
                Bio Singkat <span style={{ color: '#94a3b8', fontWeight: 400 }}>Maks. 200 karakter.</span>
              </label>
              <textarea
                value={bio}
                maxLength={200}
                onChange={(e) => setBio(e.target.value)}
                required
              />
            </div>
            <div className="form-group">
              <label>Link Portfolio</label>
              <input
                type="text"
                value={portfolio}
                onChange={(e) => setPortfolio(e.target.value)}
              />
            </div>
            <div className="form-group">
              <label>LinkedIn</label>
              <input
                type="text"
                value={linkedin}
                onChange={(e) => setLinkedin(e.target.value)}
              />
            </div>
          </div>

          <div className="card-actions">
            <button type="button" className="btn btn-secondary" onClick={() => navigate('/profile')}>
              Batal
            </button>
            <button type="submit" className="btn btn-primary">
              Simpan Perubahan
            </button>
          </div>
        </form>
      </div>

      {/* 2. Skill & Minat Card */}
      <div className="card">
        <div className="card-header">
          <div className="card-icon" style={{ background: '#fff7ed', color: '#f97316' }}>
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 10V3L4 14h7v7l9-11h-7z"></path>
            </svg>
          </div>
          <div className="card-title-group">
            <h2>Skill & Minat</h2>
            <p>Tentukan apa yang bisa kamu ajarkan dan apa yang ingin kamu pelajari.</p>
          </div>
        </div>

        <div className="section-label">
          <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M13 7h8m0 0v8m0-8l-8 8-4-4-6 6"></path>
          </svg>
          SKILL YANG SAYA TAWARKAN
        </div>
        <div className="tags-container">
          {offeredSkills.map((skill) => (
            <span key={skill} className="tag tag-green">
              {skill}
              <span className="tag-remove" onClick={() => handleRemoveOfferedSkill(skill)}>
                &times;
              </span>
            </span>
          ))}

          {showAddOfferedInput ? (
            <form onSubmit={handleAddOfferedSkill} className="add-tag-form">
              <input
                type="text"
                className="add-tag-input"
                value={newOfferedSkill}
                onChange={(e) => setNewOfferedSkill(e.target.value)}
                onBlur={handleAddOfferedSkill}
                placeholder="Tulis skill..."
                autoFocus
              />
            </form>
          ) : (
            <span className="add-tag" onClick={() => setShowAddOfferedInput(true)}>
              + Tambah Skill
            </span>
          )}
        </div>

        <div className="section-label" style={{ marginTop: '24px' }}>
          <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M19 14l-7 7m0 0l-7-7m7 7V3"></path>
          </svg>
          SKILL YANG INGIN DIPELAJARI
        </div>
        <div className="tags-container">
          {wantedSkills.map((skill) => (
            <span key={skill} className="tag tag-orange">
              {skill}
              <span className="tag-remove" onClick={() => handleRemoveWantedSkill(skill)}>
                &times;
              </span>
            </span>
          ))}

          {showAddWantedInput ? (
            <form onSubmit={handleAddWantedSkill} className="add-tag-form">
              <input
                type="text"
                className="add-tag-input"
                value={newWantedSkill}
                onChange={(e) => setNewWantedSkill(e.target.value)}
                onBlur={handleAddWantedSkill}
                placeholder="Tulis minat..."
                autoFocus
              />
            </form>
          ) : (
            <span className="add-tag" onClick={() => setShowAddWantedInput(true)}>
              + Tambah
            </span>
          )}
        </div>

        <div className="card-actions">
          <button className="btn btn-primary" onClick={() => showToast('Daftar skill berhasil disimpan! ⚡')}>
            Simpan Skill
          </button>
        </div>
      </div>

      {/* 3. Akun & Keamanan Card */}
      <div className="card">
        <div className="card-header">
          <div className="card-icon" style={{ background: '#f0fdf4', color: '#10b981' }}>
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m5.618-4.016A11.955 11.955 0 0112 2.944a11.955 11.955 0 01-8.618 3.04A12.02 12.02 0 003 9c0 5.591 3.824 10.29 9 11.622 5.176-1.332 9-6.03 9-11.622 0-1.042-.133-2.052-.382-3.016z"></path>
            </svg>
          </div>
          <div className="card-title-group">
            <h2>Akun & Keamanan</h2>
            <p>Kelola email, password, dan verifikasi identitas akunmu.</p>
          </div>
        </div>

        <form onSubmit={handleSaveSecurity}>
          <div className="form-grid">
            <div className="form-group">
              <label>Email Terdaftar</label>
              <span className="helper-text">Email diverifikasi dari domain kampus</span>
              <input
                type="email"
                value={email}
                disabled
              />
            </div>
            <div className="form-group">
              <label>Nomor WhatsApp</label>
              <span className="helper-text">Digunakan untuk chat dan sinkronisasi partner</span>
              <input
                type="tel"
                value={whatsapp}
                onChange={(e) => setWhatsapp(e.target.value)}
                required
              />
            </div>
          </div>

          <div className="section-subtitle">GANTI PASSWORD</div>

          <div className="password-grid">
            <div className="form-group">
              <label>Password Saat Ini</label>
              <input
                type="password"
                placeholder="Ketik password lama..."
                value={currentPassword}
                onChange={(e) => setCurrentPassword(e.target.value)}
              />
            </div>
            <div className="form-group">
              <label>Password Baru</label>
              <input
                type="password"
                placeholder="Ketik password baru..."
                value={newPassword}
                onChange={(e) => setNewPassword(e.target.value)}
              />
            </div>
          </div>
          <div className="form-group" style={{ marginBottom: '16px' }}>
            <label>Konfirmasi Password</label>
            <input
              type="password"
              placeholder="Ketik konfirmasi password baru..."
              value={confirmPassword}
              onChange={(e) => setConfirmPassword(e.target.value)}
            />
          </div>

          {newPassword ? (
            confirmPassword && newPassword !== confirmPassword ? (
              <div className="password-strength warning">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                </svg>
                Password baru dan konfirmasi tidak cocok.
              </div>
            ) : newPassword.length < 8 ? (
              <div className="password-strength warning">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M12 9v2m0 4h.01m-6.938 4h13.856c1.54 0 2.502-1.667 1.732-3L13.732 4c-.77-1.333-2.694-1.333-3.464 0L3.34 16c-.77 1.333.192 3 1.732 3z"></path>
                </svg>
                Password terlalu lemah. Minimal harus 8 karakter.
              </div>
            ) : (
              <div className="password-strength">
                <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
                  <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"></path>
                </svg>
                Password kuat dan cocok untuk digunakan.
              </div>
            )
          ) : (
            <div className="password-strength" style={{ background: '#f8fafc', borderColor: '#e2e8f0', color: '#64748b' }}>
              Password baru minimal 8 karakter, disarankan mengandung kombinasi angka dan simbol.
            </div>
          )}

          <div className="danger-zone">
            <div>
              <h4>Hapus Akun</h4>
              <p>Semua data pertukaran skill, profil, dan history akan dihapus permanen.</p>
            </div>
            <button type="button" className="btn btn-danger" onClick={handleDeleteAccount}>
              Hapus Akun
            </button>
          </div>

          <div className="card-actions">
            <button type="submit" className="btn btn-primary">
              Simpan Keamanan
            </button>
          </div>
        </form>
      </div>

      {/* 4. Pengaturan Notifikasi Card */}
      <div className="card">
        <div className="card-header">
          <div className="card-icon" style={{ background: '#f3e8ff', color: '#9333ea' }}>
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M15 17h5l-1.405-1.405A2.032 2.032 0 0118 14.158V11a6.002 6.002 0 00-4-5.659V5a2 2 0 10-4 0v.341C7.67 6.165 6 8.388 6 11v3.159c0 .538-.214 1.055-.595 1.436L4 17h5m6 0v1a3 3 0 11-6 0v-1m6 0H9"></path>
            </svg>
          </div>
          <div className="card-title-group">
            <h2>Pengaturan Notifikasi</h2>
            <p>Pilih notifikasi apa saja yang ingin kamu terima.</p>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Partner Request Baru</h4>
            <p>Notifikasi ketika ada mahasiswa mengirim request padamu.</p>
          </div>
          <div
            className={`toggle ${notifications.partnerRequests ? 'active' : ''}`}
            onClick={() => toggleNotification('partnerRequests')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Deadline Peluang Mendekat</h4>
            <p>Ingatkan 3 hari sebelum deadline beasiswa / lomba tersimpan.</p>
          </div>
          <div
            className={`toggle ${notifications.deadlines ? 'active' : ''}`}
            onClick={() => toggleNotification('deadlines')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Peluang Baru yang Cocok</h4>
            <p>Kirim peluang baru berdasarkan skill & minatmu.</p>
          </div>
          <div
            className={`toggle ${notifications.recommendations ? 'active' : ''}`}
            onClick={() => toggleNotification('recommendations')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Sesi Study Club Mendatang</h4>
            <p>Pengingat 1 jam sebelum sesi study club dimulai.</p>
          </div>
          <div
            className={`toggle ${notifications.studyClubs ? 'active' : ''}`}
            onClick={() => toggleNotification('studyClubs')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Update Platform NOERA</h4>
            <p>Info fitur baru dan pengumuman dari tim NOERA.</p>
          </div>
          <div
            className={`toggle ${notifications.updates ? 'active' : ''}`}
            onClick={() => toggleNotification('updates')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="toggle-group">
          <div className="toggle-info">
            <h4>Email Newsletter Mingguan</h4>
            <p>Ringkasan peluang dan partner terbaik dikirim setiap Senin.</p>
          </div>
          <div
            className={`toggle ${notifications.newsletter ? 'active' : ''}`}
            onClick={() => toggleNotification('newsletter')}
          >
            <div className="toggle-slider"></div>
          </div>
        </div>

        <div className="card-actions">
          <button className="btn btn-primary" onClick={() => showToast('Pengaturan notifikasi berhasil disimpan! 🔔')}>
            Simpan Notifikasi
          </button>
        </div>
      </div>

      {/* 5. Bahasa & Tampilan Card */}
      <div className="card">
        <div className="card-header">
          <div className="card-icon" style={{ background: '#f0f9ff', color: '#0284c7' }}>
            <svg fill="none" stroke="currentColor" viewBox="0 0 24 24">
              <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M3.055 11H5a2 2 0 012 2v1a2 2 0 002 2 2 2 0 012 2v2.945M8 3.935V5.5A2.5 2.5 0 0010.5 8h.5a2 2 0 012 2 2 2 0 104 0 2 2 0 012-2h1.064M15 20.488V18a2 2 0 012-2h3.064M21 12a9 9 0 11-18 0 9 9 0 0118 0z"></path>
            </svg>
          </div>
          <div className="card-title-group">
            <h2>Bahasa & Tampilan</h2>
            <p>Sesuaikan bahasa dan tampilan antarmuka NOERA.</p>
          </div>
        </div>

        <form onSubmit={handleSaveTampilan}>
          <div className="form-group" style={{ marginBottom: '20px' }}>
            <label>Bahasa Antarmuka</label>
            <select
              style={{ width: '100%', maxWidth: '200px' }}
              value={language}
              onChange={(e) => setLanguage(e.target.value)}
            >
              <option value="Bahasa Indonesia">Bahasa Indonesia</option>
              <option value="English">English</option>
            </select>
          </div>

          <div className="form-group" style={{ marginBottom: '24px' }}>
            <label>Tema Tampilan</label>
            <span className="helper-text" style={{ display: 'block', marginBottom: '12px' }}>
              Pilih tema terang atau gelap untuk kenyamanan mata.
            </span>
            <div style={{ display: 'flex', gap: '12px' }}>
              <button
                type="button"
                className={`btn ${theme === 'light' ? 'btn-primary' : 'btn-secondary'}`}
                style={{ flex: 1, maxWidth: '150px' }}
                onClick={() => handleThemeChange('light')}
              >
                ☀️ Terang
              </button>
              <button
                type="button"
                className={`btn ${theme === 'dark' ? 'btn-primary' : 'btn-secondary'}`}
                style={{ flex: 1, maxWidth: '150px' }}
                onClick={() => handleThemeChange('dark')}
              >
                🌙 Gelap
              </button>
            </div>
          </div>

          <div className="card-actions">
            <button type="submit" className="btn btn-primary">
              Simpan Tampilan
            </button>
          </div>
        </form>
      </div>

      {/* 6. Logout Card */}
      <div className="card" style={{ border: '2px solid #ffedd5', background: '#fff7ed' }}>
        <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between', flexWrap: 'wrap', gap: '16px' }}>
          <div style={{ display: 'flex', alignItems: 'center', gap: '16px' }}>
            <div
              style={{
                width: '48px',
                height: '48px',
                background: '#ffedd5',
                borderOrigin: '1px solid #fed7aa',
                borderRadius: '12px',
                display: 'flex',
                alignItems: 'center',
                justifycontent: 'center',
                justifyContent: 'center',
                color: '#ea580c',
                flexShrink: 0,
              }}
            >
              <svg width="24" height="24" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                <path strokeLinecap="round" strokeLinejoin="round" strokeWidth="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1"></path>
              </svg>
            </div>
            <div>
              <h3 style={{ fontSize: '16px', fontWeight: 600, color: '#9a3412', marginBottom: '4px' }}>
                Keluar dari Sesi Ini
              </h3>
              <p style={{ fontSize: '14px', color: '#c2410c' }}>
                Kamu akan keluar dari akun NOERA di perangkat ini.
              </p>
            </div>
          </div>
          <button className="btn btn-warning" onClick={handleLogout}>
            Keluar Sekarang
          </button>
        </div>
      </div>

      {/* TOAST FEEDBACK NOTIFICATION */}
      {toast.show && (
        <div className="toast-notification">
          <div className="icon">✓</div>
          {toast.message}
        </div>
      )}
    </div>
  );
}
