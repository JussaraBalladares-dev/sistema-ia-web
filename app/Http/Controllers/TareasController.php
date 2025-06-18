<?php

namespace App\Http\Controllers;

use App\Common\Constantes;
use App\Models\EstadoTarea;
use App\Models\Tarea;
use App\Models\Sprint;
use App\Models\ValorLiteral;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Http;

class TareasController extends Controller
{
    public function obtenerValoresLiterales()
    {
        $valor_literal = ValorLiteral::get();
        $data = [
            'prioridad' => array_values($valor_literal->where('tipo', Constantes::PRIORIDAD)->toArray()),
            'habilidad' => array_values($valor_literal->where('tipo', Constantes::HABILIDAD)->toArray()),
            'tarea_clara' => array_values($valor_literal->where('tipo', Constantes::TAREA_CLARA)->toArray()),
            'carga_trabajo' => array_values($valor_literal->where('tipo', Constantes::CARGA_TRABAJO)->toArray()),
            'adecuado_habilidades' => array_values($valor_literal->where('tipo', Constantes::ADECUADO_HABILIDADES)->toArray()),
        ];
        return $this->successJsonResponse($data);
    }

    public function listarTareas(Request $request)
    {
        $id_proyecto = intval($request->get('id_proyecto', 0));
        $id_sprint = intval($request->get('id_sprint', 0));
        $id_usuario_asignado = intval($request->get('id_usuario_asignado', 0));

        // $tareas_query = Tarea::with('prioridad')->with('habilidad')->with('tarea_clara')
        //     ->with('carga_trabajo')->with('adecuado_habilidades')
        //     ->where('flag_activo', true);
        $tareas_query = Tarea::where('flag_activo', true);
        if ($id_proyecto != 0)
            $tareas_query = $tareas_query->where('id_proyecto', $id_proyecto);
        if ($id_sprint != 0)
            $tareas_query = $tareas_query->where('id_sprint', $id_sprint);
        if ($id_usuario_asignado != 0)
            $tareas_query = $tareas_query->where('id_usuario_asignado', $id_usuario_asignado);
        $tareas = $tareas_query->get();

        $estado_tareas = EstadoTarea::orderBy('orden', 'asc')->get()->toArray();
        foreach ($estado_tareas as &$item) {
            $id_estado_tarea = $item['id_estado_tarea'];
            $item['lista_tareas'] = array_values($tareas->where('id_estado_tarea', $id_estado_tarea)->toArray());
            unset($item);
        }

        return $this->successJsonResponse($estado_tareas);
    }


    public function agregarTarea(Request $request)
    {
        Tarea::insert([
            'id_proyecto' => $request->id_proyecto,
            'id_sprint' => $request->id_sprint,
            'titulo' => $request->titulo,
            'descripcion' => $request->descripcion,
            'valor_literal_prioridad' => $request->valor_literal_prioridad,
            'valor_literal_habilidad' => $request->valor_literal_habilidad,
            'tiempo_estimado' => $request->tiempo_estimado,
            'tiempo_real' => $request->tiempo_real,
            'porcentaje_avance' => $request->porcentaje_avance,
            'valor_literal_tarea_clara' => $request->valor_literal_tarea_clara,
            'valor_literal_carga_trabajo' => $request->valor_literal_carga_trabajo,
            'valor_literal_adecuado_habilidades' => $request->valor_literal_adecuado_habilidades,
            'flag_activo' => true,
            'fecha_registro' => Carbon::now()->toDateTimeString(),
            // 'fecha_editado',
            'id_estado_tarea' => $request->id_estado_tarea,
            'id_usuario_asignado' => $request->id_usuario_asignado,
        ]);
        return $this->successJsonResponse(null, "Se guardó correctamente");
    }

    public function editarTarea(Request $request)
    {
        $id_tarea = $request->id_tarea;
        Tarea::where('id_tarea', $id_tarea)->update([
            // 'id_proyecto' => $request->id_proyecto,
            // 'id_sprint' => $request->id_sprint,
            'titulo' => $request->titulo,
            'descripcion' => $request->descripcion,
            'valor_literal_prioridad' => $request->valor_literal_prioridad,
            'valor_literal_habilidad' => $request->valor_literal_habilidad,
            'tiempo_estimado' => $request->tiempo_estimado,
            'tiempo_real' => $request->tiempo_real,
            'porcentaje_avance' => $request->porcentaje_avance,
            'valor_literal_tarea_clara' => $request->valor_literal_tarea_clara,
            'valor_literal_carga_trabajo' => $request->valor_literal_carga_trabajo,
            'valor_literal_adecuado_habilidades' => $request->valor_literal_adecuado_habilidades,
            // 'flag_activo' => true,
            // 'fecha_registro' => Carbon::now()->toDateTimeString(),
            'fecha_editado' => Carbon::now()->toDateTimeString(),
            // 'id_estado_tarea' => $request->id_estado_tarea,
            'id_usuario_asignado' => $request->id_usuario_asignado,
        ]);
        return $this->successJsonResponse(null, "Se editó correctamente");
    }

    public function actualizarEstadoTarea(Request $request)
    {
        $id_tarea = $request->id_tarea;
        Tarea::where('id_tarea', $id_tarea)->update([
            'id_estado_tarea' => $request->id_estado_tarea,
            'fecha_editado' => Carbon::now()->toDateTimeString(),
        ]);
        return $this->successJsonResponse(null, "Se actualizó el estado correctamente");
    }

    public function eliminarTarea(Request $request)
    {
        $id_tarea = $request->id_tarea;
        Tarea::where('id_tarea', $id_tarea)->update([
            'flag_activo' => false,
        ]);
        return $this->successJsonResponse(null, "Se eliminó correctamente");
    }

    public function sugerirUsuarioTarea(Request $request)
    {
        // Data para entrenar modelo
        $lista_tareas = Tarea::where('flag_activo', true)
            ->with('prioridad')->with('habilidad')->with('tarea_clara')
            ->with('carga_trabajo')->with('adecuado_habilidades')
            ->get();
        $lista_tareas_entrenamiento = [];
        foreach ($lista_tareas as $item) {
            $lista_tareas_entrenamiento[] = [
                'valor_prioridad' => doubleval($item['prioridad']['peso_ia']),
                'valor_habilidad' => doubleval($item['habilidad']['peso_ia']),
                'tiempo_estimado' => doubleval($item['tiempo_estimado']),
                //'tiempo_real' => doubleval($item['tiempo_real']),
                //'porcentaje_avance' => doubleval($item['porcentaje_avance']),
                'valor_tarea_clara' => doubleval($item['tarea_clara']['peso_ia']),
                'valor_carga_trabajo' => doubleval($item['carga_trabajo']['peso_ia']),
                'valor_adecuado_habilidades' => doubleval($item['adecuado_habilidades']['peso_ia']),
                //'id_estado_tarea' => $item['id_estado_tarea'],
                'id_usuario_asignado' => $item['id_usuario_asignado'],
            ];
        }

        $url_api = env('APP_URL_API_IA');
        # Entrenar modelo
        $response = Http::post($url_api . '/entrenar-modelo', $lista_tareas_entrenamiento)->json();
        # Predecir con modelo
        $response = Http::post($url_api . '/asignar-tarea', [
            "valor_prioridad" => floatval(ValorLiteral::find($request->valor_literal_prioridad)->peso_ia),
            "valor_habilidad" => intval(ValorLiteral::find($request->valor_literal_habilidad)->peso_ia),
            "tiempo_estimado" => $request->tiempo_estimado,
            // "valor_tarea_clara" => floatval(ValorLiteral::find($request->valor_literal_tarea_clara)->peso_ia),
            // "valor_carga_trabajo" => floatval(ValorLiteral::find($request->valor_literal_carga_trabajo)->peso_ia),
            // "valor_adecuado_habilidades" => floatval(ValorLiteral::find($request->valor_literal_adecuado_habilidades)->peso_ia),
        ])->json();

        return $this->successJsonResponse($response, "Correcto");
    }
}
