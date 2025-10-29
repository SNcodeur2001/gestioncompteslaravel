<?php

namespace Database\Seeders;

use App\Models\User;
use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Illuminate\Support\Facades\Hash;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Check if admin user exists, if not create it
        if (!User::where('email', 'admin@gestioncomptes.com')->exists()) {
            User::create([
                'name' => 'Admin User',
                'email' => 'admin@gestioncomptes.com',
                'password' => Hash::make('password'),
                'role' => 'admin',
                'client_id' => null,
            ]);
        }

        // Check if client user exists, if not create it
        if (!User::where('email', 'client@gestioncomptes.com')->exists()) {
            // Get first client for the client user
            $firstClient = \App\Models\Client::first();
            if ($firstClient) {
                User::create([
                    'name' => 'Client User',
                    'email' => 'client@gestioncomptes.com',
                    'password' => Hash::make('password'),
                    'role' => 'client',
                    'client_id' => $firstClient->id,
                ]);
            }
        }
    }
}
