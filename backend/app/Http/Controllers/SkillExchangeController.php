<?php

namespace App\Http\Controllers;

use App\Models\User;
use App\Models\Skill;
use App\Models\UserSkill;
use App\Models\PartnerRequest;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class SkillExchangeController extends Controller
{
    /**
     * Halaman utama Skill Exchange - menampilkan daftar partner potensial
     */
    
    public function index(Request $request)
{
    $currentUser = Auth::user();
    $tab = $request->get('tab', 'search');

    // Kalau tab "Partner Saya", ambil partner yang statusnya sudah diterima
    if ($tab === 'my-partners') {
        $myPartners = PartnerRequest::where('status', 'accepted')
            ->where(function ($q) use ($currentUser) {
                $q->where('sender_id', $currentUser->id)
                  ->orWhere('receiver_id', $currentUser->id);
            })
            ->get()
            ->map(function ($req) use ($currentUser) {
                // Tentukan siapa "partner"-nya (lawan bicara, bukan diri sendiri)
                $partnerId = $req->sender_id == $currentUser->id ? $req->receiver_id : $req->sender_id;
                $partner = User::with('userSkills.skill')->find($partnerId);
                $partner->match_percentage = $req->match_percentage ?? 0;
                return $partner;
            });

        return view('skill-exchange.index', [
            'tab' => $tab,
            'myPartners' => $myPartners,
            'currentUser' => $currentUser,
            'user' => $currentUser,
        ]);
    }

        // Ambil skill yang ingin dipelajari user saat ini
        $mySkillsToLearn = $currentUser->userSkills()
            ->where('type', 'learn')
            ->pluck('skill_id');

        // Ambil skill yang bisa diajarkan user saat ini
        $mySkillsToTeach = $currentUser->userSkills()
            ->where('type', 'teach')
            ->pluck('skill_id');

        // Cari user lain yang punya skill yang match
        $query = User::where('id', '!=', $currentUser->id)
            ->with(['userSkills.skill']);

        // Filter pencarian (kalau ada keyword)
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('name', 'like', "%{$search}%")
                  ->orWhereHas('userSkills.skill', function ($sq) use ($search) {
                      $sq->where('name', 'like', "%{$search}%");
                  });
            });
        }

        $partners = $query->get()->map(function ($user) use ($mySkillsToLearn, $mySkillsToTeach) {
            $theirTeachSkills = $user->userSkills->where('type', 'teach')->pluck('skill_id');
            $theirLearnSkills = $user->userSkills->where('type', 'learn')->pluck('skill_id');

            // Hitung match: skill yang mereka ajarkan & aku ingin pelajari, atau sebaliknya
            $matchTeach = $theirTeachSkills->intersect($mySkillsToLearn)->count();
            $matchLearn = $theirLearnSkills->intersect($mySkillsToTeach)->count();
            $totalPossible = max($mySkillsToLearn->count() + $mySkillsToTeach->count(), 1);

            $matchPercentage = round((($matchTeach + $matchLearn) / $totalPossible) * 100);

            $user->match_percentage = min($matchPercentage, 100);
            return $user;
        })->sortByDesc('match_percentage')->values();

        // Ambil daftar user_id yang sudah dikirimi request pending oleh user saat ini
        $pendingRequestUserIds = PartnerRequest::where('sender_id', $currentUser->id)
            ->where('status', 'pending')
            ->pluck('receiver_id')
            ->toArray();

        return view('skill-exchange.index', [
            'partners' => $partners,
            'currentUser' => $currentUser,
            'user' => $currentUser,
            'pendingRequestUserIds' => $pendingRequestUserIds,
        ]);
    }

    /**
     * Kirim partner request ke user lain
     */
    public function sendRequest(Request $request, $userId)
{
    $request->validate([
        'message' => 'nullable|string|max:255',
    ]);

    $receiver = User::findOrFail($userId);
    $currentUser = Auth::user();

    // Cek apakah sudah pernah kirim request yang masih pending
    $existing = PartnerRequest::where('sender_id', Auth::id())
        ->where('receiver_id', $userId)
        ->where('status', 'pending')
        ->first();

    if ($existing) {
        return back()->with('error', 'Kamu sudah mengirim request ke partner ini.');
    }

    // Hitung match percentage antara pengirim & penerima
    $mySkillsToLearn = $currentUser->userSkills()->where('type', 'learn')->pluck('skill_id');
    $mySkillsToTeach = $currentUser->userSkills()->where('type', 'teach')->pluck('skill_id');
    $theirTeachSkills = $receiver->userSkills()->where('type', 'teach')->pluck('skill_id');
    $theirLearnSkills = $receiver->userSkills()->where('type', 'learn')->pluck('skill_id');

    $matchTeach = $theirTeachSkills->intersect($mySkillsToLearn)->count();
    $matchLearn = $theirLearnSkills->intersect($mySkillsToTeach)->count();
    $totalPossible = max($mySkillsToLearn->count() + $mySkillsToTeach->count(), 1);
    $matchPercentage = min(round((($matchTeach + $matchLearn) / $totalPossible) * 100), 100);

    PartnerRequest::create([
        'sender_id' => Auth::id(),
        'receiver_id' => $userId,
        'match_percentage' => $matchPercentage,
        'message' => $request->message,
        'status' => 'pending',
    ]);

    return back()->with('success', 'Partner request berhasil dikirim!');
}

    /**
     * Terima partner request
     */
    public function acceptRequest($requestId)
    {
        $partnerRequest = PartnerRequest::where('id', $requestId)
            ->where('receiver_id', Auth::id())
            ->firstOrFail();

        $partnerRequest->update(['status' => 'accepted']);

        return back()->with('success', 'Partner request diterima!');
    }

    /**
     * Tolak partner request
     */
    public function rejectRequest($requestId)
    {
        $partnerRequest = PartnerRequest::where('id', $requestId)
            ->where('receiver_id', Auth::id())
            ->firstOrFail();

        $partnerRequest->update(['status' => 'rejected']);

        return back()->with('success', 'Partner request ditolak.');
    }
}