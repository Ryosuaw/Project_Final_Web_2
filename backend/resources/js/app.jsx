import React from 'react';
import { createRoot } from 'react-dom/client';
import { BrowserRouter, Routes, Route } from 'react-router-dom';

import AppLayout from './AppLayout';
import Dashboard from './pages/Dashboard/Dashboard';
import SkillExchange from './pages/SkillExchange/SkillExchange';
import PeluangBeasiswa from './pages/PeluangBeasiswa/PeluangBeasiswa';
import InfoKompetisi from './pages/InfoKompetisi/InfoKompetisi';
import SeminarWebinar from './pages/SeminarWebinar/SeminarWebinar';
import StudyClub from './pages/StudyClub/StudyClub';
import Profile from './pages/Profile/Profile';
import Settings from './pages/Settings/Settings';

const container = document.getElementById('app');
const root = createRoot(container);

root.render(
  <React.StrictMode>
    <BrowserRouter>
      <Routes>
        <Route element={<AppLayout />}>
          <Route path="/" element={<Dashboard />} />
          <Route path="/skill-exchange" element={<SkillExchange />} />
          <Route path="/peluang-beasiswa" element={<PeluangBeasiswa />} />
          <Route path="/info-kompetisi" element={<InfoKompetisi />} />
          <Route path="/seminar-webinar" element={<SeminarWebinar />} />
          <Route path="/study-club" element={<StudyClub />} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/settings" element={<Settings />} />
        </Route>
      </Routes>
    </BrowserRouter>
  </React.StrictMode>
);
