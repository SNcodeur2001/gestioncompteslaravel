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
            'numero' => 'COMP-' . $this->faker->unique()->numerify('######'),
            'type' => $this->faker->randomElement(['cheque', 'courant', 'epagne']),
            'soldeInitial' => $this->faker->numberBetween(1000, 1000000),
            'solde' => $this->faker->numberBetween(0, 500000),
            'devise' => 'FCFA',
        ];
    }
}
