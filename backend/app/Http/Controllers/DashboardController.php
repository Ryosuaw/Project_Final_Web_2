<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index()
    {
        // Ambil data user yang sedang login.
        $user = DB::table('users')->where('id', auth()->id())->first();

        // Hitung jumlah skill aktif milik user (yang tipe "teach")
        $skillAktifCount = DB::table('user_skills')
            ->where('user_id', $user->id)
            ->where('type', 'teach')
            ->count();

        // Hitung jumlah partner request yang masuk untuk user ini (status pending)
        $partnerRequestCount = DB::table('partner_requests')
            ->where('receiver_id', $user->id)
            ->where('status', 'pending')
            ->count();

        // Hitung jumlah peluang yang disimpan
        $savedOpportunityCount = DB::table('saved_opportunities')
            ->where('user_id', $user->id)
            ->count();

        // Rata-rata match rate dari partner request yang masuk
        $matchRate = DB::table('partner_requests')
            ->where('receiver_id', $user->id)
            ->avg('match_percentage');
        $matchRate = $matchRate ? round($matchRate) : 0;

        // Ambil 3 peluang terbaru (beasiswa/kompetisi/seminar/webinar), lengkap dengan tag-nya
        $opportunities = DB::table('opportunities')
            ->orderByDesc('created_at')
            ->limit(3)
            ->get()
            ->map(function ($opp) {
                $opp->tags = DB::table('opportunity_tags')
                    ->where('opportunity_id', $opp->id)
                    ->pluck('tag');
                return $opp;
            });

        // Ambil partner request yang masuk untuk user ini, lengkap dengan data pengirim & skill-nya
        $partnerRequests = DB::table('partner_requests')
            ->join('users', 'partner_requests.sender_id', '=', 'users.id')
            ->where('partner_requests.receiver_id', $user->id)
            ->where('partner_requests.status', 'pending')
            ->select('partner_requests.*', 'users.name as sender_name', 'users.major as sender_major',
                'users.university as sender_university', 'users.profile_photo as sender_photo')
            ->get()
            ->map(function ($req) {
                $req->skills_teach = DB::table('user_skills')
                    ->join('skills', 'user_skills.skill_id', '=', 'skills.id')
                    ->where('user_skills.user_id', $req->sender_id)
                    ->where('user_skills.type', 'teach')
                    ->pluck('skills.name');

                $req->skills_learn = DB::table('user_skills')
                    ->join('skills', 'user_skills.skill_id', '=', 'skills.id')
                    ->where('user_skills.user_id', $req->sender_id)
                    ->where('user_skills.type', 'learn')
                    ->pluck('skills.name');

                return $req;
            });

        // Skill milik user sendiri (untuk ditampilkan di profile card kanan)
        $mySkills = DB::table('user_skills')
            ->join('skills', 'user_skills.skill_id', '=', 'skills.id')
            ->where('user_skills.user_id', $user->id)
            ->pluck('skills.name');

        // Aktivitas terkini milik user
        $activities = DB::table('activities')
            ->where('user_id', $user->id)
            ->orderByDesc('created_at')
            ->limit(5)
            ->get();

        return view('dashboard', compact(
            'user',
            'skillAktifCount',
            'partnerRequestCount',
            'savedOpportunityCount',
            'matchRate',
            'opportunities',
            'partnerRequests',
            'mySkills',
            'activities'
        ));
    }
}
