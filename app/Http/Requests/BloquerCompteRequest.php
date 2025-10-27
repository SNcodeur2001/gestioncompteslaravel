<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class BloquerCompteRequest extends FormRequest
{
    /**
     * Determine if the user is authorized to make this request.
     */
    public function authorize(): bool
    {
        return true;
    }

    /**
     * Get the validation rules that apply to the request.
     *
     * @return array<string, \Illuminate\Contracts\Validation\ValidationRule|array<mixed>|string>
     */
    public function rules(): array
    {
        return [
            'motifBlocage' => ['required', 'string', 'min:5', 'max:500'],
            'dateDebutBlocage' => ['required', 'date', 'after:now'],
            'dateFinBlocage' => ['required', 'date', 'after:dateDebutBlocage'],
        ];
    }

    public function messages(): array
    {
        return [
            'motifBlocage.required' => 'Le motif de blocage est obligatoire.',
            'motifBlocage.string' => 'Le motif de blocage doit être une chaîne de caractères.',
            'motifBlocage.min' => 'Le motif de blocage doit contenir au moins 5 caractères.',
            'motifBlocage.max' => 'Le motif de blocage ne peut pas dépasser 500 caractères.',
            'dateDebutBlocage.required' => 'La date de début de blocage est obligatoire.',
            'dateDebutBlocage.date' => 'La date de début de blocage n\'est pas valide.',
            'dateDebutBlocage.after' => 'La date de début de blocage doit être dans le futur.',
            'dateFinBlocage.required' => 'La date de fin de blocage est obligatoire.',
            'dateFinBlocage.date' => 'La date de fin de blocage n\'est pas valide.',
            'dateFinBlocage.after' => 'La date de fin de blocage doit être après la date de début.',
        ];
    }
}