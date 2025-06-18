<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Proyecto extends Model
{
    use HasFactory;
    protected $table = "proyecto";
    protected $primaryKey = "id_proyecto";
    public $timestamps = false;

    protected $fillable = [
        'id_proyecto',
        'descripcion',
    ];
}
