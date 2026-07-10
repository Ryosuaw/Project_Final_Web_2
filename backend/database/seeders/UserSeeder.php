<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    public function run(): void
    {
        $users = [
            [
                'name' => 'Kakak Cica',
                'email' => 'cica@example.com',
                'university' => 'UGM',
                'major' => 'Teknik Informatika',
                'is_verified' => true,
                'profile_completion' => 72,
            ],
            [
                'name' => 'Amanda Putri',
                'email' => 'amanda@example.com',
                'university' => 'Institut Teknologi Bandung',
                'major' => 'Teknik Informatika',
                'is_verified' => true,
                'profile_completion' => 90,
            ],
            [
                'name' => 'Budi Santoso',
                'email' => 'budi@example.com',
                'university' => 'Universitas Indonesia',
                'major' => 'Sistem Informasi',
                'is_verified' => true,
                'profile_completion' => 95,
            ],
        ];

        foreach ($users as $user) {
            DB::table('users')->insertOrIgnore([
                ...$user,
                'password' => Hash::make('password'), // password default untuk data contoh
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
