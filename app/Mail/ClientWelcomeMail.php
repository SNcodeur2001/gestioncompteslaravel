<?php

namespace App\Mail;

use App\Models\Client;
use Illuminate\Bus\Queueable;
use Illuminate\Contracts\Queue\ShouldQueue;
use Illuminate\Mail\Mailable;
use Illuminate\Mail\Mailables\Content;
use Illuminate\Mail\Mailables\Envelope;
use Illuminate\Queue\SerializesModels;

class ClientWelcomeMail extends Mailable implements ShouldQueue
{
    use Queueable, SerializesModels;

    public Client $client;
    public string $password;

    /**
     * Create a new message instance.
     */
    public function __construct(Client $client, string $password)
    {
        $this->client = $client;
        $this->password = $password;
    }

    /**
     * Get the message envelope.
     */
    public function envelope(): Envelope
    {
        return new Envelope(
            subject: 'Bienvenue à la Banque Woyofal',
        );
    }

    /**
     * Get the message content definition.
     */
    public function content(): Content
    {
        return new Content(
            htmlString: $this->getWelcomeEmailTemplate(),
        );
    }

    /**
     * Get the welcome email HTML template
     */
    private function getWelcomeEmailTemplate(): string
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

                <p>Bonjour <strong>{$this->client->titulaire}</strong>,</p>

                <p>Votre compte client a été créé avec succès.</p>

                <div style='background-color: #f8f9fa; padding: 15px; border-radius: 5px; margin: 20px 0;'>
                    <h3 style='margin-top: 0; color: #495057;'>Vos identifiants temporaires :</h3>
                    <p><strong>Email :</strong> {$this->client->email}</p>
                    <p><strong>Mot de passe :</strong> {$this->password}</p>
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

    /**
     * Get the attachments for the message.
     *
     * @return array<int, \Illuminate\Mail\Mailables\Attachment>
     */
    public function attachments(): array
    {
        return [];
    }
}
