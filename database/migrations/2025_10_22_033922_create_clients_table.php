<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration {
    public function up(): void
    {
        Schema::create('clients', function (Blueprint $table) {
            $table->uuid('id')->primary();
            $table->string('titulaire');
            $table->string('nci')->unique();
            $table->string('email')->unique();
            $table->string('telephone')->nullable();
            $table->text('adresse')->nullable();
            $table->timestamps();

            // Index si nécessaire
            $table->index('nci');
            $table->index('email');
            $table->index('titulaire');           // recherche rapide par nom

        });
    }

    public function down(): void
    {
        Schema::dropIfExists('clients');
    }
};
