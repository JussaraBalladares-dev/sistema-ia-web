<?php

use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\AuthController;
use App\Http\Controllers\SprintController;
use App\Http\Controllers\TareasController;
use App\Http\Controllers\UsuarioController;

Route::get('/', function () {
    return [
        Crypt::encryptString("abc123"),
        Crypt::decryptString("eyJpdiI6Imw1TCtZYXBSZlFWSXJJQnZYZTFIWlE9PSIsInZhbHVlIjoiTVpEZnhSLzBVaFJDRHF0N3RPalBMQT09IiwibWFjIjoiN2ZkNTI5NjVkMmYyYzIyODI1Y2Q0NzM3Njk5ZmY4YmJkODNjYTNmOGNiZjM3YmM2NGE2OTE4Y2FkMTBmNzEzMyIsInRhZyI6IiJ9"),
    ];
});

Route::controller(AuthController::class)->prefix('login')->group(function () {
    Route::post('/', 'login');
});

Route::controller(UsuarioController::class)->prefix('usuarios')->group(function () {
    Route::get('/listar-usuarios',          'listarUsuarios');
    Route::get('/listar-roles',             'listarRoles');
    Route::post('/agregar-usuario',         'agregarUsuario');
    Route::put('/editar-usuario',           'editarUsuario');
    Route::patch('/activar-usuario',        'activarUsuario');
    Route::patch('/desactivar-usuario',     'desactivarUsuario');
});

Route::controller(SprintController::class)->prefix('sprint')->group(function () {
    Route::get('/listar-proyectos',     'listarProyectos');
    Route::get('/listar-sprints',       'listarSprints');
    Route::post('/agregar-sprint',      'agregarSprint');
    Route::put('/editar-sprint',        'editarSprint');
    Route::delete('/eliminar-sprint',   'eliminarSprint');
});

Route::controller(TareasController::class)->prefix('tareas')->group(function () {
    Route::get('/obtener-valores-literales',     'obtenerValoresLiterales');
    Route::get('/listar-tareas',                'listarTareas');
    Route::post('/agregar-tarea',               'agregarTarea');
    Route::put('/editar-tarea',                 'editarTarea');
    Route::patch('/actualizar-estado-tarea',    'actualizarEstadoTarea');
    Route::delete('/eliminar-tarea',            'eliminarTarea');
    Route::post('/sugerir-usuario-tarea',       'sugerirUsuarioTarea');
});
