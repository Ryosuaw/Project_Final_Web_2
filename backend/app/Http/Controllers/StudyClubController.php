<?php

namespace App\Http\Controllers;

use App\Models\StudyClub;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class StudyClubController extends Controller
{
    /**
     * Menampilkan daftar semua study club
     */
    public function index(Request $request)
    {
        $currentUser = Auth::user();

        $query = StudyClub::withCount('members')->with('creator')->orderByDesc('created_at');

        // Filter pencarian berdasarkan nama grup
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where('name', 'like', "%{$search}%");
        }

        $studyClubs = $query->paginate(9)->withQueryString();

        // Ambil daftar ID grup yang sudah diikuti user ini
        $joinedIds = $currentUser->studyClubs()->pluck('study_clubs.id')->toArray();

        return view('study-club.index', [
            'studyClubs' => $studyClubs,
            'joinedIds' => $joinedIds,
            'user' => $currentUser,
        ]);
    }

    /**
     * Membuat study club baru
     */
    public function store(Request $request)
    {
        $request->validate([
            'name' => 'required|string|max:255',
            'description' => 'nullable|string',
        ]);

        $studyClub = StudyClub::create([
            'name' => $request->name,
            'description' => $request->description,
            'created_by' => Auth::id(),
        ]);

        // Pembuat grup otomatis jadi anggota pertama
        $studyClub->members()->attach(Auth::id(), ['joined_at' => now()]);

        return back()->with('success', 'Study club berhasil dibuat!');
    }

    /**
     * Gabung ke study club
     */
    public function join($studyClubId)
    {
        $studyClub = StudyClub::findOrFail($studyClubId);
        $userId = Auth::id();

        if (!$studyClub->members()->where('user_id', $userId)->exists()) {
            $studyClub->members()->attach($userId, ['joined_at' => now()]);
        }

        return back()->with('success', 'Berhasil bergabung ke ' . $studyClub->name . '!');
    }

    /**
     * Keluar dari study club
     */
    public function leave($studyClubId)
    {
        $studyClub = StudyClub::findOrFail($studyClubId);

        $studyClub->members()->detach(Auth::id());

        return back()->with('success', 'Kamu telah keluar dari ' . $studyClub->name . '.');
    }
}