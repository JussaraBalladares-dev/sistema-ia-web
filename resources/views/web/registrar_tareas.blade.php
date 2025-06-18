<?php

use App\Common\Constantes;
use Illuminate\Support\Facades\Session;
$id_usuario = Session::get(Constantes::ID_USUARIO)
?>
@extends('layouts/webLayout')

@section('contentBody')
<registrar-tareas :id_usuario_="{{$id_usuario}}" flag_registrar_tareas_="1"></registrar-tareas>
@endsection
