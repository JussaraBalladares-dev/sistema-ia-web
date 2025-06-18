<?php

namespace App\Http\Controllers;

use App\Common\Constantes;
use App\Models\Usuario;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Crypt;
use Illuminate\Support\Facades\Session;

class AuthController extends Controller
{
    public function login(Request $request)
    {
        $email = $request->email;
        $contrasena = $request->contrasena;
        $usuario = Usuario::where('email', $email)->first();
        if (is_null($usuario)) {
            return $this->errorJsonResponse("Usuario o contraseña incorrecto");
        }
        if (Crypt::decryptString($usuario->contrasena) != $contrasena) {
            return $this->errorJsonResponse("Usuario o contraseña incorrecto");
        }
        Session::put(Constantes::ESTA_LOGUEADO, true);
        Session::put(Constantes::ID_USUARIO, $usuario->id_usuario);
        Session::put(Constantes::ID_ROL, $usuario->id_rol);
        Session::put(Constantes::NOMBRE_USUARIO, $usuario->nombres);
        return $this->successJsonResponse($usuario);
    }

    public function logout(){
        Session::remove(Constantes::ESTA_LOGUEADO);
        Session::remove(Constantes::ID_USUARIO);
        Session::remove(Constantes::ID_ROL);
        Session::remove(Constantes::NOMBRE_USUARIO);
        return redirect('/');
    }
}
