<?php

namespace App\Console\Commands;

use App\Models\Compte;
use Illuminate\Console\Command;

class CheckArchivedComptes extends Command
{
    /**
     * The name and signature of the console command.
     *
     * @var string
     */
    protected $signature = 'comptes:check-archived';

    /**
     * The console command description.
     *
     * @var string
     */
    protected $description = 'Vérifier les comptes bloqués dont la période d\'archivage est écoulée et les rapatrier';

    /**
     * Execute the console command.
     */
    public function handle()
    {
        $this->info('Vérification des comptes archivés...');

        // Récupérer les comptes bloqués depuis plus de 30 jours (exemple)
        $comptesToRestore = Compte::where('statut', 'bloque')
            ->where('updated_at', '<', now()->subDays(30))
            ->get();

        foreach ($comptesToRestore as $compte) {
            $this->info("Restauration du compte: {$compte->numero}");

            // Dispatcher le job de restauration
            \App\Jobs\RestoreCompteJob::dispatch($compte->id);
        }

        $this->info('Vérification terminée. ' . $comptesToRestore->count() . ' comptes à restaurer.');
    }
}
