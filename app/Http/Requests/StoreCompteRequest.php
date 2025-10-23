<?php

namespace App\Http\Requests;

use App\Rules\NciSenegalRule;
use App\Rules\PhoneSenegalRule;
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
            'type' => ['required', 'in:cheque,courant,epargne'],
            'soldeInitial' => ['required', 'numeric', 'min:10000'],
            'solde' => ['required', 'numeric', 'min:0'],
            'devise' => ['required', 'string', 'in:FCFA,XOF,USD,EUR'],
            'client.id' => ['nullable', 'exists:clients,id'],
            'client.titulaire' => ['required_if:client.id,null', 'string', 'min:2', 'max:255'],
            'client.nci' => ['required_if:client.id,null', 'string', new NciSenegalRule(), 'unique:clients,nci'],
            'client.email' => ['required_if:client.id,null', 'email', 'unique:clients,email'],
            'client.telephone' => ['required_if:client.id,null', 'string', new PhoneSenegalRule(), 'unique:clients,telephone'],
            'client.adresse' => ['required_if:client.id,null', 'string', 'min:5', 'max:500'],
        ];
    }

    public function messages(): array
    {
        return [
            'type.required' => 'Le type de compte est obligatoire.',
            'type.in' => 'Le type de compte doit être : cheque, courant ou epargne.',
            'soldeInitial.required' => 'Le solde initial est obligatoire.',
            'soldeInitial.numeric' => 'Le solde initial doit être un nombre.',
            'soldeInitial.min' => 'Le solde initial doit être d\'au moins 10 000 FCFA.',
            'solde.required' => 'Le solde est obligatoire.',
            'solde.numeric' => 'Le solde doit être un nombre.',
            'solde.min' => 'Le solde ne peut pas être négatif.',
            'devise.required' => 'La devise est obligatoire.',
            'devise.in' => 'La devise doit être : FCFA, XOF, USD ou EUR.',
            'client.id.exists' => 'Le client sélectionné n\'existe pas.',
            'client.titulaire.required_if' => 'Le nom du titulaire est obligatoire.',
            'client.titulaire.min' => 'Le nom du titulaire doit contenir au moins 2 caractères.',
            'client.titulaire.max' => 'Le nom du titulaire ne peut pas dépasser 255 caractères.',
            'client.nci.required_if' => 'Le numéro de carte d\'identité est obligatoire.',
            'client.nci.unique' => 'Ce numéro de carte d\'identité est déjà utilisé.',
            'client.email.required_if' => 'L\'adresse email est obligatoire.',
            'client.email.email' => 'L\'adresse email n\'est pas valide.',
            'client.email.unique' => 'Cette adresse email est déjà utilisée.',
            'client.telephone.required_if' => 'Le numéro de téléphone est obligatoire.',
            'client.telephone.unique' => 'Ce numéro de téléphone est déjà utilisé.',
            'client.adresse.required_if' => 'L\'adresse est obligatoire.',
            'client.adresse.min' => 'L\'adresse doit contenir au moins 5 caractères.',
            'client.adresse.max' => 'L\'adresse ne peut pas dépasser 500 caractères.',
        ];
    }
}
