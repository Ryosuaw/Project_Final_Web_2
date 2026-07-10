<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Tag/label kecil pada tiap kartu peluang, contoh: "S1/D4", "Prestasi",
     * "Tim", "Design", "Flutter", "Online".
     */
    public function up(): void
    {
        Schema::create('opportunity_tags', function (Blueprint $table) {
            $table->id();
            $table->foreignId('opportunity_id')->constrained()->cascadeOnDelete();
            $table->string('tag');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('opportunity_tags');
    }
};
