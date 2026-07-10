<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class SkillController extends Controller
{
    /**
     * Tampilkan form tambah skill.
     */
    public function create()
    {
        // Ambil semua skill master yang BELUM dimiliki user ini (biar nggak dobel)
        $userId = auth()->id();

        $existingSkillIds = DB::table('user_skills')
            ->where('user_id', $userId)
            ->pluck('skill_id');

        $availableSkills = DB::table('skills')
            ->whereNotIn('id', $existingSkillIds)
            ->orderBy('name')
            ->get();

        return view('skills.create', compact('availableSkills'));
    }

    /**
     * Simpan skill baru ke profil user.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'skill_id' => ['required', 'exists:skills,id'],
            'type' => ['required', 'in:teach,learn'],
            'level' => ['nullable', 'in:pemula,menengah,mahir'],
        ]);

        $userId = auth()->id();

        // Cegah data dobel (skill + tipe yang sama untuk user yang sama)
        $alreadyExists = DB::table('user_skills')
            ->where('user_id', $userId)
            ->where('skill_id', $validated['skill_id'])
            ->where('type', $validated['type'])
            ->exists();

        if (! $alreadyExists) {
            DB::table('user_skills')->insert([
                'user_id' => $userId,
                'skill_id' => $validated['skill_id'],
                'type' => $validated['type'],
                'level' => $validated['level'] ?? null,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Catat sebagai aktivitas terbaru
            $skillName = DB::table('skills')->where('id', $validated['skill_id'])->value('name');
            DB::table('activities')->insert([
                'user_id' => $userId,
                'type' => 'skill_added',
                'description' => "Skill '{$skillName}' berhasil ditambahkan ke profilmu",
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            // Naikkan sedikit persentase kelengkapan profil (maksimal 100%)
            $user = DB::table('users')->where('id', $userId)->first();
            $newCompletion = min(100, $user->profile_completion + 8);
            DB::table('users')->where('id', $userId)->update([
                'profile_completion' => $newCompletion,
            ]);
        }

        return redirect('/dashboard')->with('status', 'Skill berhasil ditambahkan!');
    }
}
