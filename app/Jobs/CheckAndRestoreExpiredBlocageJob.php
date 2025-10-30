<?php

namespace App\Jobs;

use App\Models\Compte;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class CheckAndRestoreExpiredBlocageJob implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    /**
     * Create a new job instance.
     */
    public function __construct()
    {
        //
    }

    /**
     * Execute the job.
     */
    public function handle(): void
    {
        Log::info('Début de vérification des comptes avec dateFinBlocage échue');

        // Récupérer les comptes épargne bloqués dont la dateFinBlocage est échue
        $comptesToRestore = Compte::where('statut', 'bloque')
            ->where('type', 'epargne')
            ->whereNotNull('dateFinBlocage')
            ->where('dateFinBlocage', '<=', now())
            ->where('archived', true)
            ->get();

        Log::info("Trouvé {$comptesToRestore->count()} comptes à restaurer");

        foreach ($comptesToRestore as $compte) {
            Log::info("Restauration du compte: {$compte->numero}");

            // Dispatcher le job de restauration existant
            RestoreCompteJob::dispatch($compte->id);
        }

        Log::info('Fin de vérification des comptes avec dateFinBlocage échue');
    }
}
