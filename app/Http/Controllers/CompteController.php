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
     *     path="/api/comptes",
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
     *         @OA\Schema(type="string")
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

            return $this->paginatedResponse(
                $comptes,
                'Liste des comptes récupérée avec succès'
            );
        } catch (\Exception $e) {
            Log::error('Error in CompteController@index: ' . $e->getMessage());
            return $this->errorResponse($e->getMessage());
        }
    }

    /**
     * @OA\Post(
     *     path="/api/comptes",
     *     summary="Créer un nouveau compte",
     *     description="Créer un nouveau compte bancaire pour un client existant ou nouveau",
     *     operationId="createCompte",
     *     tags={"Comptes"},
     *     security={{"bearerAuth":{}}},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}),
     *             @OA\Property(property="soldeInitial", type="number"),
     *             @OA\Property(property="solde", type="number"),
     *             @OA\Property(property="devise", type="string", example="XOF"),
     *             @OA\Property(
     *                 property="client",
     *                 type="object",
     *                 @OA\Property(property="id", type="integer", nullable=true),
     *                 @OA\Property(property="titulaire", type="string"),
     *                 @OA\Property(property="nci", type="string"),
     *                 @OA\Property(property="email", type="string"),
     *                 @OA\Property(property="telephone", type="string"),
     *                 @OA\Property(property="adresse", type="string")
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
     *         description="Erreur de validation"
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

    public function clientComptes(Request $request, Client $client): JsonResponse
    {
        $comptes = $this->compteService->getComptesByClient($client, $request->all());

        return $this->paginatedResponse(
            $comptes,
            'Comptes du client récupérés avec succès'
        );
    }

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
