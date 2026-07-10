<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class OpportunitySeeder extends Seeder
{
    public function run(): void
    {
        $opportunities = [
            [
                'type' => 'beasiswa',
                'title' => 'Djarum Beasiswa Plus 2025/2026',
                'organizer' => 'Djarum Foundation',
                'description' => 'Program beasiswa unggulan untuk mahasiswa berprestasi.',
                'deadline' => '2025-05-28',
                'benefit' => 'Rp 1.5M/Bulan',
                'is_online' => null,
                'tags' => ['S1/D4', 'Prestasi'],
            ],
            [
                'type' => 'kompetisi',
                'title' => 'National UX Design Challenge 2025',
                'organizer' => 'HMTI UI',
                'description' => 'Kompetisi desain UX tingkat nasional untuk mahasiswa.',
                'deadline' => '2025-04-10',
                'benefit' => 'Total Rp 15 Juta',
                'is_online' => null,
                'tags' => ['Tim', 'Design'],
            ],
            [
                'type' => 'seminar',
                'title' => 'Webinar: Flutter UI Slicing Pro',
                'organizer' => 'NOERA Study Club',
                'description' => 'Webinar belajar UI slicing menggunakan Flutter.',
                'deadline' => '2025-03-12',
                'benefit' => 'E-Sertifikat',
                'is_online' => true,
                'tags' => ['Flutter', 'Online'],
            ],
        ];

        foreach ($opportunities as $item) {
            $tags = $item['tags'];
            unset($item['tags']);

            $id = DB::table('opportunities')->insertGetId([
                ...$item,
                'created_at' => now(),
                'updated_at' => now(),
            ]);

            foreach ($tags as $tag) {
                DB::table('opportunity_tags')->insert([
                    'opportunity_id' => $id,
                    'tag' => $tag,
                    'created_at' => now(),
                    'updated_at' => now(),
                ]);
            }
        }
    }
}
