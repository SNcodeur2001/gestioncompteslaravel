<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;

class SwaggerSecurityHeaders
{
    /**
     * Handle an incoming request.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  \Closure  $next
     * @return mixed
     */
    public function handle(Request $request, Closure $next)
    {
        $response = $next($request);

        // CSP plus permissive pour Swagger UI en développement et production
        $csp = "default-src 'self' http: https:; " .
                "script-src 'self' 'unsafe-inline' 'unsafe-eval' http: https: cdn.jsdelivr.net unpkg.com; " .
                "style-src 'self' 'unsafe-inline' http: https: fonts.googleapis.com cdn.jsdelivr.net unpkg.com; " .
                "img-src 'self' http: https: data: cdn.jsdelivr.net unpkg.com; " .
                "font-src 'self' http: https: fonts.gstatic.com cdn.jsdelivr.net unpkg.com data:; " .
                "connect-src 'self' http: https: ws: wss: *; " .
                "frame-ancestors 'none';";

        $response->headers->set('Content-Security-Policy', $csp);
        $response->headers->set('X-Content-Type-Options', 'nosniff');
        $response->headers->set('X-Frame-Options', 'SAMEORIGIN');
        $response->headers->set('X-XSS-Protection', '1; mode=block');

        // Ne pas forcer HSTS en développement local
        if (config('app.env') === 'production') {
            $response->headers->set('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
        }

        return $response;
    }
}