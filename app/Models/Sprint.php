<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Sprint extends Model
{
    use HasFactory;
    protected $table = "sprint";
    protected $primaryKey = "id_sprint";
    public $timestamps = false;

    protected $fillable = [
        'id_sprint',
        'id_proyecto',
        'numero',
        'detalle',
        'fecha_inicio',
        'fecha_fin',
        'flag_activo',
        'fecha_registro',
        'fecha_editado',
    ];
    
    protected $casts = [
        'flag_activo' => 'boolean',
    ];

    public function proyecto()
    {
        return $this->hasOne(Proyecto::class, 'id_proyecto', 'id_proyecto');
    }
}
