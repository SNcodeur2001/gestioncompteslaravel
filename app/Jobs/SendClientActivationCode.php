<?php

namespace App\Jobs;

use App\Models\Client;
use App\Services\TwilioSmsService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class SendClientActivationCode implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected Client $client;
    protected string $code;

    /**
     * Create a new job instance.
     */
    public function __construct(Client $client, string $code)
    {
        $this->client = $client;
        $this->code = $code;
    }

    /**
     * Execute the job.
     */
    public function handle(TwilioSmsService $smsService): void
    {
        try {
            $success = $smsService->sendActivationCode(
                $this->client->telephone,
                $this->code
            );

            if (!$success) {
                Log::error("Failed to send activation code SMS to client {$this->client->id}");
                // Could implement retry logic or notification to admin here
            }
        } catch (\Exception $e) {
            Log::error("Exception in SendClientActivationCode job: " . $e->getMessage());
            throw $e; // Re-throw to mark job as failed
        }
    }
}
