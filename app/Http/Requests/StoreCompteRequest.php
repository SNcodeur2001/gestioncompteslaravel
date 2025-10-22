<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreCompteRequest extends FormRequest
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
            'type' => ['required', 'in:cheque,courant,epagne'],
            'soldeInitial' => ['required', 'numeric', 'min:0'],
            'solde' => ['required', 'numeric', 'min:0'],
            'devise' => ['required', 'string'],
            'client.id' => ['nullable', 'exists:clients,id'],
            'client.titulaire' => ['required_if:client.id,null', 'string'],
            'client.nci' => ['required_if:client.id,null', 'string', 'size:13'], // modèle Sénégal
            'client.email' => ['required_if:client.id,null', 'email'],
            'client.telephone' => ['required_if:client.id,null', 'regex:/^\+221[0-9]{9}$/'],
            'client.adresse' => ['required_if:client.id,null', 'string'],
        ];
    }
}
