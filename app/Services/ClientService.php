<?php

namespace App\Services;

use App\Models\Client;
use App\Models\User;

class ClientService
{
    protected NotificationService $notificationService;

    public function __construct(NotificationService $notificationService)
    {
        $this->notificationService = $notificationService;
    }

    /**
     * Create a new client and associated user account
     */
    public function createClientWithUser(array $clientData): Client
    {
        // Create new client
        $client = Client::create([
            'titulaire' => $clientData['titulaire'],
            'nci' => $clientData['nci'],
            'email' => $clientData['email'],
            'telephone' => $clientData['telephone'],
            'adresse' => $clientData['adresse'],
        ]);

        // Create user account for the client
        $generatedPassword = $this->notificationService->generateRandomPassword();
        $generatedCode = $this->notificationService->generateRandomCode();

        User::create([
            'name' => $client->titulaire,
            'email' => $client->email,
            'password' => bcrypt($generatedPassword),
            'role' => 'client',
            'client_id' => $client->id,
        ]);

        // Send notifications
        $this->notificationService->sendAuthenticationEmail($client->email, $generatedPassword);
        $this->notificationService->sendSMSCode($client->telephone, $generatedCode);

        return $client;
    }

    /**
     * Find existing client by ID
     */
    public function findClient(string $clientId): Client
    {
        return Client::findOrFail($clientId);
    }
}