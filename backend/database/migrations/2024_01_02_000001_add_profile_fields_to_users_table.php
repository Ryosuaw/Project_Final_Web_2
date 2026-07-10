<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Menambahkan kolom profil mahasiswa ke tabel users bawaan Laravel.
     */
    public function up(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->string('university')->nullable()->after('email');       // Universitas Indonesia, dll
            $table->string('major')->nullable()->after('university');       // Teknik Informatika, dll
            $table->string('profile_photo')->nullable()->after('major');
            $table->text('bio')->nullable()->after('profile_photo');
            $table->boolean('is_verified')->default(false)->after('bio');   // badge centang biru
            $table->unsignedTinyInteger('profile_completion')->default(0)->after('is_verified'); // 0-100 (%)
        });
    }

    public function down(): void
    {
        Schema::table('users', function (Blueprint $table) {
            $table->dropColumn([
                'university',
                'major',
                'profile_photo',
                'bio',
                'is_verified',
                'profile_completion',
            ]);
        });
    }
};
