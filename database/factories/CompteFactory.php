<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;
use App\Models\Client;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Compte>
 */
class CompteFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        return [
            'client_id' => Client::factory(),
            'numero' => null, // Le mutator setNumeroAttribute va générer le numéro
            'type' => $this->faker->randomElement(['cheque', 'courant', 'epargne']),
            'soldeInitial' => $this->faker->numberBetween(10000, 1000000), // Minimum 10 000 FCFA
            'solde' => $this->faker->numberBetween(0, 500000),
            'devise' => $this->faker->randomElement(['XOF', 'FCFA', 'USD', 'EUR']),
            'statut' => $this->faker->randomElement(['actif', 'bloque', 'ferme']),
        ];
    }
}
