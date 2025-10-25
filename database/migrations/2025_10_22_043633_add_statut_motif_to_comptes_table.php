<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

return new class extends Migration
{
    /**
     * Run the migrations.
     */
    public function up(): void
    {
        // Columns already added in create_comptes_table migration
        // This migration is redundant and should be removed
    }

    /**
     * Reverse the migrations.
     */
    public function down(): void
    {
        // No action needed since columns were not added in this migration
    }
};
