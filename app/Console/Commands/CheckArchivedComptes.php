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

        // Dispatcher les jobs de vérification des dates de blocage
        \App\Jobs\CheckAndArchiveExpiredBlocageJob::dispatch();
        \App\Jobs\CheckAndRestoreExpiredBlocageJob::dispatch();

        $this->info('Jobs de vérification des dates de blocage dispatchés.');
    }
}
