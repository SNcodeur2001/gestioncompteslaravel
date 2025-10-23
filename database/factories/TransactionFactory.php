<?php

namespace Database\Factories;

use Illuminate\Database\Eloquent\Factories\Factory;

/**
 * @extends \Illuminate\Database\Eloquent\Factories\Factory<\App\Models\Transaction>
 */
class TransactionFactory extends Factory
{
    /**
     * Define the model's default state.
     *
     * @return array<string, mixed>
     */
    public function definition(): array
    {
        $types = ['depot', 'retrait', 'virement'];
        $type = $this->faker->randomElement($types);
        $montant = $this->faker->numberBetween(1000, 100000);

        return [
            'compte_id' => \App\Models\Compte::factory(),
            'type' => $type,
            'montant' => $montant,
            'solde_avant' => $this->faker->numberBetween(0, 1000000),
            'solde_apres' => $this->faker->numberBetween(0, 1000000),
            'devise' => $this->faker->randomElement(['FCFA', 'XOF', 'USD', 'EUR']),
            'description' => $this->faker->sentence(),
            'compte_destination_id' => $type === 'virement' ? \App\Models\Compte::factory() : null,
        ];
    }

    /**
     * Indicate that the transaction is a deposit.
     */
    public function depot(): static
    {
        return $this->state(fn (array $attributes) => [
            'type' => 'depot',
            'compte_destination_id' => null,
        ]);
    }

    /**
     * Indicate that the transaction is a withdrawal.
     */
    public function retrait(): static
    {
        return $this->state(fn (array $attributes) => [
            'type' => 'retrait',
            'compte_destination_id' => null,
        ]);
    }

    /**
     * Indicate that the transaction is a transfer.
     */
    public function virement(): static
    {
        return $this->state(fn (array $attributes) => [
            'type' => 'virement',
            'compte_destination_id' => \App\Models\Compte::factory(),
        ]);
    }
}
