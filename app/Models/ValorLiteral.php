<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class ValorLiteral extends Model
{
    use HasFactory;
    protected $table = "valor_literal";
    protected $primaryKey = "id_valor_literal";
    public $timestamps = false;

    protected $fillable = [
        'id_valor_literal',
        'descripcion',
        'tipo',
        'orden',
        'peso_ia',
    ];
}
