<?php

namespace App\Http\Controllers;

use App\Constants\Messages;
use App\Exceptions\CompteNotFoundException;
use App\Http\Requests\StoreCompteRequest;
use App\Http\Resources\CompteResource;
use App\Models\Client;
use App\Models\Compte;
use App\Models\User;
use App\Services\CompteService;
use App\Traits\ApiResponse;
use Illuminate\Http\Request;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Log;
use Illuminate\Support\Facades\Mail;
use Illuminate\Support\Str;

/**
 * @OA\Info(
 *     title="API Bancaire - Gestion des Comptes",
 *     version="1.0.0",
 *     description="API pour la gestion des comptes bancaires, clients et transactions"
 * )
 *
 * @OA\Server(
 *     url="http://localhost:8001/api/v1",
 *     description="Serveur de développement"
 * )
 *
 * @OA\SecurityScheme(
 *     securityScheme="bearerAuth",
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="JWT"
 * )
 */

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
     *     path="/comptes",
     *     tags={"Comptes"},
     *     summary="Lister tous les comptes",
     *     description="Admin peut récupérer la liste de tous les comptes. Client peut récupérer la liste de ses comptes. Liste compte non supprimés type cheque ou compte Epargne Actif",
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
     *         description="Liste des comptes récupérée avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Liste des comptes récupérée avec succès"),
     *             @OA\Property(property="data", type="array", @OA\Items(ref="#/components/schemas/Compte"), example={}),
     *             @OA\Property(property="pagination", type="object",
     *                 @OA\Property(property="currentPage", type="integer", example=1),
     *                 @OA\Property(property="totalPages", type="integer", example=1),
     *                 @OA\Property(property="totalItems", type="integer", example=0),
     *                 @OA\Property(property="itemsPerPage", type="integer", example=10),
     *                 @OA\Property(property="hasNext", type="boolean", example=false),
     *                 @OA\Property(property="hasPrevious", type="boolean", example=false)
     *             ),
     *             @OA\Property(property="links", type="object",
     *                 @OA\Property(property="self", type="string", example="http://localhost:8001/api/v1/comptes?page=1"),
     *                 @OA\Property(property="next", type="string", example=null),
     *                 @OA\Property(property="first", type="string", example="http://localhost:8001/api/v1/comptes?page=1"),
     *                 @OA\Property(property="last", type="string", example="http://localhost:8001/api/v1/comptes?page=1")
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
        $user = $request->attributes->get('user');

        // Si l'utilisateur est un client, filtrer par ses comptes
        if ($user->role === 'client') {
            $comptes = $this->compteService->getComptesByTelephone($user->telephone, $request->all());
        } else {
            // Admin peut voir tous les comptes
            $comptes = $this->compteService->getAllComptes($request->all());
        }

        return $this->paginatedResponse(
            $comptes,
            'Liste des comptes récupérée avec succès'
        );
    }

    /**
     * @OA\Post(
     *     path="/comptes",
     *     tags={"Comptes"},
     *     summary="Créer un nouveau compte",
     *     description="Créer un nouveau compte bancaire pour un client existant ou nouveau",
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"type", "soldeInitial", "solde", "devise"},
     *             @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}, example="epargne"),
     *             @OA\Property(property="soldeInitial", type="number", format="float", example=1000.00),
     *             @OA\Property(property="solde", type="number", format="float", example=1000.00),
     *             @OA\Property(property="devise", type="string", example="XOF"),
     *             @OA\Property(property="client", type="object",
     *                 oneOf={
     *                     @OA\Schema(
     *                         required={"id"},
     *                         @OA\Property(property="id", type="string", example="string")
     *                     ),
     *                     @OA\Schema(
     *                         required={"titulaire", "nci", "email", "telephone", "adresse"},
     *                         @OA\Property(property="titulaire", type="string", example="John Doe"),
     *                         @OA\Property(property="nci", type="string", example="1234567890123"),
     *                         @OA\Property(property="email", type="string", format="email", example="john.doe@example.com"),
     *                         @OA\Property(property="telephone", type="string", example="221771234567"),
     *                         @OA\Property(property="adresse", type="string", example="Dakar, Sénégal")
     *                     )
     *                 }
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=201,
     *         description="Compte créé avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="COMPTE_CREATED"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=400,
     *         description="Données invalides",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="CREATION_ERROR")
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
    public function store(StoreCompteRequest $request): JsonResponse
    {
        try {
            // Check if client exists or create new one
            $client = null;
            if ($request->input('client.id')) {
                // Use existing client
                $client = Client::findOrFail($request->input('client.id'));
            } else {
                // Create new client
                $client = Client::create([
                    'titulaire' => $request->input('client.titulaire'),
                    'nci' => $request->input('client.nci'),
                    'email' => $request->input('client.email'),
                    'telephone' => $request->input('client.telephone'),
                    'adresse' => $request->input('client.adresse'),
                ]);

                // Create user account for the client
                $generatedPassword = $this->generateRandomPassword();
                $generatedCode = $this->generateRandomCode();

                User::create([
                    'name' => $client->titulaire,
                    'email' => $client->email,
                    'password' => bcrypt($generatedPassword),
                    'role' => 'client',
                    'client_id' => $client->id,
                ]);

                // Send email with authentication details
                $this->sendAuthenticationEmail($client->email, $generatedPassword);

                // Send SMS with code
                $this->sendSMSCode($client->telephone, $generatedCode);
            }

            // Create the account
            $compte = $this->compteService->createCompte([
                'numero' => null, // This will trigger the setNumeroAttribute mutator
                'type' => $request->input('type'),
                'soldeInitial' => $request->input('soldeInitial'),
                'solde' => $request->input('solde'),
                'devise' => $request->input('devise'),
                'client_id' => $client->id,
                'statut' => 'actif',
            ]);

            return $this->successResponse(
                new CompteResource($compte),
                Messages::COMPTE_CREATED,
                201
            );

        } catch (\Exception $e) {
            return $this->internalErrorResponse(Messages::CREATION_ERROR);
        }
    }

    /**
     * Generate a random password for new users
     */
    private function generateRandomPassword(): string
    {
        return Str::random(12);
    }

    /**
     * Generate a random code for SMS verification
     */
    private function generateRandomCode(): string
    {
        return str_pad(mt_rand(0, 999999), 6, '0', STR_PAD_LEFT);
    }

    /**
     * Send authentication email with generated password
     */
    private function sendAuthenticationEmail(string $email, string $password): void
    {
        // Placeholder for email sending
        // In production, implement proper email sending with Mail facade
        Log::info("Email would be sent to {$email} with password: {$password}");

        // Example implementation:
        /*
        Mail::to($email)->send(new WelcomeEmail($password));
        */
    }

    /**
     * Send SMS with verification code
     */
    private function sendSMSCode(string $phone, string $code): void
    {
        // Placeholder for SMS sending
        // In production, integrate with SMS service provider
        Log::info("SMS would be sent to {$phone} with code: {$code}");

        // Example implementation:
        /*
        $smsService = app(SMSService::class);
        $smsService->send($phone, "Your verification code is: {$code}");
        */
    }

    /**
     * @OA\Get(
     *     path="/comptes/{compteId}",
     *     tags={"Comptes"},
     *     summary="Afficher un compte spécifique",
     *     description="Récupérer les détails d'un compte spécifique",
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="compteId",
     *         in="path",
     *         description="ID du compte",
     *         required=true,
     *         @OA\Schema(type="string", example="458d13a0-2a2d-4982-a426-1a5b297cdfbc")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Détails du compte récupérés avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte récupéré avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Compte non trouvé")
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
    public function show(Compte $compte): JsonResponse
    {
        $compte = $this->compteService->findCompte($compte->id);

        if (!$compte) {
            return $this->notFoundResponse('Compte');
        }

        return $this->successResponse(new CompteResource($compte));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
    {
        //
    }

    /**
     * @OA\Get(
     *     path="/clients/{client}/comptes",
     *     tags={"Comptes"},
     *     summary="Lister les comptes d'un client spécifique",
     *     description="Récupérer la liste des comptes d'un client spécifique",
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="client",
     *         in="path",
     *         description="ID du client",
     *         required=true,
     *         @OA\Schema(type="string", example="e95d1e5d-938b-48e1-8619-f66bd722bef6")
     *     ),
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
     *     @OA\Response(
     *         response=200,
     *         description="Comptes du client récupérés avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Comptes du client récupérés avec succès"),
     *             @OA\Property(property="data", type="array", @OA\Items(ref="#/components/schemas/Compte")),
     *             @OA\Property(property="pagination", type="object",
     *                 @OA\Property(property="currentPage", type="integer", example=1),
     *                 @OA\Property(property="totalPages", type="integer", example=2),
     *                 @OA\Property(property="totalItems", type="integer", example=15),
     *                 @OA\Property(property="itemsPerPage", type="integer", example=10),
     *                 @OA\Property(property="hasNext", type="boolean", example=true),
     *                 @OA\Property(property="hasPrevious", type="boolean", example=false)
     *             ),
     *             @OA\Property(property="links", type="object",
     *                 @OA\Property(property="self", type="string", example="http://localhost:8001/api/v1/clients/1/comptes?page=1"),
     *                 @OA\Property(property="next", type="string", example="http://localhost:8001/api/v1/clients/1/comptes?page=2"),
     *                 @OA\Property(property="first", type="string", example="http://localhost:8001/api/v1/clients/1/comptes?page=1"),
     *                 @OA\Property(property="last", type="string", example="http://localhost:8001/api/v1/clients/1/comptes?page=2")
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Client non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Client non trouvé")
     *         )
     *     ),
     *     @OA\Response(
     *         response=500,
     *         description="Erreur interne du serveur",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Erreur interne du serveur")
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
    public function clientComptes(Request $request, Client $client): JsonResponse
    {
        $comptes = $this->compteService->getComptesByClient($client, $request->all());

        return $this->paginatedResponse(
            $comptes,
            'Comptes du client récupérés avec succès'
        );
    }

    /**
     * @OA\Get(
     *     path="/clients/{client}/comptes/{compte}",
     *     tags={"Comptes"},
     *     summary="Afficher un compte spécifique d'un client",
     *     description="Récupérer les détails d'un compte spécifique appartenant à un client",
     *     security={{"bearerAuth":{}}},
     *     @OA\Parameter(
     *         name="client",
     *         in="path",
     *         description="ID du client",
     *         required=true,
     *         @OA\Schema(type="string", example="e95d1e5d-938b-48e1-8619-f66bd722bef6")
     *     ),
     *     @OA\Parameter(
     *         name="compte",
     *         in="path",
     *         description="ID du compte",
     *         required=true,
     *         @OA\Schema(type="string", example="458d13a0-2a2d-4982-a426-1a5b297cdfbc")
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Détails du compte récupérés avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Compte récupéré avec succès"),
     *             @OA\Property(property="data", ref="#/components/schemas/Compte")
     *         )
     *     ),
     *     @OA\Response(
     *         response=404,
     *         description="Compte ou client non trouvé",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Compte non trouvé")
     *         )
     *     ),
     *     @OA\Response(
     *         response=500,
     *         description="Erreur interne du serveur",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="message", type="string", example="Erreur interne du serveur")
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
     * Remove the specified resource from storage.
     */
    public function destroy(string $id)
    {
        //
    }
}
