<?php

namespace Database\Factories; 

use App\Models\Client;
use Illuminate\Database\Eloquent\Factories\Factory;

class ClientFactory extends Factory
{
    protected $model = Client::class;

    public function definition(): array
    {
        return [
            'titulaire' => $this->faker->name(),
            'nci' => $this->faker->unique()->numerify('#############'), // 13 chiffres
            'email' => $this->faker->unique()->safeEmail(),
            'telephone' => '7' . $this->faker->numerify('#######'), // numéro Sénégalais
            'adresse' => $this->faker->address(),
        ];
    }
}
