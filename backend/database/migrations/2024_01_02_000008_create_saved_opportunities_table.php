<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Peluang yang disimpan/di-bookmark user (ikon bookmark di pojok kanan
     * atas tiap kartu, dan angka "Peluang Disimpan" di dashboard).
     */
    public function up(): void
    {
        Schema::create('saved_opportunities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete();
            $table->foreignId('opportunity_id')->constrained()->cascadeOnDelete();
            $table->timestamps();

            $table->unique(['user_id', 'opportunity_id']); // tidak bisa simpan 2x item yang sama
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('saved_opportunities');
    }
};
