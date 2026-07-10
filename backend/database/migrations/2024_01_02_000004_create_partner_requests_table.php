<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Permintaan tukar skill antar mahasiswa (tombol "Kirim Request"),
     * termasuk persentase kecocokan (match %) yang tampil di kartu partner.
     */
    public function up(): void
    {
        Schema::create('partner_requests', function (Blueprint $table) {
            $table->id();
            $table->foreignId('sender_id')->constrained('users')->cascadeOnDelete();
            $table->foreignId('receiver_id')->constrained('users')->cascadeOnDelete();
            $table->unsignedTinyInteger('match_percentage')->nullable(); // contoh: 95, 98
            $table->text('message')->nullable(); // pesan singkat, contoh: "Mau buat aplikasi..."
            $table->enum('status', ['pending', 'accepted', 'rejected', 'completed'])->default('pending');
            $table->timestamps();
        });
    }

    public function down(): void
    {
        Schema::dropIfExists('partner_requests');
    }
};
