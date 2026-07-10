<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class ActivitySeeder extends Seeder
{
    public function run(): void
    {
        $cicaId = DB::table('users')->where('email', 'cica@example.com')->value('id');

        $activities = [
            ['type' => 'partner_request', 'description' => 'Amanda Putri mengirim partner request padamu'],
            ['type' => 'bookmark', 'description' => 'Kamu menyimpan Beasiswa Unggulan Kemendikbud'],
            ['type' => 'skill_added', 'description' => "Skill 'Flutter' berhasil ditambahkan ke profilmu"],
            ['type' => 'opportunity_added', 'description' => 'Webinar Flutter UI Slicing dibuka. Pendaftaran gratis!'],
            ['type' => 'opportunity_added', 'description' => 'National UX Design Challenge 2025 baru ditambahkan'],
        ];

        foreach ($activities as $activity) {
            DB::table('activities')->insert([
                'user_id' => $cicaId,
                ...$activity,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
