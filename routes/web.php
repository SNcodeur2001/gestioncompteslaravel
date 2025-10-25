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
        return redirect('api/v1/' . config('api.name') . '/documentation');
    }

    // Page d'accueil en local
    return view('welcome');
});
