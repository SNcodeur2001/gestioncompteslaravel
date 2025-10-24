<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     title="Client",
 *     description="Modèle de client",
 *     @OA\Property(property="id", type="integer", example=1),
 *     @OA\Property(property="titulaire", type="string", example="John Doe"),
 *     @OA\Property(property="nci", type="string", example="1234567890123"),
 *     @OA\Property(property="email", type="string", format="email", example="john@example.com"),
 *     @OA\Property(property="telephone", type="string", example="221776543210"),
 *     @OA\Property(property="adresse", type="string", example="123 Rue Principale, Dakar"),
 *     @OA\Property(property="created_at", type="string", format="date-time"),
 *     @OA\Property(property="updated_at", type="string", format="date-time")
 * )
 */
class Client {}