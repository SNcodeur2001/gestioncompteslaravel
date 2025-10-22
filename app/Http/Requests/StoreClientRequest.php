<?php

namespace App\Http\Requests;

use Illuminate\Foundation\Http\FormRequest;

class StoreClientRequest extends FormRequest
{
    public function authorize(): bool
    {
        return true;
    }

    public function rules(): array
    {
        return [
            'titulaire' => 'required|string|max:255',
            'nci' => [
                'required',
                'string',
                'size:13', // exactement 13 caractères
                'unique:clients,nci',
                'regex:/^[0-9]{13}$/' // uniquement des chiffres
            ],
            'email' => 'required|email|unique:clients,email',
            'telephone' => [
                'nullable',
                'string',
                'regex:/^(?:\+221|00221|0)?7[05678][0-9]{6}$/' // regex adaptée au Sénégal
            ],
            'adresse' => 'nullable|string|max:500',
        ];
    }
}
