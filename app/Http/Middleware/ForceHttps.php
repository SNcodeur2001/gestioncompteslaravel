<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\App;

class ForceHttps
{
    public function handle(Request $request, Closure $next)
    {
        if (App::environment('production')) {
            // Force HTTPS on all assets
            if (!$request->secure()) {
                return redirect()->secure($request->getRequestUri());
            }

            $response = $next($request);

            // Force HTTPS on all assets
            if ($response->headers->has('Location')) {
                $response->headers->set('Location', str_replace('http://', 'https://', $response->headers->get('Location')));
            }

            // Set security headers
            $response->headers->set('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
            return $response;
        }

        return $next($request);
    }
}