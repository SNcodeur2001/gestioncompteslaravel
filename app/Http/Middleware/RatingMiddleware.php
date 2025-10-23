<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class RatingMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Enregistrer l'utilisateur qui a atteint le rating limit
        if ($request->hasHeader('X-Rate-Limit-Remaining') && $request->header('X-Rate-Limit-Remaining') === '0') {
            $user = $request->user();
            if ($user) {
                Log::warning('Utilisateur a atteint la limite de taux', [
                    'user_id' => $user->id,
                    'email' => $user->email,
                    'ip' => $request->ip(),
                    'user_agent' => $request->userAgent(),
                    'route' => $request->route() ? $request->route()->getName() : 'unknown',
                    'timestamp' => now()->toISOString(),
                ]);
            }
        }

        return $next($request);
    }
}
