<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Usuario extends Model
{
    use HasFactory;
    protected $table = "usuario";
    protected $primaryKey = "id_usuario";
    public $timestamps = false;

    protected $fillable = [
        'id_usuario',
        'id_rol',
        'nombres',
        'email',
        'flag_activo',
        'fecha_registro',
        'fecha_editado',
    ];

    protected $hidden = [
        'contrasena'
    ];
    
    protected $casts = [
        'flag_activo' => 'boolean',
    ];

    public function rol()
    {
        return $this->hasOne(Rol::class, 'id_rol', 'id_rol');
    }
}
