<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class BrevoSmsService
{
    protected string $apiKey;

    public function __construct()
    {
        $this->apiKey = config('services.brevo.api_key') ?? '';
    }

    /**
     * Send activation code via SMS using Brevo
     */
    public function sendActivationCode(string $phoneNumber, string $code): bool
    {
        try {
            // Format phone number for Brevo (remove + and spaces)
            $formattedNumber = preg_replace('/[^0-9]/', '', $phoneNumber);

            $response = Http::withHeaders([
                'accept' => 'application/json',
                'api-key' => $this->apiKey,
                'content-type' => 'application/json',
            ])->post('https://api.brevo.com/v3/transactionalSMS/sms', [
                'sender' => 'BanqueWoyofal',
                'recipient' => $formattedNumber,
                'content' => "Votre code d'activation est {$code}. Ne le partagez pas.",
                'type' => 'transactional',
            ]);

            if ($response->successful()) {
                Log::info("Activation SMS sent successfully to {$phoneNumber}");
                return true;
            } else {
                Log::error("Failed to send activation SMS to {$phoneNumber}: " . $response->body());
                return false;
            }
        } catch (\Exception $e) {
            Log::error("Exception while sending activation SMS to {$phoneNumber}: " . $e->getMessage());
            return false;
        }
    }
}