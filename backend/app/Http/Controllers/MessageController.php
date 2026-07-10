<?php

namespace App\Http\Controllers;

use App\Models\Message;
use App\Models\PartnerRequest;
use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class MessageController extends Controller
{
    /**
     * Daftar semua percakapan (dengan partner yang sudah diterima)
     */
    public function index()
    {
        $currentUser = Auth::user();

        // Ambil semua partner yang sudah "accepted" (bisa saling chat)
        $partnerIds = PartnerRequest::where('status', 'accepted')
            ->where(function ($q) use ($currentUser) {
                $q->where('sender_id', $currentUser->id)
                  ->orWhere('receiver_id', $currentUser->id);
            })
            ->get()
            ->map(function ($req) use ($currentUser) {
                return $req->sender_id == $currentUser->id ? $req->receiver_id : $req->sender_id;
            });

        $conversations = User::whereIn('id', $partnerIds)
            ->get()
            ->map(function ($partner) use ($currentUser) {
                $lastMessage = Message::where(function ($q) use ($currentUser, $partner) {
                        $q->where('sender_id', $currentUser->id)->where('receiver_id', $partner->id);
                    })
                    ->orWhere(function ($q) use ($currentUser, $partner) {
                        $q->where('sender_id', $partner->id)->where('receiver_id', $currentUser->id);
                    })
                    ->orderByDesc('created_at')
                    ->first();

                $unreadCount = Message::where('sender_id', $partner->id)
                    ->where('receiver_id', $currentUser->id)
                    ->where('is_read', false)
                    ->count();

                $partner->last_message = $lastMessage;
                $partner->unread_count = $unreadCount;
                return $partner;
            })
            ->sortByDesc(function ($partner) {
                return $partner->last_message->created_at ?? $partner->created_at;
            })
            ->values();

        return view('messages.index', [
            'conversations' => $conversations,
            'user' => $currentUser,
        ]);
    }

    /**
     * Buka halaman chat dengan partner tertentu
     */
    public function show($userId)
    {
        $currentUser = Auth::user();
        $partner = User::findOrFail($userId);

        $messages = Message::where(function ($q) use ($currentUser, $partner) {
                $q->where('sender_id', $currentUser->id)->where('receiver_id', $partner->id);
            })
            ->orWhere(function ($q) use ($currentUser, $partner) {
                $q->where('sender_id', $partner->id)->where('receiver_id', $currentUser->id);
            })
            ->orderBy('created_at')
            ->get();

        Message::where('sender_id', $partner->id)
            ->where('receiver_id', $currentUser->id)
            ->where('is_read', false)
            ->update(['is_read' => true]);

        return view('messages.show', [
            'messages' => $messages,
            'partner' => $partner,
            'user' => $currentUser,
        ]);
    }

    /**
     * Kirim pesan baru ke partner
     */
    public function store(Request $request, $userId)
    {
        $request->validate([
            'content' => 'required|string|max:1000',
        ]);

        Message::create([
            'sender_id' => Auth::id(),
            'receiver_id' => $userId,
            'content' => $request->content,
            'is_read' => false,
        ]);

        return back();
    }
}