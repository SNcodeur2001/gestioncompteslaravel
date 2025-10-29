<?php

namespace App\Http\Controllers;

use App\Constants\Messages;
use App\Exceptions\CompteNotFoundException;
use App\Http\Requests\StoreCompteRequest;
use App\Http\Requests\UpdateCompteRequest;
use App\Http\Resources\CompteResource;
use App\Models\Client;
use App\Models\Compte;
use App\Services\CompteService;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;



class CompteController extends Controller
{
    use ApiResponse;

    protected CompteService $compteService;

    public function __construct(CompteService $compteService)
    {
        $this->compteService = $compteService;
    }
    /**
     * @OA\Get(
     *     path="/api/v1/ndiaye.mapathe/comptes",
     *     summary="Liste tous les comptes",
     *     description="Admin peut récupérer la liste de tous les comptes. Client peut récupérer la liste de ses comptes.",
     *     operationId="listComptes",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="X-Role",
     *         in="header",
     *         description="Rôle de l'utilisateur (admin/client)",
     *         required=true,
     *         @OA\Schema(type="string", enum={"admin", "client"}, example="admin")
     *     ),
     *     @OA\Parameter(
     *         name="X-Telephone",
     *         in="header",
     *         description="Numéro de téléphone du client (requis pour le rôle client)",
     *         required=false,
     *         @OA\Schema(type="string", pattern="^\\+221[0-9]{9}$", example="+221776543210")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Liste des comptes récupérée avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string", example="success"),
     *             @OA\Property(property="message", type="string", example="Liste des comptes récupérée avec succès"),
     *             @OA\Property(property="data", type="array", @OA\Items(ref="#/components/schemas/Compte"))
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Non autorisé"
     *     )
     * )
     */
    public function index(Request $request): JsonResponse
    {
        try {
            $role = $request->header('X-Role');
            Log::info('Current role: ' . $role); // Pour déboguer

            $user = $request->attributes->get('user');

            // Si l'utilisateur est un client, filtrer par ses comptes
            if ($user->role === 'client') {
                $comptes = $this->compteService->getComptesByTelephone($user->telephone, $request->all());
            } else {
                // Admin peut voir tous les comptes
                $comptes = $this->compteService->getAllComptes($request->all());
            }

            // Transform items using CompteResource
            $comptesData = CompteResource::collection($comptes->items());
            $pagination = [
                'currentPage' => $comptes->currentPage(),
                'totalPages' => $comptes->lastPage(),
                'totalItems' => $comptes->total(),
                'itemsPerPage' => $comptes->perPage(),
                'hasNext' => $comptes->hasMorePages(),
                'hasPrevious' => $comptes->currentPage() > 1,
            ];
            $links = [
                'self' => request()->fullUrl(),
                'next' => $comptes->nextPageUrl(),
                'first' => $comptes->url(1),
                'last' => $comptes->url($comptes->lastPage()),
            ];
            $links = array_filter($links, fn($link) => $link !== null);

            return response()->json([
                'success' => true,
                'message' => 'Liste des comptes récupérée avec succès',
                'data' => $comptesData,
                'pagination' => $pagination,
                'links' => $links,
            ], 200);
        } catch (\Exception $e) {
            Log::error('Error in CompteController@index: ' . $e->getMessage());
            return $this->errorResponse($e->getMessage());
        }
    }

    /**
     * @OA\Post(
     *     path="/api/v1/ndiaye.mapathe/comptes",
     *     summary="Créer un nouveau compte",
     *     description="Créer un nouveau compte bancaire pour un client existant ou nouveau",
     *     operationId="createCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"type", "soldeInitial", "solde", "devise", "client"},
     *             @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}, example="cheque"),
     *             @OA\Property(property="soldeInitial", type="number", minimum=10000, example=50000),
     *             @OA\Property(property="solde", type="number", minimum=0, example=50000),
     *             @OA\Property(property="devise", type="string", enum={"XOF", "FCFA", "USD", "EUR"}, example="XOF"),
     *             @OA\Property(
     *                 property="client",
     *                 type="object",
     *                 description="Informations du client",
     *                 oneOf={
     *                     @OA\Schema(
     *                         title="Client existant",
     *                         @OA\Property(property="id", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440000", description="ID du client existant")
     *                     ),
     *                     @OA\Schema(
     *                         title="Nouveau client",
     *                         required={"titulaire", "nci", "email", "telephone", "adresse"},
     *                         @OA\Property(property="titulaire", type="string", minLength=2, maxLength=255, example="Mamadou Diop"),
     *                         @OA\Property(property="nci", type="string", minLength=13, maxLength=13, pattern="^[12]\\d{12}$", example="1234567890123", description="13 chiffres commençant par 1 ou 2"),
     *                         @OA\Property(property="email", type="string", format="email", example="mamadou.diop@email.com"),
     *                         @OA\Property(property="telephone", type="string", pattern="^\\+221[0-9]{9}$", example="+221776543210", description="Format +221XXXXXXXXX (9 chiffres après +221)"),
     *                         @OA\Property(property="adresse", type="string", minLength=5, maxLength=500, example="123 Rue Kermel, Plateau, Dakar")
     *                     )
     *                 }
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Compte créé avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string", example="success"),
     *             @OA\Property(property="message", type="string", example="Compte créé avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Erreur de validation",
     *         @OA\JsonContent(
     *             @OA\Property(property="message", type="string", example="Le client sélectionné n'existe pas. (and 2 more errors)"),
     *             @OA\Property(
     *                 property="errors",
     *                 type="object",
     *                 @OA\Property(
     *                     property="client.id",
     *                     type="array",
     *                     @OA\Items(type="string", example="Le client sélectionné n'existe pas.")
     *                 ),
     *                 @OA\Property(
     *                     property="client.nci",
     *                     type="array",
     *                     @OA\Items(type="string", example="Ce numéro de carte d'identité est déjà utilisé.")
     *                 ),
     *                 @OA\Property(
     *                     property="client.telephone",
     *                     type="array",
     *                     @OA\Items(type="string", example="Le numéro de téléphone doit être au format +221XXXXXXXXX (9 chiffres après +221).")
     *                 )
     *             )
     *         )
     *     )
     * )
     */
    public function store(StoreCompteRequest $request): JsonResponse
    {
        try {
            // Create the account with client handling
            $compte = $this->compteService->createCompteWithClient($request->all());

            return $this->successResponse(
                new CompteResource($compte),
                Messages::COMPTE_CREATED,
                201
            );

        } catch (\Exception $e) {
            Log::error('Error in CompteController@store: ' . $e->getMessage());
            return $this->internalErrorResponse(Messages::CREATION_ERROR);
        }
    }


    /**
     * @OA\Get(
     *     path="/api/v1/ndiaye.mapathe/comptes/{compteId}",
     *     summary="Récupérer un compte spécifique",
     *     description="Admin peut récupérer n'importe quel compte. Client peut récupérer un de ses comptes. Recherche locale par défaut, puis serverless si non trouvé.",
     *     operationId="getCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="X-Role",
     *         in="header",
     *         description="Rôle de l'utilisateur (admin/client)",
     *         required=true,
     *         @OA\Schema(type="string", enum={"admin", "client"}, example="admin")
     *     ),
     *     @OA\Parameter(
     *         name="X-Telephone",
     *         in="header",
     *         description="Numéro de téléphone du client (requis pour le rôle client)",
     *         required=false,
     *         @OA\Schema(type="string", pattern="^\\+221[0-9]{9}$", example="+221776543210")
     *     ),
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte récupéré avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="COMPTE_NOT_FOUND"),
     *                 @OA\Property(property="message", type="string", example="Le compte avec l'ID spécifié n'existe pas"),
     *                 @OA\Property(property="details", type="object",
     *                     @OA\Property(property="compteId", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *                 )
     *             )
     *         )
     *     )
     * )
     */
    public function show(Request $request, string $compteId): JsonResponse
    {
        try {
            $role = $request->header('X-Role');
            $user = $request->attributes->get('user');

            // Recherche du compte avec stratégie locale/serverless
            $compte = $this->compteService->findCompte($compteId);

            if (!$compte) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $compteId
                        ]
                    ]
                ], 404);
            }

            // Vérification des autorisations pour les clients
            if ($user->role === 'client') {
                // Vérifier que le compte appartient au client
                if ($compte->client_id !== $user->client_id) {
                    return response()->json([
                        'success' => false,
                        'error' => [
                            'code' => 'COMPTE_NOT_FOUND',
                            'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                            'details' => [
                                'compteId' => $compteId
                            ]
                        ]
                    ], 404);
                }
            }

            return response()->json([
                'success' => true,
                'data' => new CompteResource($compte)
            ]);

        } catch (\Exception $e) {
            Log::error('Error in CompteController@show: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Une erreur interne s\'est produite',
                    'details' => [
                        'compteId' => $compteId
                    ]
                ]
            ], 500);
        }
    }

    /**
     * @OA\Patch(
     *     path="/api/v1/ndiaye.mapathe/comptes/{compteId}",
     *     summary="Mettre à jour les informations du client d'un compte",
     *     description="Admin peut modifier les informations client de n'importe quel compte. Tous les champs sont optionnels mais au moins un doit être fourni.",
     *     operationId="updateCompteClient",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="titulaire", type="string", minLength=2, maxLength=255, example="Amadou Diallo Junior"),
     *             @OA\Property(
     *                 property="informationsClient",
     *                 type="object",
     *                 @OA\Property(property="telephone", type="string", pattern="^\\+221[0-9]{9}$", example="+221771234568"),
     *                 @OA\Property(property="email", type="string", format="email", example="amadou.diallo@email.com"),
     *                 @OA\Property(property="password", type="string", minLength=8, example="newpassword123"),
     *                 @OA\Property(property="nci", type="string", minLength=13, maxLength=13, pattern="^[12]\\d{12}$", example="1234567890123")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte mis à jour avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte mis à jour avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="COMPTE_NOT_FOUND"),
     *                 @OA\Property(property="message", type="string", example="Le compte avec l'ID spécifié n'existe pas")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Erreur de validation",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="VALIDATION_ERROR"),
     *                 @OA\Property(property="message", type="string", example="Les données fournies ne sont pas valides")
     *             )
     *         )
     *     )
     * )
     */
    public function update(UpdateCompteRequest $request, string $compteId): JsonResponse
    {
        try {
            // Update the compte client information
            $compte = $this->compteService->updateCompteClient($compteId, $request->validated());

            if (!$compte) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $compteId
                        ]
                    ]
                ], 404);
            }

            return response()->json([
                'success' => true,
                'message' => 'Compte mis à jour avec succès',
                'data' => new CompteResource($compte)
            ]);

        } catch (\Exception $e) {
            Log::error('Error in CompteController@update: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Une erreur interne s\'est produite',
                    'details' => [
                        'compteId' => $compteId
                    ]
                ]
            ], 500);
        }
    }

    /**
     * @OA\Get(
     *     path="/api/v1/ndiaye.mapathe/clients/{client}/comptes",
     *     summary="Récupérer les comptes d'un client",
     *     description="Récupérer tous les comptes associés à un client spécifique",
     *     operationId="getClientComptes",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="client",
     *         in="path",
     *         description="ID du client",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440000")
     *     ),
     *     @OA\Parameter(
     *         name="page",
     *         in="query",
     *         description="Numéro de page",
     *         @OA\Schema(type="integer", default=1)
     *     ),
     *     @OA\Parameter(
     *         name="limit",
     *         in="query",
     *         description="Nombre d'éléments par page",
     *         @OA\Schema(type="integer", default=10, maximum=100)
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Comptes du client récupérés avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string", example="success"),
     *             @OA\Property(property="message", type="string", example="Comptes du client récupérés avec succès"),
     *             @OA\Property(property="data", type="array", @OA\Items(ref="#/components/schemas/Compte")),
     *             @OA\Property(property="pagination", type="object",
     *                 @OA\Property(property="current_page", type="integer"),
     *                 @OA\Property(property="per_page", type="integer"),
     *                 @OA\Property(property="total", type="integer")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Client non trouvé"
     *     )
     * )
     */
    public function clientComptes(Request $request, Client $client): JsonResponse
    {
        $comptes = $this->compteService->getComptesByClient($client, $request->all());

        // Transform items using CompteResource
        $comptesData = CompteResource::collection($comptes->items());
        $pagination = [
            'currentPage' => $comptes->currentPage(),
            'totalPages' => $comptes->lastPage(),
            'totalItems' => $comptes->total(),
            'itemsPerPage' => $comptes->perPage(),
            'hasNext' => $comptes->hasMorePages(),
            'hasPrevious' => $comptes->currentPage() > 1,
        ];
        $links = [
            'self' => request()->fullUrl(),
            'next' => $comptes->nextPageUrl(),
            'first' => $comptes->url(1),
            'last' => $comptes->url($comptes->lastPage()),
        ];
        $links = array_filter($links, fn($link) => $link !== null);

        return response()->json([
            'success' => true,
            'message' => 'Comptes du client récupérés avec succès',
            'data' => $comptesData,
            'pagination' => $pagination,
            'links' => $links,
        ], 200);
    }

    /**
     * @OA\Get(
     *     path="/api/v1/ndiaye.mapathe/clients/{client}/comptes/{compte}",
     *     summary="Récupérer un compte spécifique d'un client",
     *     description="Récupérer les détails d'un compte spécifique appartenant à un client",
     *     operationId="getClientCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="client",
     *         in="path",
     *         description="ID du client",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid")
     *     ),
     *     @OA\Parameter(
     *         name="compte",
     *         in="path",
     *         description="ID du compte",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte récupéré avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="status", type="string", example="success"),
     *             @OA\Property(property="message", type="string", example="Compte récupéré avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Client ou compte non trouvé"
     *     )
     * )
     */
    public function clientCompte(Client $client, Compte $compte): JsonResponse
    {
        // Verify that the compte belongs to the client
        if ($compte->client_id !== $client->id) {
            return $this->notFoundResponse('Compte');
        }

        return $this->successResponse(
            new CompteResource($compte),
            'Compte récupéré avec succès'
        );
    }

    /**
     * @OA\Delete(
     *     path="/api/v1/ndiaye.mapathe/comptes/{compteId}",
     *     summary="Supprimer un compte (soft delete)",
     *     description="Admin peut supprimer n'importe quel compte. Le compte passe au statut 'ferme' avec dateFermeture et fait l'objet d'un soft delete.",
     *     operationId="deleteCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte à supprimer",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte supprimé avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte supprimé avec succès"),
     *             @OA\Property(property="data", type="object",
     *                 @OA\Property(property="id", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001"),
     *                 @OA\Property(property="numeroCompte", type="string", example="COMP-123456"),
     *                 @OA\Property(property="statut", type="string", example="ferme"),
     *                 @OA\Property(property="dateFermeture", type="string", format="date-time", example="2025-10-27T09:23:00Z")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="COMPTE_NOT_FOUND"),
     *                 @OA\Property(property="message", type="string", example="Le compte avec l'ID spécifié n'existe pas")
     *             )
     *         )
     *     )
     * )
     */
    public function destroy(string $compteId): JsonResponse
    {
        try {
            Log::info('Attempting to delete compte with ID: ' . $compteId);

            // Delete the compte (soft delete with status change)
            $compte = $this->compteService->deleteCompte($compteId);

            if (!$compte) {
                Log::warning('Compte not found for deletion: ' . $compteId);
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $compteId
                        ]
                    ]
                ], 404);
            }

            Log::info('Compte deleted successfully: ' . $compteId);
            return response()->json([
                'success' => true,
                'message' => 'Compte supprimé avec succès',
                'data' => [
                    'id' => $compte->id,
                    'numeroCompte' => $compte->numero,
                    'statut' => $compte->statut,
                    'dateFermeture' => $compte->dateFermeture ? \Carbon\Carbon::parse($compte->dateFermeture)->toISOString() : null,
                ]
            ]);

        } catch (\Exception $e) {
            Log::error('Error in CompteController@destroy: ' . $e->getMessage());
            Log::error('Stack trace: ' . $e->getTraceAsString());
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Une erreur interne s\'est produite',
                    'details' => [
                        'compteId' => $compteId,
                        'error' => $e->getMessage()
                    ]
                ]
            ], 500);
        }
    }

    /**
     * @OA\Post(
     *     path="/api/v1/ndiaye.mapathe/comptes/{compteId}/bloquer",
     *     summary="Bloquer un compte",
     *     description="Admin peut bloquer un compte en spécifiant un motif et les dates de blocage. Le compte sera automatiquement archivé à la date de début de blocage.",
     *     operationId="bloquerCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte à bloquer",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"motifBlocage", "dateDebutBlocage", "dateFinBlocage"},
     *             @OA\Property(property="motifBlocage", type="string", minLength=5, maxLength=500, example="Suspicion de fraude"),
     *             @OA\Property(property="dateDebutBlocage", type="string", format="date", example="2025-10-30"),
     *             @OA\Property(property="dateFinBlocage", type="string", format="date", example="2025-11-30")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte bloqué avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte bloqué avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="COMPTE_NOT_FOUND"),
     *                 @OA\Property(property="message", type="string", example="Le compte avec l'ID spécifié n'existe pas")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=422,
     *         description="Erreur de validation",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="VALIDATION_ERROR"),
     *                 @OA\Property(property="message", type="string", example="Les données fournies ne sont pas valides")
     *             )
     *         )
     *     )
     * )
     */
    public function bloquer(\App\Http\Requests\BloquerCompteRequest $request, string $compteId): JsonResponse
    {
        try {
            // Bloquer le compte
            $compte = $this->compteService->bloquerCompte($compteId, $request->validated());

            if (!$compte) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $compteId
                        ]
                    ]
                ], 404);
            }

            return response()->json([
                'success' => true,
                'message' => 'Compte bloqué avec succès',
                'data' => new CompteResource($compte)
            ]);

        } catch (\Exception $e) {
            Log::error('Error in CompteController@bloquer: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Une erreur interne s\'est produite',
                    'details' => [
                        'compteId' => $compteId,
                        'error' => $e->getMessage()
                    ]
                ]
            ], 500);
        }
    }

    /**
     * @OA\Post(
     *     path="/api/v1/ndiaye.mapathe/comptes/{compteId}/debloquer",
     *     summary="Débloquer un compte",
     *     description="Admin peut débloquer un compte bloqué, ce qui le remet en statut actif et annule l'archivage automatique.",
     *     operationId="debloquerCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte à débloquer",
     *         required=true,
     *         @OA\Schema(type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Compte débloqué avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte débloqué avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="COMPTE_NOT_FOUND"),
     *                 @OA\Property(property="message", type="string", example="Le compte avec l'ID spécifié n'existe pas")
     *             )
     *         )
     *     )
     * )
     */
    public function debloquer(string $compteId): JsonResponse
    {
        try {
            // Débloquer le compte
            $compte = $this->compteService->debloquerCompte($compteId);

            if (!$compte) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $compteId
                        ]
                    ]
                ], 404);
            }

            return response()->json([
                'success' => true,
                'message' => 'Compte débloqué avec succès',
                'data' => new CompteResource($compte)
            ]);

        } catch (\Exception $e) {
            Log::error('Error in CompteController@debloquer: ' . $e->getMessage());
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INTERNAL_ERROR',
                    'message' => 'Une erreur interne s\'est produite',
                    'details' => [
                        'compteId' => $compteId,
                        'error' => $e->getMessage()
                    ]
                ]
            ], 500);
        }
    }
}
