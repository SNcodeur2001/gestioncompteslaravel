<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     title="Compte",
 *     description="Modèle de compte bancaire",
 *     @OA\Property(property="id", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440001"),
 *     @OA\Property(property="numero", type="string", example="COMP-123456"),
 *     @OA\Property(property="type", type="string", enum={"epargne", "cheque", "courant"}, example="cheque"),
 *     @OA\Property(property="soldeInitial", type="number", format="double", example=50000),
 *     @OA\Property(property="solde", type="number", format="double", example=45000),
 *     @OA\Property(property="devise", type="string", enum={"XOF", "FCFA", "USD", "EUR"}, example="XOF"),
 *     @OA\Property(property="statut", type="string", enum={"actif", "bloque", "ferme"}, example="actif"),
 *     @OA\Property(property="client_id", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440000"),
 *     @OA\Property(property="archived", type="boolean", example=false),
 *     @OA\Property(property="motifBlocage", type="string", nullable=true, example=null),
 *     @OA\Property(property="created_at", type="string", format="date-time"),
 *     @OA\Property(property="updated_at", type="string", format="date-time"),
 *     @OA\Property(
 *         property="client",
 *         ref="#/components/schemas/Client"
 *     )
 * )
 */
class Compte {}