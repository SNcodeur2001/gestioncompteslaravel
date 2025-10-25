<?php

namespace App\Jobs;

use App\Models\Compte;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class CheckAndArchiveExpiredBlocageJob implements ShouldQueue
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
        Log::info('Début de vérification des comptes avec dateDebutBlocage échue');

        // Récupérer les comptes bloqués dont la dateDebutBlocage est échue
        $comptesToArchive = Compte::where('statut', 'bloque')
            ->whereNotNull('dateDebutBlocage')
            ->where('dateDebutBlocage', '<=', now())
            ->where('archived', false)
            ->get();

        Log::info("Trouvé {$comptesToArchive->count()} comptes à archiver");

        foreach ($comptesToArchive as $compte) {
            Log::info("Archivage du compte: {$compte->numero}");

            // Dispatcher le job d'archivage existant
            ArchiveCompteJob::dispatch($compte->id);
        }

        Log::info('Fin de vérification des comptes avec dateDebutBlocage échue');
    }
}
