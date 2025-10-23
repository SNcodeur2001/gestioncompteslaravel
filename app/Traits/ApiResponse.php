<?php

namespace App\Traits;

use App\Constants\Messages;
use Illuminate\Http\JsonResponse;

trait ApiResponse
{
    /**
     * Return a success response.
     *
     * @param mixed $data
     * @param string $message
     * @param int $statusCode
     * @return JsonResponse
     */
    protected function successResponse($data = null, string $message = 'Success', int $statusCode = 200): JsonResponse
    {
        return response()->json([
            'success' => true,
            'message' => $message,
            'data' => $data,
        ], $statusCode);
    }

    /**
     * Return an error response.
     *
     * @param string $message
     * @param int $statusCode
     * @param mixed $errors
     * @return JsonResponse
     */
    protected function errorResponse(string $message = 'Error', int $statusCode = 400, $errors = null): JsonResponse
    {
        return response()->json([
            'success' => false,
            'message' => $message,
            'errors' => $errors,
        ], $statusCode);
    }

    /**
     * Return a paginated response with standardized structure.
     *
     * @param mixed $items
     * @param string $message
     * @param int $statusCode
     * @return JsonResponse
     */
    protected function paginatedResponse($paginator, string $message = 'Success', int $statusCode = 200): JsonResponse
    {
        $data = [
            'success' => true,
            'message' => $message,
            'data' => $paginator->items(),
            'pagination' => [
                'currentPage' => $paginator->currentPage(),
                'totalPages' => $paginator->lastPage(),
                'totalItems' => $paginator->total(),
                'itemsPerPage' => $paginator->perPage(),
                'hasNext' => $paginator->hasMorePages(),
                'hasPrevious' => $paginator->currentPage() > 1,
            ],
            'links' => [
                'self' => request()->fullUrl(),
                'next' => $paginator->nextPageUrl(),
                'first' => $paginator->url(1),
                'last' => $paginator->url($paginator->lastPage()),
            ],
        ];

        // Remove null links
        $data['links'] = array_filter($data['links'], function ($link) {
            return $link !== null;
        });

        return response()->json($data, $statusCode);
    }

    /**
     * Return a not found error response.
     *
     * @param string $resource
     * @return JsonResponse
     */
    protected function notFoundResponse(string $resource = 'Resource'): JsonResponse
    {
        return $this->errorResponse("{$resource} non trouvé", 404);
    }

    /**
     * Return a validation error response.
     *
     * @param mixed $errors
     * @return JsonResponse
     */
    protected function validationErrorResponse($errors = null): JsonResponse
    {
        return $this->errorResponse(Messages::VALIDATION_FAILED, 422, $errors);
    }

    /**
     * Return an internal server error response.
     *
     * @param string $message
     * @return JsonResponse
     */
    protected function internalErrorResponse(string $message = null): JsonResponse
    {
        return $this->errorResponse($message ?? Messages::INTERNAL_ERROR, 500);
    }
}