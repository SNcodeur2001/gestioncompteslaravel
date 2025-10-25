<?php

namespace App\Events;

use App\Models\Compte;
use Illuminate\Foundation\Events\Dispatchable;
use Illuminate\Queue\SerializesModels;

class CompteCreated
{
    use Dispatchable, SerializesModels;

    public Compte $compte;
    public string $generatedPassword;
    public string $generatedCode;

    /**
     * Create a new event instance.
     */
    public function __construct(Compte $compte, string $generatedPassword, string $generatedCode)
    {
        $this->compte = $compte;
        $this->generatedPassword = $generatedPassword;
        $this->generatedCode = $generatedCode;
    }
}