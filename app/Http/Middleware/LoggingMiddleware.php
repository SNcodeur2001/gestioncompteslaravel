<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Log;
use Symfony\Component\HttpFoundation\Response;

class LoggingMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next): Response
    {
        $startTime = microtime(true);

        $response = $next($request);

        $endTime = microtime(true);
        $duration = round(($endTime - $startTime) * 1000, 2); // Convert to milliseconds

        // Log operations de création (POST requests)
        if ($request->isMethod('post')) {
            Log::info('Operation de création effectuée', [
                'method' => $request->method(),
                'uri' => $request->fullUrl(),
                'host' => $request->getHost(),
                'nom_operation' => $this->getOperationName($request),
                'ressource' => $this->getResourceName($request),
                'user_id' => $request->user()?->id,
                'user_email' => $request->user()?->email,
                'ip_address' => $request->ip(),
                'user_agent' => $request->userAgent(),
                'status_code' => $response->getStatusCode(),
                'duration_ms' => $duration,
                'timestamp' => now()->toISOString(),
            ]);
        }

        return $response;
    }

    /**
     * Get the operation name from the request
     */
    private function getOperationName(Request $request): string
    {
        $route = $request->route();
        if ($route) {
            $action = $route->getAction();
            return $action['as'] ?? 'unknown_operation';
        }
        return 'unknown_operation';
    }

    /**
     * Get the resource name from the request
     */
    private function getResourceName(Request $request): string
    {
        $path = $request->path();
        $segments = explode('/', $path);

        // Extract resource name from URL path
        foreach ($segments as $segment) {
            if (in_array($segment, ['comptes', 'clients', 'transactions', 'users'])) {
                return $segment;
            }
        }

        return 'unknown_resource';
    }
}