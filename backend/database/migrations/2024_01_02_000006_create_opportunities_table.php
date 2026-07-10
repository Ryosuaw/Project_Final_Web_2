<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Menyatukan data Peluang Beasiswa, Info Kompetisi, dan Seminar & Webinar
     * dalam satu tabel, dibedakan lewat kolom `type`, karena strukturnya mirip.
     */
    public function up(): void
    {
        Schema::create('opportunities', function (Blueprint $table) {
            $table->id();
            $table->enum('type', ['beasiswa', 'kompetisi', 'seminar', 'webinar']);
            $table->string('title');                 // "Djarum Beasiswa Plus 2025/2026"
            $table->string('organizer');              // "Djarum Foundation", "HMTI UI", dll
            $table->text('description')->nullable();
            $table->date('deadline')->nullable();
            $table->string('benefit')->nullable();    // "Rp 1.5M/Bulan", "E-Sertifikat", dll
            $table->boolean('is_online')->nullable(); // relevan untuk seminar/webinar
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('opportunities');
    }
};
