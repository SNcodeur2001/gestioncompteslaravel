<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     title="Compte",
 *     description="Modèle de compte bancaire",
 *     @OA\Property(property="id", type="integer", example=1),
 *     @OA\Property(property="numero", type="string", example="CPT123456789"),
 *     @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}),
 *     @OA\Property(property="soldeInitial", type="number", format="double", example=1000.00),
 *     @OA\Property(property="solde", type="number", format="double", example=1000.00),
 *     @OA\Property(property="devise", type="string", example="XOF"),
 *     @OA\Property(property="statut", type="string", enum={"actif", "bloque", "ferme"}),
 *     @OA\Property(property="client_id", type="integer", example=1),
 *     @OA\Property(property="created_at", type="string", format="date-time"),
 *     @OA\Property(property="updated_at", type="string", format="date-time"),
 *     @OA\Property(
 *         property="client",
 *         ref="#/components/schemas/Client"
 *     )
 * )
 */
class Compte {}