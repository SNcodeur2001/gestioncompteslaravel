<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Symfony\Component\HttpFoundation\Response;

class RoleMiddleware
{
    /**
     * Handle an incoming request.
     * Qui récupère les permissions de l'utilisateur connecté
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next, string $role): Response
    {
        // Check if using fake auth (for testing)
        $user = $request->attributes->get('user');

        if (!$user) {
            $user = Auth::user();
        }

        if (!$user) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'UNAUTHENTICATED',
                    'message' => 'Utilisateur non authentifié',
                    'details' => [
                        'message' => 'Vous devez être connecté pour accéder à cette ressource'
                    ]
                ]
            ], 401);
        }

        if ($user->role !== $role) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'FORBIDDEN',
                    'message' => 'Accès refusé',
                    'details' => [
                        'message' => 'Vous n\'avez pas les permissions nécessaires pour accéder à cette ressource',
                        'required_role' => $role,
                        'user_role' => $user->role
                    ]
                ]
            ], 403);
        }

        // Add user role to request attributes for easy access
        $request->merge(['user_role' => $user->role]);

        return $next($request);
    }
}
