<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class UserSkillSeeder extends Seeder
{
    public function run(): void
    {
        $cicaId = DB::table('users')->where('email', 'cica@example.com')->value('id');
        $amandaId = DB::table('users')->where('email', 'amanda@example.com')->value('id');
        $budiId = DB::table('users')->where('email', 'budi@example.com')->value('id');

        $skillId = fn (string $name) => DB::table('skills')->where('name', $name)->value('id');

        $rows = [
            // Skill milik Kakak Cica (SKILL SAYA di halaman profil)
            ['user_id' => $cicaId, 'skill_id' => $skillId('Flutter'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $cicaId, 'skill_id' => $skillId('Dart'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $cicaId, 'skill_id' => $skillId('Firebase'), 'type' => 'teach', 'level' => 'menengah'],
            ['user_id' => $cicaId, 'skill_id' => $skillId('Figma Basics'), 'type' => 'teach', 'level' => 'pemula'],
            ['user_id' => $cicaId, 'skill_id' => $skillId('Python'), 'type' => 'teach', 'level' => 'menengah'],
            ['user_id' => $cicaId, 'skill_id' => $skillId('Data Analysis'), 'type' => 'teach', 'level' => 'pemula'],

            // Amanda Putri: bisa mengajari Laravel Backend & REST API, ingin belajar Flutter
            ['user_id' => $amandaId, 'skill_id' => $skillId('Laravel Backend'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $amandaId, 'skill_id' => $skillId('REST API'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $amandaId, 'skill_id' => $skillId('Flutter'), 'type' => 'learn', 'level' => null],

            // Budi Santoso: bisa mengajari UI/UX Design & Figma, ingin belajar React Native
            ['user_id' => $budiId, 'skill_id' => $skillId('UI/UX Design'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $budiId, 'skill_id' => $skillId('Figma Basics'), 'type' => 'teach', 'level' => 'mahir'],
            ['user_id' => $budiId, 'skill_id' => $skillId('React Native'), 'type' => 'learn', 'level' => null],
        ];

        foreach ($rows as $row) {
            DB::table('user_skills')->insertOrIgnore([
                ...$row,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
