<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Tarea extends Model
{
    use HasFactory;
    protected $table = "tarea";
    protected $primaryKey = "id_tarea";
    public $timestamps = false;

    protected $fillable = [
        'id_tarea',
        'id_proyecto',
        'id_sprint',
        'titulo',
        'descripcion',
        'valor_literal_prioridad',
        'valor_literal_habilidad',
        'tiempo_estimado',
        'tiempo_real',
        'porcentaje_avance',
        'valor_literal_tarea_clara',
        'valor_literal_carga_trabajo',
        'valor_literal_adecuado_habilidades',
        'flag_activo',
        'fecha_registro',
        'fecha_editado',
        'id_estado_tarea',
        'id_usuario_asignado',
    ];
    
    protected $casts = [
        'flag_activo' => 'boolean',
    ];

    public function prioridad()
    {
        return $this->hasOne(ValorLiteral::class, 'id_valor_literal', 'valor_literal_prioridad')
        ->where('tipo', 'prioridad');
    }

    public function habilidad()
    {
        return $this->hasOne(ValorLiteral::class, 'id_valor_literal', 'valor_literal_habilidad')
        ->where('tipo', 'habilidad');
    }

    public function tarea_clara()
    {
        return $this->hasOne(ValorLiteral::class, 'id_valor_literal', 'valor_literal_tarea_clara')
        ->where('tipo', 'tarea_clara');
    }

    public function carga_trabajo()
    {
        return $this->hasOne(ValorLiteral::class, 'id_valor_literal', 'valor_literal_carga_trabajo')
        ->where('tipo', 'carga_trabajo');
    }

    public function adecuado_habilidades()
    {
        return $this->hasOne(ValorLiteral::class, 'id_valor_literal', 'valor_literal_adecuado_habilidades')
        ->where('tipo', 'adecuado_habilidades');
    }


    


}
