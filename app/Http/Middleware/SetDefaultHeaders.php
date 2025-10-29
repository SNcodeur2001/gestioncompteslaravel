<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SetDefaultHeaders
{
    public function handle(Request $request, Closure $next)
    {
        // Middleware pour les headers par défaut - plus de logique X-Role
        return $next($request);
    }
}