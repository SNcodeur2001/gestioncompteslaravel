<?php

use App\Http\Controllers\ActivationController;
use App\Http\Controllers\CompteArchiveController;
use App\Http\Controllers\CompteController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});

// Health check route (sans middleware pour les tests)
/**
 * @OA\Get(
 *     path="/api/health",
 *     summary="Vérification de santé de l'API",
 *     description="Endpoint de vérification de santé pour les tests et monitoring",
 *     operationId="healthCheck",
 *     tags={"Santé"},
 *     @OA\Response(
 *         response=200,
 *         description="API opérationnelle",
 *         @OA\JsonContent(
 *             @OA\Property(property="status", type="string", example="ok")
 *         )
 *     )
 * )
 */
Route::get('/health', function() {
    return response()->json(['status' => 'ok']);
});

// Authentication routes
Route::prefix('auth')->group(function () {
    Route::post('login', [App\Http\Controllers\AuthController::class, 'login']);
    Route::post('refresh', [App\Http\Controllers\AuthController::class, 'refresh']);
    Route::middleware('auth:api')->post('logout', [App\Http\Controllers\AuthController::class, 'logout']);
});

// Activation routes (public routes for new clients)
Route::prefix('activation')->group(function () {
    /**
     * Activer un compte client avec le code OTP
     */
    Route::post('activate', [ActivationController::class, 'activate'])->name('activation.activate');

    /**
     * Renvoyer le code d'activation
     */
    Route::post('resend-code', [ActivationController::class, 'resendCode'])->name('activation.resend');
});


// API routes (prefix v1/ndiaye.mapathe already applied in RouteServiceProvider)
Route::middleware(['auth:api', 'logging'])->group(function () {
    /**
     * Lister tous les comptes
     * Utilisateur authentifié peut récupérer la liste de tous les comptes
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    Route::get('comptes', [CompteController::class, 'index'])->name('comptes.index');

    /**
     * Récupérer un compte spécifique par ID
     * Utilisateur authentifié peut récupérer n'importe quel compte
     * Recherche locale par défaut, puis serverless si non trouvé
     */
    Route::get('comptes/{compteId}', [CompteController::class, 'show'])->name('comptes.show');

    /**
     * Mettre à jour les informations du client d'un compte
     * Utilisateur authentifié peut modifier n'importe quel compte
     * Tous les champs sont optionnels mais au moins un doit être fourni
     */
    Route::patch('comptes/{compteId}', [CompteController::class, 'update'])->name('comptes.update');

    /**
     * Créer un nouveau compte
     */
    Route::post('comptes', [CompteController::class, 'store'])->name('comptes.store');

    /**
     * Supprimer un compte (soft delete)
     * Utilisateur authentifié peut supprimer n'importe quel compte
     * Le compte passe au statut 'ferme' avec dateFermeture
     */
    Route::delete('comptes/{compteId}', [CompteController::class, 'destroy'])->name('comptes.destroy');
});

// Client-specific routes (Authenticated users can access their own accounts)
Route::middleware(['auth:api', 'logging'])->group(function () {
    Route::get('clients/{client}/comptes', [CompteController::class, 'clientComptes']);
    Route::get('clients/{client}/comptes/{compte}', [CompteController::class, 'clientCompte']);
});

// Archived comptes routes
Route::middleware(['auth:api', 'logging'])->group(function () {
    /**
     * Lister tous les comptes archivés
     * La consultation de compte Epargne archiver se fait a partir du cloud
     */
    Route::get('comptes/archives', [CompteArchiveController::class, 'index'])->name('comptes.archives');
});

// Account blocking/unblocking routes
Route::middleware(['auth:api', 'logging'])->group(function () {
    /**
     * Bloquer un compte
     * Prépare le compte pour archivage automatique
     */
    Route::post('comptes/{compteId}/bloquer', [CompteController::class, 'bloquer'])->name('comptes.bloquer');

    /**
     * Débloquer un compte
     * Annule le blocage et l'archivage automatique
     */
    Route::post('comptes/{compteId}/debloquer', [CompteController::class, 'debloquer'])->name('comptes.debloquer');
});

// Health check route (sans middleware pour les tests)
Route::get('/health', function() {
    return response()->json(['status' => 'ok']);
});
