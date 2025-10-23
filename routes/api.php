<?php

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

// Version 1 API routes
Route::prefix('v1')->group(function () {
    Route::apiResource('comptes', CompteController::class)->only(['index', 'store', 'show']);
});

// Client-specific routes
Route::prefix('v1')->group(function () {
    Route::get('clients/{client}/comptes', [CompteController::class, 'clientComptes']);
    Route::get('clients/{client}/comptes/{compte}', [CompteController::class, 'clientCompte']);
});
