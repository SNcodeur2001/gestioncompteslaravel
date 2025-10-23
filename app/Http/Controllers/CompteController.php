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
     * Display a listing of the resource.
     *
     * @param Request $request
     * @return JsonResponse
     */
    public function index(Request $request): JsonResponse
    {
        $comptes = $this->compteService->getAllComptes($request->all());

        return $this->paginatedResponse(
            $comptes,
            'Liste des comptes récupérée avec succès'
        );
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param StoreCompteRequest $request
     * @return JsonResponse
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
     * Display the specified resource.
     *
     * @param Compte $compte
     * @return JsonResponse
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
     * Display a listing of the comptes for a specific client.
     *
     * @param Request $request
     * @param Client $client
     * @return JsonResponse
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
     * Display a specific compte for a specific client.
     *
     * @param Client $client
     * @param Compte $compte
     * @return JsonResponse
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
