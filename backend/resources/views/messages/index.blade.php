@extends('layouts.app')

@section('title', 'Pesan - NOERA')

@section('content')
<div class="page-header">
    <div class="page-header-content">
        <h1>Pesan</h1>
        <p>Chat dengan partner skill exchange yang sudah kamu terima.</p>
    </div>
</div>

<div class="section-card">
    <div class="section-header">
        <div class="section-title">Semua Percakapan</div>
    </div>

    <div style="display: flex; flex-direction: column; gap: 4px;">
        @forelse ($conversations as $partner)
            <a href="{{ route('messages.show', $partner->id) }}" style="text-decoration: none; color: inherit;">
                <div style="display: flex; align-items: center; gap: var(--space-4); padding: var(--space-4); border-radius: var(--radius-lg); transition: background 0.1s ease;"
                     onmouseover="this.style.background='var(--gray-50)'" onmouseout="this.style.background='transparent'">
                    <div class="partner-avatar" style="width: 48px; height: 48px;">
                        <img src="https://ui-avatars.com/api/?name={{ urlencode($partner->name) }}&background=0066ff&color=fff" alt="{{ $partner->name }}">
                    </div>
                    <div style="flex: 1; min-width: 0;">
                        <div style="display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-family: var(--font-display); font-weight: 700; font-size: 14px; color: var(--gray-900);">{{ $partner->name }}</span>
                            @if ($partner->last_message)
                                <span style="font-size: 11px; color: var(--gray-500);">{{ \Carbon\Carbon::parse($partner->last_message->created_at)->diffForHumans() }}</span>
                            @endif
                        </div>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 2px;">
                            <span style="font-size: 13px; color: var(--gray-600); white-space: nowrap; overflow: hidden; text-overflow: ellipsis; max-width: 400px;">
                                {{ $partner->last_message->content ?? 'Belum ada pesan. Mulai chat sekarang!' }}
                            </span>
                            @if ($partner->unread_count > 0)
                                <span class="badge-count" style="position: static; border: none;">{{ $partner->unread_count }}</span>
                            @endif
                        </div>
                    </div>
                </div>
            </a>
        @empty
            <div class="empty-state">Belum ada partner untuk dichat. Terima partner request terlebih dahulu di Skill Exchange.</div>
        @endforelse
    </div>
</div>
@endsection