<?php

namespace App\Virtual;

/**
 * @OA\Schema(
 *     schema="LoginRequest",
 *     title="Login Request",
 *     description="Requête de connexion",
 *     @OA\Property(property="email", type="string", format="email", example="admin@gestioncomptes.com"),
 *     @OA\Property(property="password", type="string", example="password")
 * )
 *
 * @OA\Schema(
 *     schema="RefreshTokenRequest",
 *     title="Refresh Token Request",
 *     description="Requête de rafraîchissement de token",
 *     @OA\Property(property="refresh_token", type="string", example="refresh_token_from_login_response")
 * )
 *
 * @OA\Schema(
 *     schema="CreateCompteRequest",
 *     title="Create Compte Request",
 *     description="Requête de création de compte",
 *     @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}, example="cheque"),
 *     @OA\Property(property="soldeInitial", type="number", example=50000),
 *     @OA\Property(property="solde", type="number", example=50000),
 *     @OA\Property(property="devise", type="string", enum={"XOF", "FCFA", "USD", "EUR"}, example="XOF"),
 *     @OA\Property(
 *         property="client",
 *         type="object",
 *         @OA\Property(property="titulaire", type="string", example="John Doe"),
 *         @OA\Property(property="nci", type="string", example="1234567890123"),
 *         @OA\Property(property="email", type="string", format="email", example="john@example.com"),
 *         @OA\Property(property="telephone", type="string", example="+221771234567"),
 *         @OA\Property(property="adresse", type="string", example="123 Rue Test, Dakar")
 *     )
 * )
 *
 * @OA\Schema(
 *     schema="UpdateCompteRequest",
 *     title="Update Compte Request",
 *     description="Requête de mise à jour des informations client du compte",
 *     @OA\Property(property="titulaire", type="string", example="John Doe Updated"),
 *     @OA\Property(
 *         property="informationsClient",
 *         type="object",
 *         @OA\Property(property="telephone", type="string", example="+221771234568"),
 *         @OA\Property(property="email", type="string", format="email", example="john.updated@example.com")
 *     )
 * )
 *
 * @OA\Schema(
 *     schema="BloquerCompteRequest",
 *     title="Bloquer Compte Request",
 *     description="Requête de blocage de compte",
 *     @OA\Property(property="motifBlocage", type="string", example="Suspicion de fraude"),
 *     @OA\Property(property="dateDebutBlocage", type="string", format="date", example="2025-10-30"),
 *     @OA\Property(property="dateFinBlocage", type="string", format="date", example="2025-11-30")
 * )
 */
class TestExamples {}