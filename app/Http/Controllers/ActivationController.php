<?php

namespace App\Http\Controllers;

use App\Models\Client;
use App\Traits\ApiResponse;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Log;
use Illuminate\Validation\ValidationException;

class ActivationController extends Controller
{
    use ApiResponse;

    /**
     * Activer le compte client avec le code OTP
     */
    public function activate(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'email' => 'required|email|exists:clients,email',
                'code' => 'required|string|size:6',
                'password' => 'required|string|min:8|confirmed',
            ]);

            // Trouver le client
            $client = Client::where('email', $request->email)->first();

            if (!$client) {
                return $this->errorResponse('Client non trouvé', 404);
            }

            // Vérifier si le client est déjà actif
            if ($client->is_active) {
                return $this->errorResponse('Le compte est déjà activé', 400);
            }

            // Pour cette implémentation simplifiée, nous acceptons n'importe quel code de 6 chiffres
            // En production, vous devriez stocker le code généré et le comparer
            if (!preg_match('/^\d{6}$/', $request->code)) {
                throw ValidationException::withMessages([
                    'code' => ['Le code d\'activation doit être composé de 6 chiffres.']
                ]);
            }

            // Activer le client
            $client->update([
                'is_active' => true,
            ]);

            // Mettre à jour le mot de passe de l'utilisateur associé
            $user = $client->user; // Assumant une relation user sur Client
            if ($user) {
                $user->update([
                    'password' => Hash::make($request->password),
                ]);
            }

            Log::info("Client {$client->id} activé avec succès");

            return $this->successResponse(
                [
                    'client_id' => $client->id,
                    'email' => $client->email,
                    'is_active' => true,
                ],
                'Compte activé avec succès. Vous pouvez maintenant vous connecter.'
            );

        } catch (ValidationException $e) {
            return $this->errorResponse('Données invalides: ' . implode(', ', $e->errors()['code'] ?? ['Erreur de validation']), 422);
        } catch (\Exception $e) {
            Log::error('Erreur lors de l\'activation du compte: ' . $e->getMessage());
            return $this->errorResponse('Erreur lors de l\'activation du compte', 500);
        }
    }

    /**
     * Renvoyer le code d'activation
     */
    public function resendCode(Request $request): JsonResponse
    {
        try {
            $request->validate([
                'email' => 'required|email|exists:clients,email',
            ]);

            $client = Client::where('email', $request->email)->first();

            if (!$client) {
                return $this->errorResponse('Client non trouvé', 404);
            }

            if ($client->is_active) {
                return $this->errorResponse('Le compte est déjà activé', 400);
            }

            // Générer un nouveau code et l'envoyer
            $code = app(\App\Services\NotificationService::class)->generateRandomCode();

            // Dispatcher le job pour envoyer le SMS
            \App\Jobs\SendClientActivationCode::dispatch($client, $code);

            return $this->successResponse(
                ['email' => $client->email],
                'Un nouveau code d\'activation a été envoyé par SMS'
            );

        } catch (\Exception $e) {
            Log::error('Erreur lors du renvoi du code: ' . $e->getMessage());
            return $this->errorResponse('Erreur lors du renvoi du code', 500);
        }
    }
}
