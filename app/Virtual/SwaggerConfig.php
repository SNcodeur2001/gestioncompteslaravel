<?php

namespace App\Virtual;

/**
 * @OA\Info(
 *     version="1.0.0",
 *     title="API Bancaire - Gestion des Comptes",
 *     description="Documentation complète de l'API de Gestion des Comptes avec exemples de test. Utilisez les credentials suivants pour tester : Admin (admin@gestioncomptes.com / password) ou Client (client@gestioncomptes.com / password)",
 *     @OA\Contact(
 *         email="contact@gestioncomptes.com"
 *     )
 * )
 * @OA\Server(
 *     description="Production Server",
 *     url="https://gestioncompteslaravel.onrender.com"
 * )
 * @OA\Server(
 *     description="Local Development",
 *     url="http://localhost:8000/api/v1/ndiaye.mapathe"
 * )
 * @OA\SecurityScheme(
 *     securityScheme="bearerAuth",
 *     type="http",
 *     scheme="bearer",
 *     bearerFormat="JWT",
 *     description="Entrez le token JWT obtenu via /api/auth/login. Utilisez les credentials de test : admin@gestioncomptes.com / password"
 * )
 */
class SwaggerConfig {}