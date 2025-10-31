<?php

namespace App\Services;

use Illuminate\Support\Facades\Http;
use Illuminate\Support\Facades\Log;

class TwilioSmsService
{
    protected string $sid;
    protected string $token;
    protected string $from;

    public function __construct()
    {
        $this->sid = config('services.twilio.sid');
        $this->token = config('services.twilio.token');
        $this->from = config('services.twilio.from');
    }

    /**
     * Send activation code via SMS using Twilio
     */
    public function sendActivationCode(string $phoneNumber, string $code): bool
    {
        try {
            $response = Http::withBasicAuth($this->sid, $this->token)
                ->asForm()
                ->post("https://api.twilio.com/2010-04-01/Accounts/{$this->sid}/Messages.json", [
                    'From' => $this->from,
                    'To' => $phoneNumber,
                    'Body' => "Votre code d'activation Banque Woyofal est : {$code}. Ne le partagez pas.",
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