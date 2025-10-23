<?php

namespace App\Services;

use App\Models\Client;
use App\Models\Compte;
use Illuminate\Contracts\Pagination\LengthAwarePaginator;
use Illuminate\Database\Eloquent\Collection;

class CompteService
{
    /**
     * Get comptes for a specific client with optional filters
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    public function getComptesByClient(Client $client, array $filters = []): LengthAwarePaginator
    {
        $query = Compte::with('client')->where('client_id', $client->id);

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
        $query = Compte::with('client')->client($telephone)->actifs();

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
        $query = Compte::with('client');

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
        $compte = Compte::with('client')->find($id);

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
        return Compte::with('client')
                    ->where('client_id', $client->id)
                    ->find($compteId);
    }

    /**
     * Create a new compte
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
}