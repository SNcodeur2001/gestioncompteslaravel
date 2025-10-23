<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;
use Faker\Factory as Faker;

class TransactionSeeder extends Seeder
{
    protected $faker;

    public function __construct()
    {
        $this->faker = Faker::create('fr_FR');
    }

    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        // Créer des transactions pour les comptes existants
        $comptes = \App\Models\Compte::all();

        if ($comptes->isEmpty()) {
            // Si pas de comptes, créer d'abord des clients et comptes
            \App\Models\Client::factory(5)->create()->each(function ($client) {
                $client->comptes()->createMany(
                    \App\Models\Compte::factory(2)->make()->toArray()
                );
            });
            $comptes = \App\Models\Compte::all();
        }

        // Créer des transactions pour chaque compte
        foreach ($comptes as $compte) {
            // Créer 5-15 transactions par compte
            $nombreTransactions = rand(5, 15);

            for ($i = 0; $i < $nombreTransactions; $i++) {
                $type = $this->faker->randomElement(['depot', 'retrait', 'virement']);
                $montant = $this->faker->numberBetween(1000, 50000);

                // Calculer les soldes avant/après (logique simplifiée)
                $soldeAvant = $compte->solde;
                $soldeApres = $type === 'depot' ? $soldeAvant + $montant : $soldeAvant - $montant;

                $transactionData = [
                    'compte_id' => $compte->id,
                    'type' => $type,
                    'montant' => $montant,
                    'solde_avant' => $soldeAvant,
                    'solde_apres' => max(0, $soldeApres), // Éviter solde négatif dans les seeds
                    'devise' => $compte->devise,
                    'description' => $this->generateDescription($type),
                    'created_at' => $this->faker->dateTimeBetween('-6 months', 'now'),
                ];

                // Ajouter compte destination pour les virements
                if ($type === 'virement') {
                    $compteDestination = \App\Models\Compte::where('id', '!=', $compte->id)->inRandomOrder()->first();
                    if ($compteDestination) {
                        $transactionData['compte_destination_id'] = $compteDestination->id;
                    }
                }

                \App\Models\Transaction::create($transactionData);
            }
        }
    }

    /**
     * Générer une description appropriée selon le type de transaction
     */
    private function generateDescription(string $type): string
    {
        $descriptions = [
            'depot' => [
                'Dépôt d\'espèces',
                'Virement bancaire entrant',
                'Dépôt chèque',
                'Versement salaire',
                'Dépôt espèces guichet'
            ],
            'retrait' => [
                'Retrait d\'espèces',
                'Paiement par carte',
                'Retrait DAB',
                'Retrait guichet',
                'Prélèvement automatique'
            ],
            'virement' => [
                'Virement vers compte',
                'Transfert bancaire',
                'Paiement facture',
                'Virement salaire',
                'Transfert entre comptes'
            ]
        ];

        return $this->faker->randomElement($descriptions[$type]);
    }
}
