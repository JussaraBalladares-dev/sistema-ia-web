<template>
    <!-- <div class="mb-3">
        <h1 class="h3 d-inline align-middle">Usuarios</h1>
    </div> -->
    <div class="row mb-3">
        <div class="col-12 col-lg-12">
            <div class="card">
                <div class="card-header text-center mt-4">
                    <!-- <h2 class="card-title mb-0">Lista de Usuarios</h2> -->
                    <h2 class="fw-light mb-0">Lista de Usuarios</h2>
                </div>
                <div class="text-end my-3 mx-3">
                    <button class="btn btn-primary" @click="abrirModalUsuario()">
                        Agregar
                        <i class="align-middle me-2" data-feather="user-plus"></i> <span class="align-middle"></span>
                    </button>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover table-responsive">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Nombres</th>
                                <th scope="col">Email</th>
                                <th scope="col">Rol</th>
                                <th scope="col">Activo</th>
                                <th scope="col">Fecha de registro</th>
                                <th scope="col">Aciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in listaUsuarios" :key="index">
                                <th scope="row">{{ item.id_usuario }}</th>
                                <td>{{ item.nombres }}</td>
                                <td>{{ item.email }}</td>
                                <td>{{ item.rol.descripcion }}</td>
                                <td>{{ item.flag_activo ? "Sí" : "No" }}</td>
                                <td>{{ Funciones.FormatearFechaHora(item.fecha_registro) }}</td>
                                <td class="text-center">
                                    <span v-if="!item.flag_activo" @click="cambiarEstadoUsuario(item, true)">
                                        <i class="align-middle me-2" data-feather="user-check" role="button"></i>
                                    </span>
                                    <span v-if="item.flag_activo" @click="abrirModalUsuario(item)">
                                        <i class="align-middle me-2" data-feather="edit-3" role="button"> </i>
                                    </span>
                                    <span v-if="item.flag_activo" @click="cambiarEstadoUsuario(item, false)">
                                        <i class="align-middle me-2" data-feather="user-x" role="button"></i>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="usuarioModal" tabindex="-1" aria-labelledby="usuarioModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="usuarioModalLabel">{{ accion }} Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formularioUsuario" @submit.prevent="guardarUsuario">
                                <div class="mb-3 form-floating">
                                    <input v-model="usuarioSeleccionado.nombres" type="text" class="form-control" id="nombres" required />
                                    <label for="nombres">Nombre</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input v-model="usuarioSeleccionado.email" type="email" class="form-control" id="email" required />
                                    <label for="email">Email</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <select
                                        v-model="usuarioSeleccionado.id_rol"
                                        class="form-select"
                                        id="id_rol"
                                        aria-label="Floating label select example"
                                        required
                                    >
                                        <option value="0" disabled>Seleccione</option>
                                        <option v-for="item in listaRoles" :key="item" :value="item.id_rol">{{ item.descripcion }}</option>
                                    </select>
                                    <label for="id_rol">Rol</label>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formularioUsuario" class="btn btn-primary">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import UsuarioService from "../../services/UsuarioService";
import Funciones from "../../common/Funciones";

const accion = ref("");
const listaUsuarios = ref([]);
const listaRoles = ref([]);
const usuario = ref({
    id_usuario: 0,
    nombres: "",
    email: "",
    id_rol: "0",
    flag_activo: true,
    fecha_registro: "",
    fecha_editado: "",
});
const usuarioSeleccionado = ref({ ...usuario.value });

const abrirModalUsuario = (item = null) => {
    console.log(item);
    if (item == null) {
        accion.value = "Agregar";
        usuarioSeleccionado.value = { ...usuario.value };
    } else {
        accion.value = "Editar";
        usuarioSeleccionado.value = { ...item };
    }
    const modal = new bootstrap.Modal(document.getElementById("usuarioModal"));
    modal.show();
};

const guardarUsuario = async () => {
    let response;
    try {
        if (accion.value == "Agregar") {
            response = await UsuarioService.agregarUsuario(usuarioSeleccionado.value);
        } else if (accion.value == "Editar") {
            response = await UsuarioService.editarUsuario(usuarioSeleccionado.value);
        }
    } catch (e) {
        response = e.response;
    }
    interpretarRespuesta(response);
};

const cambiarEstadoUsuario = (item, flag_activo) => {
    if (flag_activo) {
        Funciones.MostrarMensajePregunta("¿Está seguro que desea activar al usuario?", async () => {
            let response = await UsuarioService.activarUsuario(item);
            interpretarRespuesta(response);
        });
    } else {
        Funciones.MostrarMensajePregunta("¿Está seguro que desea desactivar al usuario?", async () => {
            let response = await UsuarioService.desactivarUsuario(item);
            interpretarRespuesta(response);
        });
    }
};

const interpretarRespuesta = (response) => {
    if (response.data.success) {
        listarUsuarios();
        Funciones.MostrarMensajeExito("", response.data.message);
        var modal = bootstrap.Modal.getInstance(document.getElementById("usuarioModal"));
        modal.hide();
    } else {
        Funciones.MostrarMensajeError("", response.data.message);
    }
};

const listarUsuarios = async () => {
    listaUsuarios.value = (await UsuarioService.listarUsuarios()).data.data;
    listaRoles.value = (await UsuarioService.listarRoles()).data.data;
    feather.replace();
};

onMounted(() => {
    listarUsuarios();
});
</script>
