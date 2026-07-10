<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Feed "Aktivitas Terkini" di dashboard, contoh:
     * "Amanda Putri mengirim partner request padamu",
     * "Skill 'Flutter' berhasil ditambahkan ke profilmu", dll.
     */
    public function up(): void
    {
        Schema::create('activities', function (Blueprint $table) {
            $table->id();
            $table->foreignId('user_id')->constrained()->cascadeOnDelete(); // pemilik feed
            $table->string('type'); // partner_request, skill_added, bookmark, opportunity_added, dll
            $table->text('description'); // teks yang tampil ke user
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('activities');
    }
};
