<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     title="Compte",
 *     description="Modèle de compte bancaire"
 * )
 */
class Compte {
    /**
     * @OA\Property(type="integer", example=1)
     */
    private $id;

    /**
     * @OA\Property(type="string", example="123456789")
     */
    private $numero;

    /**
     * @OA\Property(type="string", enum={"courant", "epargne"})
     */
    private $type;

    /**
     * @OA\Property(type="number", format="float", example=1000.00)
     */
    private $soldeInitial;

    /**
     * @OA\Property(type="number", format="float", example=1000.00)
     */
    private $solde;

    /**
     * @OA\Property(type="string", enum={"XOF", "EUR", "USD"})
     */
    private $devise;

    /**
     * @OA\Property(type="string", enum={"actif", "inactif", "bloque", "archive"})
     */
    private $statut;

    /**
     * @OA\Property(type="integer", example=1)
     */
    private $client_id;
}

/**
 * @OA\Schema(
 *     title="CompteResponse",
 *     description="Réponse API pour les comptes"
 * )
 */
class CompteResponse {
    /**
     * @OA\Property(type="boolean", example=true)
     */
    private $success;

    /**
     * @OA\Property(type="string", example="Opération réussie")
     */
    private $message;

    /**
     * @OA\Property(ref="#/components/schemas/Compte")
     */
    private $data;
}

/**
 * @OA\Schema(
 *     title="Pagination",
 *     description="Informations de pagination"
 * )
 */
class Pagination {
    /**
     * @OA\Property(type="integer", example=1)
     */
    private $currentPage;

    /**
     * @OA\Property(type="integer", example=10)
     */
    private $totalPages;

    /**
     * @OA\Property(type="integer", example=100)
     */
    private $totalItems;

    /**
     * @OA\Property(type="integer", example=10)
     */
    private $itemsPerPage;

    /**
     * @OA\Property(type="boolean", example=true)
     */
    private $hasNext;

    /**
     * @OA\Property(type="boolean", example=false)
     */
    private $hasPrevious;
}

/**
 * @OA\SecurityScheme(
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="JWT",
 *     securityScheme="bearerAuth"
 * )
 */