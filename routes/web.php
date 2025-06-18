<?php
// composer run dev

use App\Http\Controllers\AuthController;
use App\Http\Middleware\NecesitaAutenticacion;
use App\Http\Middleware\RedirigirSiEstaAutenticado;
use Illuminate\Support\Facades\Route;

// Route::get('/', function () {
//     return view('welcome');
// });

$router->group(['middleware' => [RedirigirSiEstaAutenticado::class]], function () use ($router) {
    Route::get('/login', function () {
        return view('auth/login');
    });
});

$router->group(['middleware' => [NecesitaAutenticacion::class]], function () use ($router) {
    Route::get('/', function () {
        return view('web/web');
    });
    
    Route::get('/sprints', function () {
        return view('web/sprints');
    });
    Route::get('/registrar-tareas', function () {
        return view('web/registrar_tareas');
    });
    Route::get('/tareas-asignadas', function () {
        return view('web/tareas_asignadas');
    });

    Route::get('/mi-perfil', function () {
        return view('web/mi_perfil');
    });
    Route::get('/usuarios', function () {
        return view('web/usuarios');
    });
    Route::get('/logout', [AuthController::class, 'logout']);
});
