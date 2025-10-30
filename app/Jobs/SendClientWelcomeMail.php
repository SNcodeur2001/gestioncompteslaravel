<?php

namespace App\Jobs;

use App\Models\Client;
use App\Services\MailService;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Foundation\Bus\Dispatchable;
use Illuminate\Queue\InteractsWithQueue;
use Illuminate\Queue\SerializesModels;
use Illuminate\Support\Facades\Log;

class SendClientWelcomeMail implements ShouldQueue
{
    use Dispatchable, InteractsWithQueue, Queueable, SerializesModels;

    protected Client $client;
    protected string $password;

    /**
     * Create a new job instance.
     */
    public function __construct(Client $client, string $password)
    {
        $this->client = $client;
        $this->password = $password;
    }

    /**
     * Execute the job.
     */
    public function handle(MailService $mailService): void
    {
        try {
            $success = $mailService->sendWelcomeEmail(
                $this->client->email,
                $this->client->titulaire,
                $this->password
            );

            if (!$success) {
                Log::error("Failed to send welcome email to client {$this->client->id}");
                // Could implement retry logic or notification to admin here
            }
        } catch (\Exception $e) {
            Log::error("Exception in SendClientWelcomeMail job: " . $e->getMessage());
            throw $e; // Re-throw to mark job as failed
        }
    }
}
