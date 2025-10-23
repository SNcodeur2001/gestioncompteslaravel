<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     schema="Compte",
 *     title="Compte",
 *     description="Modèle représentant un compte bancaire",
 *     @OA\Property(property="id", type="string", format="uuid", example="458d13a0-2a2d-4982-a426-1a5b297cdfbc"),
 *     @OA\Property(property="client_id", type="string", format="uuid", example="02e979b7-df6e-4278-800a-580557e9d20c"),
 *     @OA\Property(property="numero", type="string", example="COMP-318580"),
 *     @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}, example="epargne"),
 *     @OA\Property(property="soldeInitial", type="number", format="float", example=448334.00),
 *     @OA\Property(property="solde", type="number", format="float", example=499410.00),
 *     @OA\Property(property="devise", type="string", example="FCFA"),
 *     @OA\Property(property="created_at", type="string", format="date-time", example="2025-10-23T14:46:42.000000Z"),
 *     @OA\Property(property="updated_at", type="string", format="date-time", example="2025-10-23T14:46:42.000000Z"),
 *     @OA\Property(property="statut", type="string", enum={"actif", "bloque", "ferme"}, example="actif"),
 *     @OA\Property(property="motifBlocage", type="string", nullable=true, example=null),
 *     @OA\Property(property="deleted_at", type="string", format="date-time", nullable=true, example=null),
 *     @OA\Property(property="archived", type="boolean", example=false),
 *     @OA\Property(property="client", ref="#/components/schemas/Client")
 * )
 */
class CompteSchema
{
}

/**
 * @OA\Schema(
 *     schema="Client",
 *     title="Client",
 *     description="Modèle représentant un client bancaire",
 *     @OA\Property(property="id", type="string", format="uuid", example="02e979b7-df6e-4278-800a-580557e9d20c"),
 *     @OA\Property(property="titulaire", type="string", example="Kip Lowe"),
 *     @OA\Property(property="nci", type="string", example="2635726367683"),
 *     @OA\Property(property="email", type="string", format="email", example="greg.casper@example.com"),
 *     @OA\Property(property="telephone", type="string", example="74210088"),
 *     @OA\Property(property="adresse", type="string", example="5198 Reichel Throughway\nPort Electa, PA 89423"),
 *     @OA\Property(property="dateCreation", type="string", format="date-time", example="2025-10-23T14:46:42.000000Z")
 * )
 */
class ClientSchema
{
}