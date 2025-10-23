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
        return [
            'id' => $this->id,
            'client_id' => $this->client_id,
            'numero' => $this->numero,
            'type' => $this->type,
            'soldeInitial' => $this->soldeInitial,
            'solde' => $this->solde,
            'devise' => $this->devise,
            'created_at' => $this->created_at?->toISOString(),
            'updated_at' => $this->updated_at?->toISOString(),
            'statut' => $this->statut,
            'motifBlocage' => $this->motifBlocage,
            'deleted_at' => $this->deleted_at?->toISOString(),
            'archived' => $this->archived,
            'client' => $this->whenLoaded('client', function () {
                return $this->client;
            }),
        ];
    }
}
