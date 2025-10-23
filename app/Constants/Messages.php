<?php

namespace App\Constants;

class Messages
{
    // Success messages
    const COMPTE_CREATED = 'Compte créé avec succès';
    const COMPTE_UPDATED = 'Compte mis à jour avec succès';
    const COMPTE_DELETED = 'Compte supprimé avec succès';

    // Error messages
    const COMPTE_NOT_FOUND = 'Compte non trouvé';
    const CLIENT_NOT_FOUND = 'Client non trouvé';
    const UNAUTHORIZED = 'Accès non autorisé';
    const VALIDATION_FAILED = 'Données de validation invalides';
    const INTERNAL_ERROR = 'Erreur interne du serveur';
    const CREATION_ERROR = 'Erreur lors de la création du compte';
    const UPDATE_ERROR = 'Erreur lors de la mise à jour du compte';
    const DELETE_ERROR = 'Erreur lors de la suppression du compte';

    // Pagination messages
    const NO_DATA = 'Aucune donnée trouvée';
}