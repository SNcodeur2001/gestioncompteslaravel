<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::get('/', function () {
    // Redirection vers la documentation API
    if (config('app.env') === 'production') {
        return redirect('/docs');
    }

    // Page d'accueil en local
    return view('welcome');
});

// Route de login factice pour éviter l'erreur "Route [login] not defined"
Route::get('/login', function () {
    return response()->json(['message' => 'Login not implemented - use API authentication']);
})->name('login');
