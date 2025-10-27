<?php

namespace App\Exceptions;

use Illuminate\Foundation\Exceptions\Handler as ExceptionHandler;
use Throwable;

class Handler extends ExceptionHandler
{
    /**
     * The list of the inputs that are never flashed to the session on validation exceptions.
     *
     * @var array<int, string>
     */
    protected $dontFlash = [
        'current_password',
        'password',
        'password_confirmation',
    ];

    /**
     * Register the exception handling callbacks for the application.
     */
    public function register(): void
    {
        $this->reportable(function (Throwable $e) {
            //
        });

        // Handle authentication exceptions for API routes
        $this->renderable(function (\Illuminate\Auth\AuthenticationException $e, $request) {
            if ($request->is('api/*')) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'UNAUTHENTICATED',
                        'message' => 'Non authentifié',
                        'details' => [
                            'message' => 'Utilisez les headers X-Role et X-Telephone pour vous authentifier'
                        ]
                    ]
                ], 401);
            }
        });

        $this->renderable(function (\Illuminate\Database\Eloquent\ModelNotFoundException $e, $request) {
            if ($request->is('api/*') && $e->getModel() === \App\Models\Compte::class) {
                return response()->json([
                    'success' => false,
                    'error' => [
                        'code' => 'COMPTE_NOT_FOUND',
                        'message' => 'Le compte avec l\'ID spécifié n\'existe pas',
                        'details' => [
                            'compteId' => $request->route('compte') ?? 'unknown'
                        ]
                    ]
                ], 404);
            }
        });
    }
}
