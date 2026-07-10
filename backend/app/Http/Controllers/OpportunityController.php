<?php

namespace App\Http\Controllers;

use App\Models\Opportunity;
use App\Models\OpportunityTag;
use App\Models\SavedOpportunity;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class OpportunityController extends Controller
{
    /**
     * Menampilkan daftar peluang berdasarkan tipe (beasiswa, kompetisi, atau seminar+webinar)
     */
    public function index(Request $request, $type)
    {
        $currentUser = Auth::user();

        $query = Opportunity::with('tags')->orderByDesc('created_at');

        // "seminar-webinar" mencakup 2 tipe sekaligus
        if ($type === 'seminar-webinar') {
            $query->whereIn('type', ['seminar', 'webinar']);
            $pageTitle = 'Seminar & Webinar';
        } elseif ($type === 'beasiswa') {
            $query->where('type', 'beasiswa');
            $pageTitle = 'Peluang Beasiswa';
        } elseif ($type === 'kompetisi') {
            $query->where('type', 'kompetisi');
            $pageTitle = 'Info Kompetisi';
        } else {
            abort(404);
        }

        // Filter pencarian (judul / penyelenggara)
        if ($request->filled('search')) {
            $search = $request->search;
            $query->where(function ($q) use ($search) {
                $q->where('title', 'like', "%{$search}%")
                  ->orWhere('organizer', 'like', "%{$search}%");
            });
        }

        // Filter berdasarkan tag (mis. ?tag=Prestasi)
        if ($request->filled('tag')) {
            $tag = $request->tag;
            $query->whereHas('tags', function ($q) use ($tag) {
                $q->where('tag', $tag);
            });
        }

        // Pagination: 9 data per halaman, otomatis ikut query string (?search=...&tag=...)
        $opportunities = $query->paginate(9)->withQueryString();

        // Ambil semua tag unik untuk tipe ini (buat dropdown filter di view)
        $availableTags = OpportunityTag::whereHas('opportunity', function ($q) use ($type) {
            if ($type === 'seminar-webinar') {
                $q->whereIn('type', ['seminar', 'webinar']);
            } else {
                $q->where('type', $type);
            }
        })->distinct()->pluck('tag');

        // Ambil daftar opportunity_id yang sudah disimpan user ini
        $savedIds = SavedOpportunity::where('user_id', $currentUser->id)
            ->pluck('opportunity_id')
            ->toArray();

        return view('opportunities.index', [
            'opportunities' => $opportunities,
            'savedIds' => $savedIds,
            'type' => $type,
            'pageTitle' => $pageTitle,
            'availableTags' => $availableTags,
            'user' => $currentUser,
        ]);
    }

    /**
     * Simpan/hapus bookmark peluang (toggle)
     */
    public function toggleSave($opportunityId)
    {
        $userId = Auth::id();

        $existing = SavedOpportunity::where('user_id', $userId)
            ->where('opportunity_id', $opportunityId)
            ->first();

        if ($existing) {
            $existing->delete();
            return back()->with('success', 'Peluang dihapus dari daftar simpan.');
        }

        SavedOpportunity::create([
            'user_id' => $userId,
            'opportunity_id' => $opportunityId,
        ]);

        return back()->with('success', 'Peluang berhasil disimpan!');
    }
}
