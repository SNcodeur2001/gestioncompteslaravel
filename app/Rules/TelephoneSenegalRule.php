<?php

namespace App\Rules;

use Closure;
use Illuminate\Contracts\Validation\ValidationRule;

class TelephoneSenegalRule implements ValidationRule
{
    /**
     * Run the validation rule.
     *
     * @param  \Closure(string): \Illuminate\Translation\PotentiallyTranslatedString  $fail
     */
    public function validate(string $attribute, mixed $value, Closure $fail): void
    {
        // Vérifier que c'est une chaîne numérique
        if (!is_string($value) || !is_numeric($value)) {
            $fail('Le numéro de téléphone doit être une chaîne numérique.');
            return;
        }

        // Longueur entre 9 et 12 chiffres
        if (strlen($value) < 9 || strlen($value) > 12) {
            $fail('Le numéro de téléphone doit contenir entre 9 et 12 chiffres.');
            return;
        }

        // Préfixes valides pour le Sénégal
        $validPrefixes = ['70', '76', '77', '78', '33', '75', '76', '77', '78', '79', '81', '82', '83', '84', '85', '86', '87', '88', '89'];

        $prefix = substr($value, 0, 2);
        if (!in_array($prefix, $validPrefixes)) {
            $fail('Le préfixe du numéro de téléphone n\'est pas valide pour le Sénégal.');
            return;
        }
    }
}
