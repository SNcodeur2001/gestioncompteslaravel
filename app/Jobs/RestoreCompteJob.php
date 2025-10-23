<?php

namespace App\Jobs;

use App\Models\Compte;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class RestoreCompteJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected $compteId;

    /**
     * Create a new job instance.
     */
    public function __construct($compteId)
    {
        $this->compteId = $compteId;
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        // Utiliser le service de transfert Neon
        $neonService = app(\App\Services\NeonTransferService::class);

        $compte = $neonService->restoreFromNeon($this->compteId);

        if ($compte) {
            Log::info("Compte {$compte->numero} restauré depuis Neon avec succès");
        } else {
            Log::error("Échec restauration compte {$this->compteId} depuis Neon");
        }
    }
}
