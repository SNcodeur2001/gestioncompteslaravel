<?php


namespace Database\Seeders;

use Illuminate\Database\Seeder;
use App\Models\Client;

class ClientSeeder extends Seeder
{
    public function run(): void
    {
        // Crée 50 clients avec la factory
        Client::factory(50)->create();
    }
}
