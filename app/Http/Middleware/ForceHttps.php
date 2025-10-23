<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class ForceHttps
{
    public function handle(Request $request, Closure $next)
    {
        if (!$request->secure() && app()->environment('production')) {
            // Ne pas rediriger les requêtes API
            if ($request->is('api/*')) {
                return $next($request);
            }
            return redirect()->secure($request->getRequestUri());
        }

        return $next($request);
    }
}