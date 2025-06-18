<?php

namespace App\Http\Middleware;

use App\Common\Constantes;
use Closure;
use Illuminate\Support\Facades\Session;

class NecesitaAutenticacion
{
    public function handle($request, Closure $next, $guard = null)
    {
        $esta_logueado = Session::get(Constantes::ESTA_LOGUEADO, false);
        if ($esta_logueado)
            return $next($request);
        else
            return redirect('/login');
    }
}
