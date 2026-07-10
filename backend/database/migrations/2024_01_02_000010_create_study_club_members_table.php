<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Anggota tiap study club.
     */
    public function up(): void
    {
        Schema::create('study_club_members', function (Blueprint $table) {
            $table->id();
            $table->foreignId('study_club_id')->constrained()->cascadeOnDelete();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->timestamp('joined_at')->useCurrent();
            $table->timestamps();

            $table->unique(['study_club_id', 'user_id']);
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('study_club_members');
    }
};
