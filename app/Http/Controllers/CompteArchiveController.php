<?php

namespace App\Http\Controllers;

use App\Http\Resources\CompteResource;
use App\Models\Compte;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;

/**
 * @OA\Tag(
 *     name="Comptes Archivés",
 *     description="Gestion des comptes archivés"
 * )
 */

class CompteArchiveController extends Controller
{
    use ApiResponse;

    /**
     * @OA\Get(
     *     path="/comptes/archives",
     *     tags={"Comptes Archivés"},
     *     summary="Lister tous les comptes archivés",
     *     description="La consultation de compte Epargne archiver se fait a partir du cloud",
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="page",
     *         in="query",
     *         description="Numéro de page",
     *         required=false,
     *         @OA\Schema(type="integer", default=1)
     *     ),
     *     @OA\Parameter(
     *         name="limit",
     *         in="query",
     *         description="Nombre d'éléments par page",
     *         required=false,
     *         @OA\Schema(type="integer", default=10, maximum=100)
     *     ),
     *     @OA\Parameter(
     *         name="type",
     *         in="query",
     *         description="Type de compte (epargne, cheque, courant)",
     *         required=false,
     *         @OA\Schema(type="string", enum={"epargne", "cheque", "courant"})
     *     ),
     *     @OA\Parameter(
     *         name="statut",
     *         in="query",
     *         description="Statut du compte (actif, bloque, ferme)",
     *         required=false,
     *         @OA\Schema(type="string", enum={"actif", "bloque", "ferme"})
     *     ),
     *     @OA\Parameter(
     *         name="search",
     *         in="query",
     *         description="Recherche par numéro de compte ou titulaire",
     *         required=false,
     *         @OA\Schema(type="string")
     *     ),
     *     @OA\Parameter(
     *         name="sort",
     *         in="query",
     *         description="Champ de tri",
     *         required=false,
     *         @OA\Schema(type="string", enum={"dateCreation", "solde", "titulaire"})
     *     ),
     *     @OA\Parameter(
     *         name="order",
     *         in="query",
     *         description="Ordre de tri",
     *         required=false,
     *         @OA\Schema(type="string", enum={"asc", "desc"}, default="desc")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Liste des comptes archivés récupérée avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Liste des comptes archivés récupérée avec succès"),
     *             @OA\Property(property="data", type="array", @OA\Items(ref="#/components/schemas/Compte")),
     *             @OA\Property(property="pagination", type="object",
     *                 @OA\Property(property="currentPage", type="integer", example=1),
     *                 @OA\Property(property="totalPages", type="integer", example=3),
     *                 @OA\Property(property="totalItems", type="integer", example=25),
     *                 @OA\Property(property="itemsPerPage", type="integer", example=10),
     *                 @OA\Property(property="hasNext", type="boolean", example=true),
     *                 @OA\Property(property="hasPrevious", type="boolean", example=false)
     *             ),
     *             @OA\Property(property="links", type="object",
     *                 @OA\Property(property="self", type="string", example="http://localhost:8001/api/v1/comptes/archives?page=1"),
     *                 @OA\Property(property="next", type="string", example="http://localhost:8001/api/v1/comptes/archives?page=2"),
     *                 @OA\Property(property="first", type="string", example="http://localhost:8001/api/v1/comptes/archives?page=1"),
     *                 @OA\Property(property="last", type="string", example="http://localhost:8001/api/v1/comptes/archives?page=3")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Non autorisé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Non autorisé")
     *         )
     *     )
     * )
     */
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
