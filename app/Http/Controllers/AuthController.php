<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Cookie;
use Illuminate\Support\Facades\Hash;
use Laravel\Passport\Token;

class AuthController extends Controller
{
    /**
     * @OA\Post(
     *     path="/auth/login",
     *     summary="Connexion utilisateur",
     *     description="Authentifier un utilisateur et retourner un token d'accès JWT",
     *     operationId="login",
     *     tags={"Authentification"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"email", "password"},
     *             @OA\Property(property="email", type="string", format="email", example="admin@gestioncomptes.com", description="Email de l'utilisateur"),
     *             @OA\Property(property="password", type="string", example="password", description="Mot de passe de l'utilisateur")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Connexion réussie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Connexion réussie"),
     *             @OA\Property(property="data", type="object",
     *                 @OA\Property(property="user", type="object",
     *                     @OA\Property(property="id", type="integer", example=1),
     *                     @OA\Property(property="name", type="string", example="Admin User"),
     *                     @OA\Property(property="email", type="string", example="admin@gestioncomptes.com"),
     *                     @OA\Property(property="role", type="string", example="admin")
     *                 ),
     *                 @OA\Property(property="access_token", type="string", example="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9..."),
     *                 @OA\Property(property="refresh_token", type="string", example="token_id_here"),
     *                 @OA\Property(property="token_type", type="string", example="Bearer"),
     *                 @OA\Property(property="expires_in", type="integer", example=604800)
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Identifiants invalides",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="INVALID_CREDENTIALS"),
     *                 @OA\Property(property="message", type="string", example="Email ou mot de passe incorrect")
     *             )
     *         )
     *     )
     * )
     */
    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required|string',
        ]);

        $user = User::where('email', $request->email)->first();

        if (!$user || !Hash::check($request->password, $user->password)) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INVALID_CREDENTIALS',
                    'message' => 'Email ou mot de passe incorrect',
                    'details' => [
                        'message' => 'Vérifiez vos identifiants de connexion'
                    ]
                ]
            ], 401);
        }

        // Create access token
        $token = $user->createToken('Personal Access Token')->accessToken;

        // Create refresh token (using Passport's token method)
        $refreshToken = $user->createToken('Refresh Token');
        $refreshToken->token->expires_at = now()->addDays(30);
        $refreshToken->token->save();

        // Set token in cookie
        Cookie::queue('access_token', $token, 60 * 24 * 7, '/', null, false, true); // 7 days

        return response()->json([
            'success' => true,
            'message' => 'Connexion réussie',
            'data' => [
                'user' => [
                    'id' => $user->id,
                    'name' => $user->name,
                    'email' => $user->email,
                    'role' => $user->role,
                ],
                'access_token' => $token,
                'refresh_token' => $refreshToken->token->id,
                'token_type' => 'Bearer',
                'expires_in' => 60 * 24 * 7 * 60, // 7 days in seconds
            ]
        ]);
    }

    /**
     * @OA\Post(
     *     path="/api/v1/ndiaye.mapathe/auth/refresh",
     *     summary="Rafraîchir le token d'accès",
     *     description="Utiliser un refresh token pour obtenir un nouveau token d'accès",
     *     operationId="refreshToken",
     *     tags={"Authentification"},
     *     @OA\RequestBody(
     *         required=true,
     *         @OA\JsonContent(
     *             required={"refresh_token"},
     *             @OA\Property(property="refresh_token", type="string", example="refresh_token_from_login_response", description="Le refresh token obtenu lors de la connexion")
     *         )
     *     ),
     *     @OA\Response(
     *         response=200,
     *         description="Token rafraîchi avec succès",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Token rafraîchi avec succès"),
     *             @OA\Property(property="data", type="object",
     *                 @OA\Property(property="access_token", type="string", example="eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiJ9..."),
     *                 @OA\Property(property="token_type", type="string", example="Bearer"),
     *                 @OA\Property(property="expires_in", type="integer", example=604800)
     *             )
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Refresh token invalide ou expiré",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="INVALID_REFRESH_TOKEN"),
     *                 @OA\Property(property="message", type="string", example="Token de rafraîchissement invalide ou expiré")
     *             )
     *         )
     *     )
     * )
     */
    public function refresh(Request $request)
    {
        $request->validate([
            'refresh_token' => 'required|string',
        ]);

        $token = Token::find($request->refresh_token);

        if (!$token || $token->revoked || $token->expires_at->isPast()) {
            return response()->json([
                'success' => false,
                'error' => [
                    'code' => 'INVALID_REFRESH_TOKEN',
                    'message' => 'Token de rafraîchissement invalide ou expiré',
                    'details' => [
                        'message' => 'Veuillez vous reconnecter'
                    ]
                ]
            ], 401);
        }

        $user = $token->user;

        // Revoke old access token
        $user->tokens()->where('id', '!=', $token->id)->delete();

        // Create new access token
        $newToken = $user->createToken('Personal Access Token')->accessToken;

        // Set token in cookie
        Cookie::queue('access_token', $newToken, 60 * 24 * 7, '/', null, false, true);

        return response()->json([
            'success' => true,
            'message' => 'Token rafraîchi avec succès',
            'data' => [
                'access_token' => $newToken,
                'token_type' => 'Bearer',
                'expires_in' => 60 * 24 * 7 * 60,
            ]
        ]);
    }

    /**
     * @OA\Post(
     *     path="/api/v1/ndiaye.mapathe/auth/logout",
     *     summary="Déconnexion utilisateur",
     *     description="Révoquer tous les tokens de l'utilisateur connecté",
     *     operationId="logout",
     *     tags={"Authentification"},
     *     security={{"bearerAuth":{}}},
     *     @OA\Response(
     *         response=200,
     *         description="Déconnexion réussie",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=true),
     *             @OA\Property(property="message", type="string", example="Déconnexion réussie"),
     *             @OA\Property(property="data", type="object", example={})
     *         )
     *     ),
     *     @OA\Response(
     *         response=401,
     *         description="Token invalide ou manquant",
     *         @OA\JsonContent(
     *             @OA\Property(property="success", type="boolean", example=false),
     *             @OA\Property(property="error", type="object",
     *                 @OA\Property(property="code", type="string", example="UNAUTHORIZED"),
     *                 @OA\Property(property="message", type="string", example="Non autorisé")
     *             )
     *         )
     *     )
     * )
     */
    public function logout(Request $request)
    {
        $user = Auth::guard('api')->user();

        // Revoke all tokens for the user
        $user->tokens->each(function ($token) {
            $token->revoke();
        });

        // Clear cookie
        Cookie::queue(Cookie::forget('access_token'));

        return response()->json([
            'success' => true,
            'message' => 'Déconnexion réussie',
            'data' => []
        ]);
    }
}
