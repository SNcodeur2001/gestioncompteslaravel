<?php

namespace App\Listeners;

use App\Events\CompteCreated;
use App\Services\NotificationService;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Queue\InteractsWithQueue;

class SendClientNotification implements ShouldQueue
{
    use InteractsWithQueue;

    protected NotificationService $notificationService;

    /**
     * Create the event listener.
     */
    public function __construct(NotificationService $notificationService)
    {
        $this->notificationService = $notificationService;
    }

    /**
     * Handle the event.
     */
    public function handle(CompteCreated $event): void
    {
        // Send authentication email with generated password
        $this->notificationService->sendAuthenticationEmail(
            $event->compte->client->email,
            $event->generatedPassword
        );

        // Send SMS with verification code
        $this->notificationService->sendSMSCode(
            $event->compte->client->telephone,
            $event->generatedCode
        );
    }
}