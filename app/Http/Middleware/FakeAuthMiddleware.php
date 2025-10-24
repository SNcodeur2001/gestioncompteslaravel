<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Symfony\Component\HttpFoundation\Response;

class FakeAuthMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        // Simuler un utilisateur en fonction du header X-Role
        $role = $request->header('X-Role', 'client'); // Par défaut client

        if ($role === 'admin') {
            $user = (object) [
                'id' => 1,
                'role' => 'admin',
                'telephone' => null,
            ];
        } else {
            // Client avec téléphone simulé - utiliser un numéro valide du seeder
            $user = (object) [
                'id' => 2,
                'role' => 'client',
                'telephone' => $request->header('X-Telephone', '221771234567'), // Téléphone simulé valide pour les tests
            ];
        }

        // Injecter l'utilisateur dans la requête
        $request->attributes->set('user', $user);

        return $next($request);
    }
}
