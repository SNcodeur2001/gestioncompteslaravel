<?php

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
Route::get('/health', function() {
    return response()->json(['status' => 'ok']);
});

// API routes (prefix v1/ndiaye.mapathe already applied in RouteServiceProvider)
Route::middleware(['fake.auth', 'rating', 'logging'])->group(function () {
    /**
     * Lister tous les comptes
     * Admin peut récupérer la liste de tous les comptes
     * Client peut récupérer la liste de ses comptes
     * Liste compte non supprimés type cheque ou compte Epargne Actif
     */
    Route::get('comptes', [CompteController::class, 'index'])->name('comptes.index');

    /**
     * Récupérer un compte spécifique par ID
     * Admin peut récupérer n'importe quel compte
     * Client peut récupérer un de ses comptes
     * Recherche locale par défaut, puis serverless si non trouvé
     */
    Route::get('comptes/{compteId}', [CompteController::class, 'show'])->name('comptes.show');

    /**
     * Mettre à jour les informations du client d'un compte
     * Admin peut modifier n'importe quel compte
     * Tous les champs sont optionnels mais au moins un doit être fourni
     */
    Route::patch('comptes/{compteId}', [CompteController::class, 'update'])->name('comptes.update');

    /**
     * Créer un nouveau compte
     */
    Route::post('comptes', [CompteController::class, 'store'])->name('comptes.store');

    /**
     * Supprimer un compte (soft delete)
     * Admin peut supprimer n'importe quel compte
     * Le compte passe au statut 'ferme' avec dateFermeture
     */
    Route::delete('comptes/{compteId}', [CompteController::class, 'destroy'])->name('comptes.destroy');
});

// Client-specific routes
Route::middleware(['fake.auth', 'rating'])->group(function () {
    Route::get('clients/{client}/comptes', [CompteController::class, 'clientComptes']);
    Route::get('clients/{client}/comptes/{compte}', [CompteController::class, 'clientCompte']);
});

// Archived comptes routes
Route::middleware(['fake.auth', 'rating'])->group(function () {
    /**
     * Lister tous les comptes archivés
     * La consultation de compte Epargne archiver se fait a partir du cloud
     */
    Route::get('comptes/archives', [CompteArchiveController::class, 'index'])->name('comptes.archives');
});

// Health check route (sans middleware pour les tests)
Route::get('/health', function() {
    return response()->json(['status' => 'ok']);
});
