<?php

namespace App\Http\Controllers;

use App\Http\Resources\CompteResource;
use App\Models\Compte;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;


class CompteArchiveController extends Controller
{
    use ApiResponse;

    public function index(Request $request): JsonResponse
    {
        // Récupérer les comptes archivés (sans le scope global)
        $query = Compte::with('client')
            ->withoutGlobalScope('nonSupprimes')
            ->where('archived', true)
            ->whereNull('deleted_at');

        // Appliquer les filtres
        $this->applyFilters($query, $request);

        // Appliquer le tri
        $this->applySorting($query, $request);

        // Pagination
        $limit = min($request->input('limit', 10), 100);
        $page = $request->input('page', 1);

        $comptes = $query->paginate($limit, ['*'], 'page', $page);

        return $this->paginatedResponse(
            $comptes,
            'Liste des comptes archivés récupérée avec succès'
        );
    }

    /**
     * Apply filters to the query
     */
    private function applyFilters($query, Request $request): void
    {
        // Type filter
        if ($request->has('type') && in_array($request->type, ['epargne', 'cheque', 'courant'])) {
            $query->where('type', $request->type);
        }

        // Status filter
        if ($request->has('statut') && in_array($request->statut, ['actif', 'bloque', 'ferme'])) {
            $query->where('statut', $request->statut);
        }

        // Search filter
        if ($request->has('search')) {
            $search = $request->search;
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
    private function applySorting($query, Request $request): void
    {
        $sortBy = $request->input('sort', 'created_at');
        $order = $request->input('order', 'desc');

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
