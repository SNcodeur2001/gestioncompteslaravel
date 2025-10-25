<?php

namespace App\Services;

use App\Models\Compte;
use App\Models\Transaction;
use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\Log;

class NeonTransferService
{
    /**
     * Transférer un compte et ses transactions vers Neon
     */
    public function transferToNeon(Compte $compte): bool
    {
        $maxRetries = 3;
        $attempt = 0;

        while ($attempt < $maxRetries) {
            try {
                $attempt++;
                Log::info("Tentative {$attempt} de transfert du compte {$compte->numero} vers Neon");

                // Vérifier les tables Neon
                if (!$this->checkNeonTablesExist()) {
                    throw new \Exception("Tables Neon manquantes");
                }

                DB::beginTransaction();

                // 1. Transférer le client si nécessaire
                $clientData = $this->convertForPostgres([
                    'id' => $compte->client->id,
                    'titulaire' => $compte->client->titulaire,
                    'nci' => $compte->client->nci,
                    'email' => $compte->client->email,
                    'telephone' => $compte->client->telephone,
                    'adresse' => $compte->client->adresse,
                    'created_at' => $compte->client->created_at,
                    'updated_at' => $compte->client->updated_at,
                ]);

                if (!$this->validateData($clientData, 'clients')) {
                    throw new \Exception("Données client invalides");
                }

                DB::connection('neon')->table('clients')->upsert(
                    $clientData,
                    ['id'],
                    ['titulaire', 'nci', 'email', 'telephone', 'adresse', 'updated_at']
                );
                Log::info("Client {$compte->client->titulaire} transféré/actualisé dans Neon");

                // 2. Transférer le compte vers Neon (transaction séparée)
                $compteData = $this->convertForPostgres([
                    'id' => $compte->id,
                    'client_id' => $compte->client_id,
                    'numero' => $compte->numero,
                    'type' => $compte->type,
                    'soldeinitial' => $compte->soldeInitial,
                    'solde' => $compte->solde,
                    'devise' => $compte->devise,
                    'statut' => $compte->statut,
                    'motifblocage' => $compte->motifBlocage,
                    'archived' => true,
                    'created_at' => $compte->created_at,
                    'updated_at' => now(),
                ]);

                if (!$this->validateData($compteData, 'comptes')) {
                    throw new \Exception("Données compte invalides");
                }

                DB::connection('neon')->transaction(function () use ($compteData) {
                    DB::connection('neon')->table('comptes')->upsert(
                        $compteData,
                        ['id'],
                        ['numero', 'type', 'soldeinitial', 'solde', 'devise', 'statut', 'motifblocage', 'archived', 'updated_at']
                    );
                });
                Log::info("Compte {$compte->numero} transféré dans Neon");

                // 3. Transférer les transactions vers Neon en batch (seulement celles sans référence externe)
                $transactions = $compte->transactions;
                if ($transactions->isNotEmpty()) {
                    $transactionData = [];
                    foreach ($transactions as $transaction) {
                        // Pour l'archivage, on ne transfère que les transactions qui n'ont pas de compte destination
                        // ou dont le compte destination n'existe pas (pour éviter les contraintes FK)
                        if ($transaction->compte_destination_id) {
                            // Vérifier si le compte destination existe dans Neon
                            $destExists = DB::connection('neon')
                                ->table('comptes')
                                ->where('id', $transaction->compte_destination_id)
                                ->exists();

                            if (!$destExists) {
                                Log::warning("Transaction {$transaction->id} ignorée : compte destination {$transaction->compte_destination_id} non trouvé dans Neon");
                                continue;
                            }
                        }

                        $data = $this->convertForPostgres([
                            'id' => $transaction->id,
                            'compte_id' => $transaction->compte_id,
                            'type' => $transaction->type,
                            'montant' => $transaction->montant,
                            'solde_avant' => $transaction->solde_avant,
                            'solde_apres' => $transaction->solde_apres,
                            'devise' => $transaction->devise,
                            'description' => $transaction->description,
                            'compte_destination_id' => $transaction->compte_destination_id ?: null,
                            'created_at' => $transaction->created_at,
                            'updated_at' => $transaction->updated_at,
                        ]);

                        if (!$this->validateData($data, 'transactions')) {
                            throw new \Exception("Données transaction invalides pour ID {$transaction->id}");
                        }

                        $transactionData[] = $data;
                    }

                    if (!empty($transactionData)) {
                        // Batch insert avec transaction séparée
                        DB::connection('neon')->transaction(function () use ($transactionData) {
                            foreach (array_chunk($transactionData, 50) as $chunk) {
                                DB::connection('neon')->table('transactions')->upsert(
                                    $chunk,
                                    ['id'],
                                    ['compte_id', 'type', 'montant', 'solde_avant', 'solde_apres', 'devise', 'description', 'compte_destination_id', 'updated_at']
                                );
                            }
                        });
                        Log::info("{$transactions->count()} transactions vérifiées, " . count($transactionData) . " transférées en batch vers Neon");
                    } else {
                        Log::warning("Aucune transaction valide à transférer pour le compte {$compte->numero}");
                    }
                }

                // 4. Supprimer le compte et ses transactions de la base Render (soft delete)
                $compte->delete(); // Soft delete du compte
                $compte->transactions()->delete(); // Soft delete des transactions
                Log::info("Compte {$compte->numero} et ses transactions supprimés de Render (soft delete)");

                DB::commit();
                Log::info("Archivage réussi du compte {$compte->numero} vers Neon");
                return true;

            } catch (\Exception $e) {
                DB::rollBack();
                Log::error("Erreur transfert Neon (tentative {$attempt}): " . $e->getMessage());

                if ($attempt >= $maxRetries) {
                    Log::error("Échec définitif du transfert après {$maxRetries} tentatives");
                    return false;
                }

                // Attendre avant retry
                sleep(1 * $attempt);
            }
        }

        return false;
    }

    /**
     * Restaurer un compte depuis Neon vers local
     */
    public function restoreFromNeon(string $compteId): ?Compte
    {
        try {
            Log::info("Début de restauration du compte {$compteId} depuis Neon");

            // 1. Récupérer le compte depuis Neon
            $neonCompte = DB::connection('neon')
                ->table('comptes')
                ->where('id', $compteId)
                ->first();

            if (!$neonCompte) {
                Log::warning("Compte {$compteId} non trouvé dans Neon");
                return null;
            }

            // 2. Vérifier que le client existe dans Neon
            $neonClient = DB::connection('neon')
                ->table('clients')
                ->where('id', $neonCompte->client_id)
                ->first();

            if (!$neonClient) {
                Log::error("Client {$neonCompte->client_id} non trouvé dans Neon pour le compte {$compteId}");
                return null;
            }

            DB::beginTransaction();

            // 3. Restaurer ou créer le client en local
            $client = \App\Models\Client::find($neonClient->id);
            if (!$client) {
                $client = new \App\Models\Client();
                $client->id = $neonClient->id;
            }
            $client->fill((array) $neonClient);
            $client->save();
            Log::info("Client {$client->titulaire} restauré/actualisé en local");

            // 4. Restaurer le compte en local (il devrait déjà exister en soft delete)
            $compte = Compte::withTrashed()->find($compteId);
            if (!$compte) {
                Log::error("Compte {$compteId} non trouvé en local, création d'un nouveau compte");
                $compte = new Compte();
                $compte->id = $neonCompte->id;
            }

            $compte->fill((array) $neonCompte);
            $compte->archived = false;
            $compte->deleted_at = null; // Restaurer si soft deleted
            $compte->save();
            Log::info("Compte {$compte->numero} restauré en local");

            // 5. Restaurer les transactions en batch (restaurer les soft deleted)
            $neonTransactions = DB::connection('neon')
                ->table('transactions')
                ->where('compte_id', $compteId)
                ->get();

            if ($neonTransactions->isNotEmpty()) {
                $transactionIds = $neonTransactions->pluck('id')->toArray();

                // Restaurer les transactions soft deleted existantes
                Transaction::withTrashed()
                    ->whereIn('id', $transactionIds)
                    ->restore();

                Log::info("{$neonTransactions->count()} transactions restaurées en local");
            }

            // 6. Supprimer de Neon après confirmation de succès
            DB::connection('neon')->table('comptes')->where('id', $compteId)->delete();
            DB::connection('neon')->table('transactions')->where('compte_id', $compteId)->delete();
            Log::info("Données supprimées de Neon après restauration réussie");

            DB::commit();
            Log::info("Restauration réussie du compte {$compte->numero} depuis Neon");
            return $compte;

        } catch (\Exception $e) {
            DB::rollBack();
            Log::error("Erreur restauration Neon pour compte {$compteId}: " . $e->getMessage());
            return null;
        }
    }

    /**
     * Rechercher un compte dans Neon
     */
    public function findInNeon(string $compteId): ?array
    {
        try {
            Log::info("Recherche du compte {$compteId} dans Neon");

            $compte = DB::connection('neon')
                ->table('comptes')
                ->where('id', $compteId)
                ->first();

            if (!$compte) {
                Log::info("Compte {$compteId} non trouvé dans Neon");
                return null;
            }

            // Vérifier que le client existe
            $client = DB::connection('neon')
                ->table('clients')
                ->where('id', $compte->client_id)
                ->first();

            if (!$client) {
                Log::warning("Client {$compte->client_id} non trouvé dans Neon pour le compte {$compteId}");
                return null;
            }

            // Récupérer les transactions du compte
            $transactions = DB::connection('neon')
                ->table('transactions')
                ->where('compte_id', $compteId)
                ->orderBy('created_at', 'desc')
                ->get();

            Log::info("Compte {$compteId} trouvé dans Neon avec {$transactions->count()} transactions");

            return [
                'compte' => $compte,
                'client' => $client,
                'transactions' => $transactions,
            ];

        } catch (\Exception $e) {
            Log::error("Erreur recherche Neon pour compte {$compteId}: " . $e->getMessage());
            return null;
        }
    }

    /**
     * Vérifier l'existence des tables Neon
     */
    public function checkNeonTablesExist(): bool
    {
        try {
            $tables = ['comptes', 'transactions', 'clients'];
            foreach ($tables as $table) {
                $exists = DB::connection('neon')->select("SELECT EXISTS (
                    SELECT FROM information_schema.tables
                    WHERE table_schema = 'public'
                    AND table_name = ?
                )", [$table]);

                if (!$exists[0]->exists) {
                    Log::error("Table Neon '{$table}' n'existe pas");
                    return false;
                }
            }
            Log::info("Toutes les tables Neon existent");
            return true;
        } catch (\Exception $e) {
            Log::error("Erreur vérification tables Neon: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Valider les données avant insert
     */
    private function validateData(array $data, string $table): bool
    {
        try {
            // Vérifications de base selon la table
            switch ($table) {
                case 'comptes':
                    if (empty($data['id']) || empty($data['client_id']) || empty($data['numero'])) {
                        Log::error("Données comptes invalides: champs requis manquants");
                        return false;
                    }
                    break;
                case 'transactions':
                    if (empty($data['id']) || empty($data['compte_id']) || empty($data['type']) || !isset($data['montant'])) {
                        Log::error("Données transactions invalides: champs requis manquants");
                        return false;
                    }
                    break;
                case 'clients':
                    if (empty($data['id']) || empty($data['titulaire']) || empty($data['nci'])) {
                        Log::error("Données clients invalides: champs requis manquants");
                        return false;
                    }
                    break;
            }
            return true;
        } catch (\Exception $e) {
            Log::error("Erreur validation données: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Convertir les données pour PostgreSQL
     */
    public function convertForPostgres(array $data): array
    {
        $converted = [];
        foreach ($data as $key => $value) {
            if ($key === 'id' || str_ends_with($key, '_id')) {
                // UUID reste string, NULL reste NULL
                $converted[$key] = $value;
            } elseif (in_array($key, ['created_at', 'updated_at', 'deleted_at'])) {
                // Timestamps en format PostgreSQL
                $converted[$key] = $value ? $value->format('Y-m-d H:i:s') : null;
            } else {
                $converted[$key] = $value;
            }
        }
        return $converted;
    }

    /**
     * Vérifier la connexion Neon
     */
    public function testConnection(): bool
    {
        try {
            DB::connection('neon')->getPdo();
            return true;
        } catch (\Exception $e) {
            Log::error("Erreur connexion Neon: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Migrer les schémas vers Neon
     */
    public function migrateSchemas(): bool
    {
        try {
            Log::info("Début de migration des schémas vers Neon");

            // Vérifier la connexion Neon
            if (!$this->testConnection()) {
                throw new \Exception("Connexion Neon indisponible");
            }

            // Exécuter les migrations sur Neon
            // Note: Nécessite une commande artisan dédiée
            $command = 'php artisan migrate --database=neon --force';
            $result = shell_exec($command);

            if ($result === null) {
                throw new \Exception("Échec exécution commande migration");
            }

            Log::info("Migrations Neon exécutées avec succès");
            return true;

        } catch (\Exception $e) {
            Log::error("Erreur migration Neon: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Créer les tables Neon manuellement si nécessaire (fallback)
     */
    public function createNeonTablesManually(): bool
    {
        try {
            Log::info("Création manuelle des tables Neon");

            if (!$this->testConnection()) {
                throw new \Exception("Connexion Neon indisponible");
            }

            // Créer chaque table séparément pour éviter les problèmes de transaction
            // Créer table clients
            DB::connection('neon')->statement("
                CREATE TABLE IF NOT EXISTS clients (
                    id UUID PRIMARY KEY,
                    titulaire VARCHAR(255) NOT NULL,
                    nci VARCHAR(255) UNIQUE NOT NULL,
                    email VARCHAR(255) UNIQUE,
                    telephone VARCHAR(255),
                    adresse TEXT,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            ");
            Log::info("Table clients créée");

            // Créer table comptes
            DB::connection('neon')->statement("
                CREATE TABLE IF NOT EXISTS comptes (
                    id UUID PRIMARY KEY,
                    client_id UUID NOT NULL,
                    numero VARCHAR(255) UNIQUE NOT NULL,
                    type VARCHAR(255) NOT NULL,
                    \"soldeInitial\" DECIMAL(15,2) NOT NULL,
                    solde DECIMAL(15,2) NOT NULL,
                    devise VARCHAR(10) DEFAULT 'FCFA',
                    statut VARCHAR(255) DEFAULT 'actif',
                    \"motifBlocage\" TEXT,
                    archived BOOLEAN DEFAULT FALSE,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            ");
            Log::info("Table comptes créée");

            // Créer table transactions
            DB::connection('neon')->statement("
                CREATE TABLE IF NOT EXISTS transactions (
                    id UUID PRIMARY KEY,
                    compte_id UUID NOT NULL,
                    type VARCHAR(255) NOT NULL,
                    montant DECIMAL(15,2) NOT NULL,
                    solde_avant DECIMAL(15,2) NOT NULL,
                    solde_apres DECIMAL(15,2) NOT NULL,
                    devise VARCHAR(10) NOT NULL,
                    description TEXT,
                    compte_destination_id UUID,
                    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
                )
            ");
            Log::info("Table transactions créée");

            // Créer index
            DB::connection('neon')->statement("CREATE INDEX IF NOT EXISTS idx_comptes_numero ON comptes(numero)");
            DB::connection('neon')->statement("CREATE INDEX IF NOT EXISTS idx_clients_nci ON clients(nci)");
            DB::connection('neon')->statement("CREATE INDEX IF NOT EXISTS idx_clients_email ON clients(email)");
            DB::connection('neon')->statement("CREATE INDEX IF NOT EXISTS idx_transactions_compte_created ON transactions(compte_id, created_at)");
            DB::connection('neon')->statement("CREATE INDEX IF NOT EXISTS idx_transactions_type ON transactions(type)");
            Log::info("Index créés");

            Log::info("Tables Neon créées manuellement avec succès");
            return true;

        } catch (\Exception $e) {
            Log::error("Erreur création tables Neon: " . $e->getMessage());
            return false;
        }
    }
}