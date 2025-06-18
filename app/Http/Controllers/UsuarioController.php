<?php

namespace App\Http\Controllers;

use App\Common\Constantes;
use App\Models\Rol;
use App\Models\Usuario;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Session;

class UsuarioController extends Controller
{
    public function listarUsuarios()
    {
        $usuarios = Usuario::with('rol')->get();
        return $this->successJsonResponse($usuarios);
    }

    public function listarRoles()
    {
        $roles = Rol::get();
        return $this->successJsonResponse($roles);
    }

    public function agregarUsuario(Request $request)
    {
        if (intval($request->id_rol) == 0)
            return $this->errorJsonResponse("Seleccione un Rol");
        Usuario::insert([
            'id_rol' => $request->id_rol,
            'nombres' => $request->nombres,
            'email' => $request->email,
            'flag_activo' => true,
            'fecha_registro' => Carbon::now()->toDateTimeString()
        ]);
        return $this->successJsonResponse(null, "Se guardó correctamente");
    }
    
    public function editarUsuario(Request $request)
    {
        $id_usuario = $request->id_usuario;
        Usuario::where('id_usuario', $id_usuario)->update([
            'id_rol' => $request->id_rol,
            'nombres' => $request->nombres,
            'email' => $request->email,
            'fecha_editado' => Carbon::now()->toDateTimeString()
        ]);
        return $this->successJsonResponse(null, "Se editó correctamente");
    }
    public function activarUsuario(Request $request)
    {
        $id_usuario = $request->id_usuario;
        Usuario::where('id_usuario', $id_usuario)->update([
            'flag_activo' => true,
            'fecha_editado' => Carbon::now()->toDateTimeString()
        ]);
        return $this->successJsonResponse(null, "Se activó correctamente");
    }

    public function desactivarUsuario(Request $request)
    {
        $id_usuario = $request->id_usuario;
        Usuario::where('id_usuario', $id_usuario)->update([
            'flag_activo' => false,
            'fecha_editado' => Carbon::now()->toDateTimeString()
        ]);
        return $this->successJsonResponse(null, "Se desactivó correctamente");
    }
}
