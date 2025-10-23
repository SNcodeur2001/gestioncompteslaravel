<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class ForceHttps
{
    public function handle(Request $request, Closure $next)
    {
        // Ne pas rediriger la documentation Swagger, les endpoints API, ni la route racine
        if ($request->is('api/documentation*') || $request->is('docs/*') || $request->is('api/v1/*') || $request->is('/')) {
            return $next($request);
        }

        if (!$request->secure() && app()->environment('production')) {
            return redirect()->secure($request->getRequestUri());
        }

        return $next($request);
    }
}
