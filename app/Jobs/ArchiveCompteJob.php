<?php

namespace App\Jobs;

use App\Models\Compte;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class ArchiveCompteJob implements ShouldQueue
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
        $compte = Compte::find($this->compteId);

        if (!$compte) {
            Log::warning("Compte {$this->compteId} introuvable pour archivage");
            return;
        }

        // Vérifier que le compte est éligible à l'archivage
        if ($compte->statut !== 'bloque') {
            Log::info("Compte {$compte->numero} non bloqué, archivage ignoré");
            return;
        }

        // Utiliser le service de transfert Neon
        $neonService = app(\App\Services\NeonTransferService::class);

        if ($neonService->transferToNeon($compte)) {
            Log::info("Compte {$compte->numero} archivé vers Neon avec succès");
        } else {
            Log::error("Échec archivage compte {$compte->numero} vers Neon");
        }
    }
}
