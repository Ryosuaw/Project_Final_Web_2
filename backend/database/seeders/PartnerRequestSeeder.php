<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class PartnerRequestSeeder extends Seeder
{
    public function run(): void
    {
        $cicaId = DB::table('users')->where('email', 'cica@example.com')->value('id');
        $amandaId = DB::table('users')->where('email', 'amanda@example.com')->value('id');
        $budiId = DB::table('users')->where('email', 'budi@example.com')->value('id');

        DB::table('partner_requests')->insert([
            [
                'sender_id' => $amandaId,
                'receiver_id' => $cicaId,
                'match_percentage' => 95,
                'message' => 'Mau buat aplikasi mobile untuk portfolio beasiswa. Butuh partner Flutter.',
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],
            [
                'sender_id' => $budiId,
                'receiver_id' => $cicaId,
                'match_percentage' => 98,
                'message' => 'Cari partner untuk lomba UX & bangun MVP. Bisa ajarin design framework.',
                'status' => 'pending',
                'created_at' => now(),
                'updated_at' => now(),
            ],
        ]);
    }
}
