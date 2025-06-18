<?php

namespace App\Traits;


use Illuminate\Http\JsonResponse;
use Symfony\Component\HttpFoundation\Response;

trait ApiResponser
{
    /**
     * Return response inside data key
     * @param mixed $data
     * @param int $code
     * @return JsonResponse
     */
    public function successJsonResponse(mixed $data = null, string $message = 'OK', int $code = Response::HTTP_OK): JsonResponse
    {
        $content = [ 'message' => $message, 'code' => $code, 'success' => true ];
        is_null($data) ?: $content['data'] = $data;
        return new JsonResponse($content, $code);
    }

    /**
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    public function errorJsonResponse(string $message = 'Error', string $errors = '', $status = false ): JsonResponse
    {
        return new JsonResponse(['status' => $status, 'message' => $message, 'errors' => $errors, 'success' => false], 422);
    }

    /**
     * Return response success
     * @param mixed $data
     * @param int $code
     * @return JsonResponse
     */
    public function successResponse(string $message = 'OK', int $code = Response::HTTP_OK): JsonResponse
    {
        $content = [ 'message' => $message, 'code' => $code, 'success' => true ];
        return new JsonResponse($content, $code);
    }

    /**
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    public function errorResponse(string $message, int $code = Response::HTTP_INTERNAL_SERVER_ERROR): JsonResponse
    {
        $http_code = ( $code > 200 && 600 > $code ) ? $code : Response::HTTP_INTERNAL_SERVER_ERROR;
        return new JsonResponse(['message' => $message, 'code' => $code, 'success' => false], $http_code);
    }

    /**
     * @param string $message
     * @param int $code
     * @return JsonResponse
     */
    public function errorValidationResponse(mixed $errors, int $code = Response::HTTP_UNPROCESSABLE_ENTITY): JsonResponse
    {
        return new JsonResponse(['message' => Response::$statusTexts[422],'errors' => $errors, 'code' => $code, 'success' => false], $code);
    }

    /**
     * @param string $message
     * @return JsonResponse
     */
    public function serverErrorResponse(mixed $message): JsonResponse
    {
        return new JsonResponse(['message' => $message, Response::HTTP_INTERNAL_SERVER_ERROR, 'success' => false], Response::HTTP_INTERNAL_SERVER_ERROR);
    }
}
