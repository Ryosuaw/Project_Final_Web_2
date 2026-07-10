<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class StudyClubSeeder extends Seeder
{
    public function run(): void
    {
        $cicaId = DB::table('users')->where('email', 'cica@example.com')->value('id');

        $clubId = DB::table('study_clubs')->insertGetId([
            'name' => 'NOERA Study Club',
            'description' => 'Gabung grup belajar dan tukar ilmu mingguan bareng mentor mahasiswa.',
            'created_by' => $cicaId,
            'created_at' => now(),
            'updated_at' => now(),
        ]);

        DB::table('study_club_members')->insert([
            'study_club_id' => $clubId,
            'user_id' => $cicaId,
            'joined_at' => now(),
            'created_at' => now(),
            'updated_at' => now(),
        ]);
    }
}
