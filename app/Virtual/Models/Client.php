<?php

namespace App\Virtual\Models;

/**
 * @OA\Schema(
 *     title="Client",
 *     description="Modèle de client",
 *     @OA\Property(property="id", type="string", format="uuid", example="550e8400-e29b-41d4-a716-446655440000"),
 *     @OA\Property(property="titulaire", type="string", example="Mamadou Diop"),
 *     @OA\Property(property="nci", type="string", pattern="^[12]\\d{12}$", example="1234567890123"),
 *     @OA\Property(property="email", type="string", format="email", example="mamadou.diop@email.com"),
 *     @OA\Property(property="telephone", type="string", pattern="^\\+221[0-9]{9}$", example="+221776543210"),
 *     @OA\Property(property="adresse", type="string", example="123 Rue Kermel, Plateau, Dakar"),
 *     @OA\Property(property="created_at", type="string", format="date-time"),
 *     @OA\Property(property="updated_at", type="string", format="date-time")
 * )
 */
class Client {}