<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class EstadoTarea extends Model
{
    use HasFactory;
    protected $table = "estado_tarea";
    protected $primaryKey = "id_estado_tarea";
    public $timestamps = false;

    protected $fillable = [
        'id_estado_tarea',
        'descripcion',
        'orden',
    ];
}
