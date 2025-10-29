<?php

namespace App\Http\Resources;

use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

class CompteResource extends JsonResource
{
    /**
     * Transform the resource into an array.
     *
     * @return array<string, mixed>
     */
    public function toArray(Request $request): array
    {
        $data = [
            'id' => $this->id,
            'client_id' => $this->client_id,
            'numero' => $this->numero,
            'titulaire' => $this->client?->titulaire,
            'type' => $this->type,
            'solde' => $this->calculated_solde, // Use calculated solde
            'devise' => $this->devise,
            'dateCreation' => $this->created_at?->toISOString(),
            'statut' => $this->statut,
            'motifBlocage' => $this->motifBlocage,
            'metadata' => [
                'derniereModification' => $this->updated_at?->toISOString(),
                'version' => 1
            ]
        ];

        // Afficher les dates de blocage seulement pour les comptes épargne
        if ($this->type === 'epargne') {
            $data['dateDebutBlocage'] = $this->dateDebutBlocage ? \Carbon\Carbon::parse($this->dateDebutBlocage)->toISOString() : null;
            $data['dateFinBlocage'] = $this->dateFinBlocage ? \Carbon\Carbon::parse($this->dateFinBlocage)->toISOString() : null;
        }

        return $data;
    }
}
