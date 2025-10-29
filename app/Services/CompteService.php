<?php

namespace App\Services;

use App\Models\Client;
use App\Models\Compte;
use App\Services\ClientService;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;
use Illuminate\Support\Facades\Log;

class CompteService
{
    protected ClientService $clientService;

    public function __construct(ClientService $clientService)
    {
        $this->clientService = $clientService;
    }
    /**
     * Get comptes for a specific client with optional filters
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    public function getComptesByClient(Client $client, array $filters = []): LengthAwarePaginator
    {
        $query = Compte::where('client_id', $client->id);

        // Apply filters
        $this->applyFilters($query, $filters);

        // Apply sorting
        $this->applySorting($query, $filters);

        // Apply pagination
        $limit = min($filters['limit'] ?? 10, 100);
        $page = $filters['page'] ?? 1;

        return $query->paginate($limit, ['*'], 'page', $page);
    }

    /**
     * Get comptes for a specific client by telephone
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    public function getComptesByTelephone(string $telephone, array $filters = []): LengthAwarePaginator
    {
        $query = Compte::client($telephone)->actifs();

        // Apply filters
        $this->applyFilters($query, $filters);

        // Apply sorting
        $this->applySorting($query, $filters);

        // Apply pagination
        $limit = min($filters['limit'] ?? 10, 100);
        $page = $filters['page'] ?? 1;

        return $query->paginate($limit, ['*'], 'page', $page);
    }

    /**
     * Get all comptes with optional filters
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    public function getAllComptes(array $filters = []): LengthAwarePaginator
    {
        $query = Compte::query();

        // Apply filters
        $this->applyFilters($query, $filters);

        // Apply sorting
        $this->applySorting($query, $filters);

        // Apply pagination
        $limit = min($filters['limit'] ?? 10, 100);
        $page = $filters['page'] ?? 1;

        return $query->paginate($limit, ['*'], 'page', $page);
    }

    /**
     * Find a compte by ID (recherche étendue local + Neon)
     */
    public function findCompte(string $id): ?Compte
    {
        // 1. Chercher d'abord en local
        $compte = Compte::find($id);

        if ($compte) {
            return $compte;
        }

        // 2. Si pas trouvé, chercher dans Neon
        $neonService = app(\App\Services\NeonTransferService::class);
        $neonData = $neonService->findInNeon($id);

        if ($neonData) {
            return $this->formatNeonData($neonData);
        }

        return null;
    }

    /**
     * Formater les données récupérées depuis Neon
     */
    private function formatNeonData(array $data): Compte
    {
        // Créer un objet Compte temporaire avec les données Neon
        $compte = new Compte();
        $compte->fill((array) $data['compte']);
        $compte->client = new \App\Models\Client((array) $data['client']);

        // Marquer comme provenant de Neon
        $compte->from_neon = true;

        return $compte;
    }

    /**
     * Find a compte by ID for a specific client
     */
    public function findCompteByClient(Client $client, string $compteId): ?Compte
    {
        return Compte::where('client_id', $client->id)
                    ->find($compteId);
    }

    /**
     * Create a new compte with client handling
     */
    public function createCompteWithClient(array $data): Compte
    {
        // Handle client creation or retrieval
        $client = null;
        $generatedPassword = null;
        $generatedCode = null;

        if (isset($data['client']['id'])) {
            // Use existing client
            $client = $this->clientService->findClient($data['client']['id']);
        } else {
            // Create new client with user account
            $result = $this->clientService->createClientWithUser($data['client']);
            $client = $result['client'];
            $generatedPassword = $result['generatedPassword'];
            $generatedCode = $result['generatedCode'];
        }

        // Create the account
        $compteData = [
            'numero' => $data['numero'] ?? null, // This will trigger the setNumeroAttribute mutator
            'type' => $data['type'],
            'soldeInitial' => $data['soldeInitial'],
            'solde' => $data['solde'],
            'devise' => $data['devise'],
            'client_id' => $client->id,
            'statut' => $data['statut'] ?? 'actif',
        ];

        $compte = Compte::create($compteData);

        // Dispatch event for notifications (only for new clients)
        if ($generatedPassword && $generatedCode) {
            \App\Events\CompteCreated::dispatch($compte, $generatedPassword, $generatedCode);
        }

        return $compte;
    }

    /**
     * Update compte client information
     */
    public function updateCompteClient(string $compteId, array $data): ?Compte
    {
        // Find the compte
        $compte = $this->findCompte($compteId);

        if (!$compte) {
            return null;
        }

        // Load client relationship for updates
        $compte->load('client');

        // Update client information if provided
        if (isset($data['informationsClient'])) {
            $clientData = [];
            $clientUpdates = $data['informationsClient'];

            if (isset($clientUpdates['telephone'])) {
                $clientData['telephone'] = $clientUpdates['telephone'];
            }
            if (isset($clientUpdates['email'])) {
                $clientData['email'] = $clientUpdates['email'];
            }
            if (isset($clientUpdates['nci'])) {
                $clientData['nci'] = $clientUpdates['nci'];
            }
            if (isset($clientUpdates['password'])) {
                $clientData['password'] = bcrypt($clientUpdates['password']);
            }

            if (!empty($clientData)) {
                $compte->client->update($clientData);
            }
        }

        // Update titulaire if provided
        if (isset($data['titulaire'])) {
            $compte->client->update(['titulaire' => $data['titulaire']]);
        }

        // Reload the compte with updated client data
        return $compte->fresh(['client']);
    }

    /**
     * Create a new compte (legacy method for backward compatibility)
     */
    public function createCompte(array $data): Compte
    {
        return Compte::create($data);
    }

    /**
     * Apply filters to the query
     */
    private function applyFilters($query, array $filters): void
    {
        // Type filter
        if (!empty($filters['type']) && in_array($filters['type'], ['epargne', 'cheque', 'courant'])) {
            $query->where('type', $filters['type']);
        }

        // Status filter
        if (!empty($filters['statut']) && in_array($filters['statut'], ['actif', 'bloque', 'ferme'])) {
            $query->where('statut', $filters['statut']);
        }

        // Search filter
        if (!empty($filters['search'])) {
            $search = $filters['search'];
            $query->where(function ($q) use ($search) {
                $q->where('numero', 'like', "%{$search}%")
                  ->orWhereHas('client', function ($clientQuery) use ($search) {
                      $clientQuery->where('titulaire', 'like', "%{$search}%");
                  });
            });
        }
    }

    /**
     * Apply sorting to the query
     */
    private function applySorting($query, array $filters): void
    {
        $sortBy = $filters['sort'] ?? 'created_at';
        $order = $filters['order'] ?? 'desc';

        if (in_array($sortBy, ['dateCreation', 'solde', 'titulaire'])) {
            if ($sortBy === 'dateCreation') {
                $query->orderBy('created_at', $order);
            } elseif ($sortBy === 'solde') {
                $query->orderBy('solde', $order);
            } elseif ($sortBy === 'titulaire') {
                $query->join('clients', 'comptes.client_id', '=', 'clients.id')
                       ->orderBy('clients.titulaire', $order)
                       ->select('comptes.*');
            }
        } else {
            $query->orderBy('created_at', 'desc');
        }
    }

    /**
     * Soft delete a compte (fermer le compte)
     */
    public function deleteCompte(string $compteId): ?Compte
    {
        try {
            // Find the compte (without global scope to allow finding soft-deleted comptes)
            $compte = Compte::withoutGlobalScope('nonSupprimes')->find($compteId);

            if (!$compte) {
                return null;
            }

            // Update statut to 'ferme' and set dateFermeture
            $compte->update([
                'statut' => 'ferme',
                'dateFermeture' => now(),
            ]);

            // Soft delete the compte
            $compte->delete();

            return $compte->fresh();
        } catch (\Exception $e) {
            Log::error('Error in CompteService::deleteCompte: ' . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Get archived comptes with optional filters
     */
    public function getArchivedComptes(array $filters = []): LengthAwarePaginator
    {
        $query = Compte::withoutGlobalScope('nonSupprimes')
            ->where('archived', true)
            ->whereNull('deleted_at');

        // Apply filters
        $this->applyFilters($query, $filters);

        // Apply sorting
        $this->applySorting($query, $filters);

        // Apply pagination
        $limit = min($filters['limit'] ?? 10, 100);
        $page = $filters['page'] ?? 1;

        return $query->paginate($limit, ['*'], 'page', $page);
    }

    /**
     * Bloquer un compte (préparation à l'archivage)
     */
    public function bloquerCompte(string $compteId, array $data): ?Compte
    {
        try {
            // Find the compte
            $compte = Compte::find($compteId);

            if (!$compte) {
                return null;
            }

            // Vérifier que le compte n'est pas déjà bloqué
            if ($compte->statut === 'bloque') {
                throw new \Exception('Le compte est déjà bloqué.');
            }

            // Bloquer le compte
            $compte->update([
                'statut' => 'bloque',
                'motifBlocage' => $data['motifBlocage'],
                'dateDebutBlocage' => $data['dateDebutBlocage'],
                'dateFinBlocage' => $data['dateFinBlocage'],
            ]);

            return $compte->fresh();
        } catch (\Exception $e) {
            Log::error('Error in CompteService::bloquerCompte: ' . $e->getMessage());
            throw $e;
        }
    }

    /**
     * Débloquer un compte (restauration)
     */
    public function debloquerCompte(string $compteId): ?Compte
    {
        try {
            // Find the compte (including archived ones)
            $compte = Compte::withoutGlobalScope('nonSupprimes')
                ->find($compteId);

            if (!$compte) {
                return null;
            }

            // Vérifier que le compte est bloqué
            if ($compte->statut !== 'bloque') {
                throw new \Exception('Le compte n\'est pas bloqué.');
            }

            // Débloquer le compte
            $compte->update([
                'statut' => 'actif',
                'motifBlocage' => null,
                'dateDebutBlocage' => null,
                'dateFinBlocage' => null,
                'archived' => false, // En cas où il était archivé
            ]);

            return $compte->fresh();
        } catch (\Exception $e) {
            Log::error('Error in CompteService::debloquerCompte: ' . $e->getMessage());
            throw $e;
        }
    }
}