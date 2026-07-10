@extends('layouts.app')

@section('title', 'Skill Exchange - NOERA')

@section('content')
<div class="page-header">
    <div style="display: flex; gap: 8px; margin-bottom: 24px; border-bottom: 1px solid var(--border-default);">
    <a href="{{ url('/skill-exchange') }}" 
       style="padding: 10px 16px; text-decoration: none; font-size: 14px; font-weight: 600; 
              color: {{ ($tab ?? 'search') === 'search' ? 'var(--primary)' : 'var(--gray-600)' }}; 
              border-bottom: 2px solid {{ ($tab ?? 'search') === 'search' ? 'var(--primary)' : 'transparent' }};">
        Cari Partner
    </a>
    <a href="{{ url('/skill-exchange?tab=my-partners') }}" 
       style="padding: 10px 16px; text-decoration: none; font-size: 14px; font-weight: 600; 
              color: {{ ($tab ?? 'search') === 'my-partners' ? 'var(--primary)' : 'var(--gray-600)' }}; 
              border-bottom: 2px solid {{ ($tab ?? 'search') === 'my-partners' ? 'var(--primary)' : 'transparent' }};">
        Partner Saya
    </a>
</div>
    <div class="page-header-content">
        <h1>Skill Exchange</h1>
        <p>Temukan mahasiswa lain untuk saling bertukar skill. Cari partner yang bisa mengajarkan skill yang ingin kamu pelajari.</p>
    </div>
</div>
@if (($tab ?? 'search') !== 'my-partners')
<form method="GET" action="{{ url('/skill-exchange') }}" class="search-bar-page">
    <input type="text" name="search" placeholder="Cari nama mahasiswa atau skill..." value="{{ request('search') }}">
    <button type="submit" class="btn btn-primary">Cari</button>
</form>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Partner yang Cocok Untukmu</div>
    </div>

    <div class="partner-grid">
        @forelse ($partners as $partner)
            <div class="partner-card">
                <div class="partner-header">
                    <div class="partner-avatar">
                        <img src="https://ui-avatars.com/api/?name={{ urlencode($partner->name) }}&background=0066ff&color=fff" alt="{{ $partner->name }}">
                    </div>
                    <div class="partner-info">
                        <div class="partner-name">{{ $partner->name }}</div>
                        <div class="partner-role">{{ $partner->major ?? '-' }}</div>
                        <div class="partner-location">{{ $partner->university ?? '-' }}</div>
                    </div>
                    <div class="partner-match">
                        <div class="partner-match-value">{{ $partner->match_percentage }}%</div>
                        <div class="partner-match-label">Match</div>
                    </div>
                </div>

                @php
                    $teachSkills = $partner->userSkills->where('type', 'teach');
                    $learnSkills = $partner->userSkills->where('type', 'learn');
                @endphp

                @if ($teachSkills->count() > 0)
                    <div class="partner-skills-section">
                        <div class="partner-skills-label teach">Bisa Mengajar</div>
                        <div class="partner-skill-tags">
                            @foreach ($teachSkills as $us)
                                <span class="partner-skill-tag teach">{{ $us->skill->name }}</span>
                            @endforeach
                        </div>
                    </div>
                @endif

                @if ($learnSkills->count() > 0)
                    <div class="partner-skills-section">
                        <div class="partner-skills-label learn">Ingin Belajar</div>
                        <div class="partner-skill-tags">
                            @foreach ($learnSkills as $us)
                                <span class="partner-skill-tag learn">{{ $us->skill->name }}</span>
                            @endforeach
                        </div>
                    </div>
                @endif

<div class="partner-actions" style="flex-direction: column;">
    @if (in_array($partner->id, $pendingRequestUserIds))
        <button class="btn btn-ghost" style="width: 100%; cursor: not-allowed;" disabled>
            ⏳ Menunggu Respon
        </button>
    @else
        <form method="POST" action="{{ url('/skill-exchange/' . $partner->id . '/request') }}" style="width: 100%;">
            @csrf
            <textarea name="message" placeholder="Tulis pesan singkat, contoh: Mau buat aplikasi mobile, butuh partner Flutter." 
                style="width: 100%; padding: 10px; border: 1px solid var(--border-default); border-radius: var(--radius-md); font-family: var(--font-sans); font-size: 13px; resize: vertical; min-height: 60px; margin-bottom: var(--space-2);"></textarea>
            <button type="submit" class="btn btn-primary" style="width: 100%;">Kirim Request</button>
        </form>
    @endif
</div>
        @empty
            <div class="empty-state">Belum ada partner yang cocok. Tambahkan skill kamu dulu di profil.</div>
        @endforelse
    </div>
</div>

@else
    <div class="section-card">
        <div class="section-header">
            <div class="section-title">Partner Saya</div>
        </div>

        <div class="partner-grid">
            @forelse ($myPartners as $partner)
                <div class="partner-card">
                    <div class="partner-header">
                        <div class="partner-avatar">
                            <img src="https://ui-avatars.com/api/?name={{ urlencode($partner->name) }}&background=0066ff&color=fff" alt="{{ $partner->name }}">
                        </div>
                        <div class="partner-info">
                            <div class="partner-name">{{ $partner->name }}</div>
                            <div class="partner-role">{{ $partner->major ?? '-' }}</div>
                            <div class="partner-location">{{ $partner->university ?? '-' }}</div>
                        </div>
                        <div class="partner-match">
                            <div class="partner-match-value">{{ $partner->match_percentage }}%</div>
                            <div class="partner-match-label">Match</div>
                        </div>
                    </div>

                    @php
                        $teachSkills = $partner->userSkills->where('type', 'teach');
                        $learnSkills = $partner->userSkills->where('type', 'learn');
                    @endphp

                    @if ($teachSkills->count() > 0)
                        <div class="partner-skills-section">
                            <div class="partner-skills-label teach">Bisa Mengajar</div>
                            <div class="partner-skill-tags">
                                @foreach ($teachSkills as $us)
                                    <span class="partner-skill-tag teach">{{ $us->skill->name }}</span>
                                @endforeach
                            </div>
                        </div>
                    @endif

                    @if ($learnSkills->count() > 0)
                        <div class="partner-skills-section">
                            <div class="partner-skills-label learn">Ingin Belajar</div>
                            <div class="partner-skill-tags">
                                @foreach ($learnSkills as $us)
                                    <span class="partner-skill-tag learn">{{ $us->skill->name }}</span>
                                @endforeach
                            </div>
                        </div>
                    @endif
                </div>
            @empty
                <div class="empty-state">Belum ada partner aktif. Terima partner request untuk mulai kolaborasi.</div>
            @endforelse
        </div>
    </div>
@endif

@endsection