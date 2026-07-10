@extends('layouts.app')

@section('title', $pageTitle . ' - NOERA')

@section('content')
<div class="page-header">
    <div class="page-header-content">
        <h1>{{ $pageTitle }}</h1>
        <p>Temukan peluang terbaik yang sesuai dengan minat dan kebutuhanmu.</p>
    </div>
</div>

<form method="GET" action="{{ route('opportunities.index', $type) }}" class="search-bar-page">
    <input type="text" name="search" placeholder="Cari berdasarkan judul atau penyelenggara..." value="{{ request('search') }}">

    @if ($availableTags->count())
        <select name="tag" onchange="this.form.submit()" class="opp-filter-select">
            <option value="">Semua Kategori</option>
            @foreach ($availableTags as $tagOption)
                <option value="{{ $tagOption }}" {{ request('tag') == $tagOption ? 'selected' : '' }}>
                    {{ $tagOption }}
                </option>
            @endforeach
        </select>
    @endif

    <button type="submit" class="btn btn-primary">Cari</button>
</form>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Semua {{ $pageTitle }}</div>
    </div>

    <div class="opp-grid">
        @forelse ($opportunities as $opp)
            <div class="opp-card">
                <div class="opp-card-header">
                    <span class="opp-tag opp-tag-{{ $opp->type }}">
                        {{ ucfirst($opp->type) }}
                    </span>
                    <form method="POST" action="{{ route('opportunities.toggle-save', $opp->id) }}">
                        @csrf
                        <button type="submit" class="opp-bookmark"
                            style="{{ in_array($opp->id, $savedIds) ? 'background: var(--primary-light); border-color: var(--primary); color: var(--primary);' : '' }}"
                            title="{{ in_array($opp->id, $savedIds) ? 'Batalkan simpan' : 'Simpan peluang' }}">
                            <svg fill="{{ in_array($opp->id, $savedIds) ? 'currentColor' : 'none' }}" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M5 5a2 2 0 012-2h10a2 2 0 012 2v16l-7-3.5L5 21V5z"/></svg>
                        </button>
                    </form>
                </div>
                <h3 class="opp-title">{{ $opp->title }}</h3>
                <div class="opp-org">
                    <svg fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path stroke-linecap="round" stroke-linejoin="round" d="M19 21V5a2 2 0 00-2-2H7a2 2 0 00-2 2v16m14 0h2m-2 0h-5m-9 0H3m2 0h5M9 7h1m-1 4h1m4-4h1m-1 4h1m-5 10v-5a1 1 0 011-1h2a1 1 0 011 1v5m-4 0h4"/></svg>
                    {{ $opp->organizer }}
                </div>
                <div class="opp-tags">
                    @foreach ($opp->tags as $tag)
                        <span class="opp-tag-sm">{{ $tag->tag }}</span>
                    @endforeach
                </div>
                <div class="opp-meta">
                    <div class="opp-meta-item">
                        <label>Deadline</label>
                        <span class="deadline">
                            {{ $opp->deadline ? \Carbon\Carbon::parse($opp->deadline)->translatedFormat('d M Y') : '-' }}
                        </span>
                    </div>
                    <div class="opp-meta-item">
                        <label>Benefit</label>
                        <span class="benefit">{{ $opp->benefit ?? '-' }}</span>
                    </div>
                </div>
                @if ($opp->description)
                    <p style="font-size: 13px; color: var(--gray-600); margin-bottom: var(--space-4); line-height: 1.5;">
                        {{ Str::limit($opp->description, 120) }}
                    </p>
                @endif
            </div>
        @empty
            <div class="empty-state">Belum ada {{ strtolower($pageTitle) }} tersedia.</div>
        @endforelse
    </div>

    @if ($opportunities->hasPages())
        <div class="opp-pagination">
            {{-- Tombol sebelumnya --}}
            @if ($opportunities->onFirstPage())
                <span class="opp-page-btn opp-page-disabled">&laquo; Sebelumnya</span>
            @else
                <a href="{{ $opportunities->previousPageUrl() }}" class="opp-page-btn">&laquo; Sebelumnya</a>
            @endif

            {{-- Nomor halaman --}}
            @foreach (range(1, $opportunities->lastPage()) as $page)
                @if ($page == $opportunities->currentPage())
                    <span class="opp-page-btn opp-page-active">{{ $page }}</span>
                @else
                    <a href="{{ $opportunities->url($page) }}" class="opp-page-btn">{{ $page }}</a>
                @endif
            @endforeach

            {{-- Tombol selanjutnya --}}
            @if ($opportunities->hasMorePages())
                <a href="{{ $opportunities->nextPageUrl() }}" class="opp-page-btn">Selanjutnya &raquo;</a>
            @else
                <span class="opp-page-btn opp-page-disabled">Selanjutnya &raquo;</span>
            @endif
        </div>
    @endif
</div>
@endsection

@push('styles')
<style>
.opp-filter-select {
    padding: 10px 14px;
    border: 1px solid var(--gray-300, #d1d5db);
    border-radius: 8px;
    font-size: 14px;
    background: white;
    color: var(--gray-700, #374151);
    margin: 0 8px;
}

.opp-pagination {
    display: flex;
    justify-content: center;
    align-items: center;
    gap: 6px;
    margin-top: var(--space-6, 24px);
    flex-wrap: wrap;
}

.opp-page-btn {
    padding: 8px 14px;
    border: 1px solid var(--gray-300, #d1d5db);
    border-radius: 8px;
    font-size: 14px;
    color: var(--gray-700, #374151);
    text-decoration: none;
    transition: all 0.15s ease;
}

.opp-page-btn:hover {
    background: var(--primary-light, #eff6ff);
    border-color: var(--primary, #2563eb);
    color: var(--primary, #2563eb);
}

.opp-page-active {
    background: var(--primary, #2563eb);
    border-color: var(--primary, #2563eb);
    color: white;
    font-weight: 600;
}

.opp-page-disabled {
    opacity: 0.4;
    cursor: not-allowed;
    pointer-events: none;
}
</style>
@endpush
