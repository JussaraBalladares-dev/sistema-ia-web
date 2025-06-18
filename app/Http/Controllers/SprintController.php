<?php

namespace App\Http\Controllers;

use App\Models\Proyecto;
use App\Models\Sprint;
use Carbon\Carbon;
use Illuminate\Http\Request;

class SprintController extends Controller
{
    public function listarProyectos()
    {
        $proyecto = Proyecto::get();
        return $this->successJsonResponse($proyecto);
    }

    public function listarSprints()
    {
        $sprint = Sprint::with('proyecto')->where('flag_activo', true)->get();
        return $this->successJsonResponse($sprint);
    }

    public function agregarSprint(Request $request)
    {
        if (intval($request->id_proyecto) == 0)
            return $this->errorJsonResponse("Seleccione un Proyecto");

        Sprint::insert([
            'id_proyecto' => $request->id_proyecto,
            'numero' => $request->numero,
            'detalle' => $request->detalle,
            'fecha_inicio' => $request->fecha_inicio,
            'fecha_fin' => $request->fecha_fin,
            'flag_activo' => true,
            'fecha_registro' => Carbon::now()->toDateTimeString(),
        ]);
        return $this->successJsonResponse(null, "Se guardó correctamente");
    }

    public function editarSprint(Request $request)
    {
        $id_sprint = $request->id_sprint;
        Sprint::where('id_sprint', $id_sprint)->update([
            'id_proyecto' => $request->id_proyecto,
            'numero' => $request->numero,
            'detalle' => $request->detalle,
            'fecha_inicio' => $request->fecha_inicio,
            'fecha_fin' => $request->fecha_fin,
            'fecha_editado' => Carbon::now()->toDateTimeString(),
        ]);
        return $this->successJsonResponse(null, "Se editó correctamente");
    }

    public function eliminarSprint(Request $request)
    {
        $id_sprint = $request->id_sprint;
        Sprint::where('id_sprint', $id_sprint)->update([
            'flag_activo' => false,
        ]);
        return $this->successJsonResponse(null, "Se eliminó correctamente");
    }
}
