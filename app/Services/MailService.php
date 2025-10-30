<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class MailService
{
    protected string $apiKey;
    protected string $senderName;
    protected string $senderEmail;

    public function __construct()
    {
        $this->apiKey = config('services.brevo.api_key');
        $this->senderName = config('services.brevo.sender_name');
        $this->senderEmail = config('services.brevo.sender_email');
    }

    /**
     * Send welcome email to new client
     */
    public function sendWelcomeEmail(string $email, string $clientName, string $password): bool
    {
        try {
            $response = Http::withHeaders([
                'accept' => 'application/json',
                'api-key' => $this->apiKey,
                'content-type' => 'application/json',
            ])->post('https://api.brevo.com/v3/smtp/email', [
                'sender' => [
                    'name' => $this->senderName,
                    'email' => $this->senderEmail,
                ],
                'to' => [
                    [
                        'email' => $email,
                        'name' => $clientName,
                    ]
                ],
                'subject' => 'Bienvenue à la Banque Woyofal',
                'htmlContent' => $this->getWelcomeEmailTemplate($clientName, $email, $password),
            ]);

            if ($response->successful()) {
                Log::info("Welcome email sent successfully to {$email}");
                return true;
            } else {
                Log::error("Failed to send welcome email to {$email}: " . $response->body());
                return false;
            }
        } catch (\Exception $e) {
            Log::error("Exception while sending welcome email to {$email}: " . $e->getMessage());
            return false;
        }
    }

    /**
     * Get the welcome email HTML template
     */
    private function getWelcomeEmailTemplate(string $clientName, string $email, string $password): string
    {
        return "
        <!DOCTYPE html>
        <html>
        <head>
            <meta charset='UTF-8'>
            <title>Bienvenue à la Banque Woyofal</title>
        </head>
        <body style='font-family: Arial, sans-serif; line-height: 1.6; color: #333;'>
            <div style='max-width: 600px; margin: 0 auto; padding: 20px;'>
                <h1 style='color: #2c3e50; text-align: center;'>Bienvenue à la Banque Woyofal</h1>

                <p>Bonjour <strong>{$clientName}</strong>,</p>

                <p>Votre compte client a été créé avec succès.</p>

                <div style='background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>
                    <h3 style='margin-top: 0; color: #495057;'>Vos identifiants temporaires :</h3>
                    <p><strong>Email :</strong> {$email}</p>
                    <p><strong>Mot de passe :</strong> {$password}</p>
                </div>

                <p>Un code d'activation vous a été envoyé par SMS.</p>
                <p>Veuillez l'utiliser pour activer votre compte lors de votre première connexion.</p>

                <div style='margin-top: 30px; padding-top: 20px; border-top: 1px solid #dee2e6;'>
                    <p style='color: #6c757d; font-size: 14px;'>
                        Cordialement,<br>
                        L'équipe de la Banque Woyofal
                    </p>
                </div>
            </div>
        </body>
        </html>
        ";
    }
}