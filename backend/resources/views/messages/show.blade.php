@extends('layouts.app')

@section('title', 'Chat dengan ' . $partner->name . ' - NOERA')

@section('content')
<div class="page-header">
    <div class="page-header-content">
        <h1>
            <a href="{{ route('messages.index') }}" style="color: var(--gray-400); text-decoration: none; margin-right: 8px;">←</a>
            Chat dengan {{ $partner->name }}
        </h1>
        <p>{{ $partner->major ?? '-' }} — {{ $partner->university ?? '-' }}</p>
    </div>
</div>

<div class="section-card" style="display: flex; flex-direction: column; height: 60vh;">
    <div id="chat-box" style="flex: 1; overflow-y: auto; display: flex; flex-direction: column; gap: 12px; padding-bottom: 16px;">
        @forelse ($messages as $msg)
            @php $isMine = $msg->sender_id === $user->id; @endphp
            <div style="display: flex; justify-content: {{ $isMine ? 'flex-end' : 'flex-start' }};">
                <div style="max-width: 60%; padding: 10px 14px; border-radius: 14px; font-size: 13px; line-height: 1.5;
                    background: {{ $isMine ? 'var(--primary)' : 'var(--gray-100)' }};
                    color: {{ $isMine ? 'white' : 'var(--gray-900)' }};">
                    {{ $msg->content }}
                    <div style="font-size: 10px; margin-top: 4px; opacity: 0.7;">
                        {{ \Carbon\Carbon::parse($msg->created_at)->format('H:i') }}
                    </div>
                </div>
            </div>
        @empty
            <div class="empty-state">Belum ada pesan. Mulai percakapan dengan {{ $partner->name }}!</div>
        @endforelse
    </div>

    <form method="POST" action="{{ route('messages.store', $partner->id) }}" style="display: flex; gap: 10px; border-top: 1px solid var(--border-default); padding-top: 16px;">
        @csrf
        <input type="text" name="content" placeholder="Tulis pesan..." required
            style="flex: 1; padding: 10px 14px; border: 1px solid var(--border-default); border-radius: var(--radius-md); font-size: 13px; font-family: var(--font-sans);">
        <button type="submit" class="btn btn-primary">Kirim</button>
    </form>
</div>

<script>
    var chatBox = document.getElementById('chat-box');
    chatBox.scrollTop = chatBox.scrollHeight;
</script>
@endsection