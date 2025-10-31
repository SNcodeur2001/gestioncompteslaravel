<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class ForceHttps
{
    public function handle(Request $request, Closure $next)
    {
        // Ne pas rediriger TOUTES les routes API (y compris les sous-routes comme api/v1/ndiaye.mapathe/*)
        if (str_starts_with($request->getPathInfo(), '/api/') || $request->is('docs*') || $request->is('/')) {
            return $next($request);
        }

        // En production, vérifier si la requête vient déjà d'un domaine HTTPS
        if (app()->environment('production')) {
            $host = $request->getHost();
            // Si c'est déjà un domaine HTTPS (render.com), ne pas rediriger
            if (str_contains($host, 'onrender.com') || $request->secure()) {
                return $next($request);
            }
            // Sinon, rediriger vers HTTPS seulement si nécessaire
            if (!$request->secure()) {
                return redirect()->secure($request->getRequestUri());
            }
        }

        return $next($request);
    }
}
