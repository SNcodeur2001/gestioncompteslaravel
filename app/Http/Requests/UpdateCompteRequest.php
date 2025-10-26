<?php

namespace App\Http\Requests;

use App\Rules\NciSenegalRule;
use App\Rules\PhoneSenegalRule;
use Illuminate\Foundation\Http\FormRequest;

class UpdateCompteRequest extends FormRequest
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
            'titulaire' => ['sometimes', 'string', 'min:2', 'max:255'],
            'informationsClient' => ['sometimes', 'array'],
            'informationsClient.telephone' => ['sometimes', 'string', new PhoneSenegalRule(), 'unique:clients,telephone,' . $this->route('compteId') . ',id'],
            'informationsClient.email' => ['sometimes', 'email', 'unique:clients,email,' . $this->route('compteId') . ',id'],
            'informationsClient.password' => ['sometimes', 'string', 'min:8'],
            'informationsClient.nci' => ['sometimes', 'string', new NciSenegalRule(), 'unique:clients,nci,' . $this->route('compteId') . ',id'],
        ];
    }

    /**
     * Configure the validator instance.
     */
    public function withValidator($validator)
    {
        $validator->after(function ($validator) {
            // Vérifier qu'au moins un champ est fourni
            $hasTitulaire = $this->has('titulaire');
            $hasClientInfo = $this->has('informationsClient') &&
                           (!empty($this->input('informationsClient.telephone')) ||
                            !empty($this->input('informationsClient.email')) ||
                            !empty($this->input('informationsClient.password')) ||
                            !empty($this->input('informationsClient.nci')));

            if (!$hasTitulaire && !$hasClientInfo) {
                $validator->errors()->add('general', 'Au moins un champ de modification doit être fourni.');
            }
        });
    }

    public function messages(): array
    {
        return [
            'titulaire.string' => 'Le nom du titulaire doit être une chaîne de caractères.',
            'titulaire.min' => 'Le nom du titulaire doit contenir au moins 2 caractères.',
            'titulaire.max' => 'Le nom du titulaire ne peut pas dépasser 255 caractères.',
            'informationsClient.telephone.unique' => 'Ce numéro de téléphone est déjà utilisé.',
            'informationsClient.email.email' => 'L\'adresse email n\'est pas valide.',
            'informationsClient.email.unique' => 'Cette adresse email est déjà utilisée.',
            'informationsClient.password.min' => 'Le mot de passe doit contenir au moins 8 caractères.',
            'informationsClient.nci.unique' => 'Ce numéro de carte d\'identité est déjà utilisé.',
            'general' => 'Au moins un champ de modification doit être fourni.',
        ];
    }
}