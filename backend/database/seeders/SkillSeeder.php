<?php

namespace Database\Seeders;

use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\DB;

class SkillSeeder extends Seeder
{
    public function run(): void
    {
        $skills = [
            ['name' => 'Flutter', 'category' => 'Programming'],
            ['name' => 'Dart', 'category' => 'Programming'],
            ['name' => 'Firebase', 'category' => 'Programming'],
            ['name' => 'Figma Basics', 'category' => 'Design'],
            ['name' => 'Python', 'category' => 'Programming'],
            ['name' => 'Data Analysis', 'category' => 'Data'],
            ['name' => 'Laravel Backend', 'category' => 'Programming'],
            ['name' => 'REST API', 'category' => 'Programming'],
            ['name' => 'UI/UX Design', 'category' => 'Design'],
            ['name' => 'React Native', 'category' => 'Programming'],
        ];

        foreach ($skills as $skill) {
            DB::table('skills')->insertOrIgnore([
                ...$skill,
                'created_at' => now(),
                'updated_at' => now(),
            ]);
        }
    }
}
