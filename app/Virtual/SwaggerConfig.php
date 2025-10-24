<?php

namespace App\Virtual;

/**
 * @OA\Info(
 *     version="1.0.0",
 *     title="API Bancaire - Gestion des Comptes",
 *     description="Documentation de l'API de Gestion des Comptes",
 *     @OA\Contact(
 *         email="contact@gestioncomptes.com"
 *     )
 * )
 * @OA\Server(
 *     description="API Server",
 *     url="https://gestioncompteslaravel.onrender.com"
 )
 * @OA\Server(
 *     description="Local Development",
 *     url="http://localhost:8000"
 )
 * @OA\SecurityScheme(
 *     securityScheme="bearerAuth",
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="JWT"
 )
 */
class SwaggerConfig {}