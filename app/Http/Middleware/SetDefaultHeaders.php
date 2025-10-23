<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SetDefaultHeaders
{
    public function handle(Request $request, Closure $next)
    {
        // Si nous sommes sur Render et que le header X-Role n'est pas défini
        if (app()->environment('production') && !$request->headers->has('X-Role')) {
            $request->headers->set('X-Role', 'admin');
        }

        return $next($request);
    }
}