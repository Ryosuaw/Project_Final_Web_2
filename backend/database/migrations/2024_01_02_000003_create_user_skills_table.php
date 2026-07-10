<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Skill yang dimiliki tiap user, dibedakan apakah "bisa mengajari"
     * atau "ingin belajar" (sesuai bagian BISA MENGAJARI / INGIN BELAJAR di desain).
     */
    public function up(): void
    {
        Schema::create('user_skills', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('skill_id')->constrained()->cascadeOnDelete();
            $table->enum('type', ['teach', 'learn']); // teach = bisa mengajari, learn = ingin belajar
            $table->enum('level', ['pemula', 'menengah', 'mahir'])->nullable();
            $table->timestamps();

            $table->unique(['user_id', 'skill_id', 'type']); // 1 skill tidak dobel untuk tipe yang sama
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('user_skills');
    }
};
