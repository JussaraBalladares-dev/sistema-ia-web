<template>
    <!-- <div class="mb-3">
        <h1 class="h3 d-inline align-middle">Usuarios</h1>
    </div> -->
    <div class="row mb-3">
        <div class="col-12 col-lg-12">
            <div class="card">
                <div class="card-header text-center mt-4">
                    <!-- <h2 class="card-title mb-0">Lista de Usuarios</h2> -->
                    <h2 class="fw-light mb-0">Lista de Sprints</h2>
                </div>
                <div class="text-end my-3 mx-3">
                    <button class="btn btn-primary" @click="abrirModalSprint()">
                        Agregar
                        <i class="align-middle me-2" data-feather="user-plus"></i> <span class="align-middle"></span>
                    </button>
                </div>
                <div class="card-body">
                    <table class="table table-striped table-hover table-responsive">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Proyecto</th>
                                <th scope="col"># Sprint</th>
                                <th scope="col">Detalle</th>
                                <th scope="col">Fecha de inicio</th>
                                <th scope="col">Fecha de fin</th>
                                <th scope="col">Aciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr v-for="(item, index) in listaSprints" :key="index">
                                <th scope="row">{{ item.id_sprint }}</th>
                                <td>{{ item.proyecto.descripcion }}</td>
                                <td>{{ item.numero }}</td>
                                <td>{{ item.detalle }}</td>
                                <td>{{ Funciones.FormatearFecha(item.fecha_inicio) }}</td>
                                <td>{{ Funciones.FormatearFecha(item.fecha_fin) }}</td>
                                <td>
                                    <span @click="abrirModalSprint(item)">
                                        <i class="align-middle me-2" data-feather="edit-3" role="button"></i>
                                    </span>
                                    <span @click="eliminarSprint(item)">
                                        <i class="align-middle me-2" data-feather="delete" role="button"></i>
                                    </span>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>

            <div class="modal fade" id="sprintModal" tabindex="-1" aria-labelledby="sprintModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="sprintModalLabel">{{ accion }} Usuario</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formularioSprint" @submit.prevent="guardarSprint">
                                <div class="mb-3 form-floating">
                                    <select
                                        v-model="sprintSeleccionado.id_proyecto"
                                        class="form-select"
                                        id="id_proyecto"
                                        aria-label="Floating label select example"
                                        required
                                    >
                                        <option value="0" disabled>Seleccione</option>
                                        <option v-for="item in listaProyectos" :key="item" :value="item.id_proyecto">
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="id_proyecto">Proyecto</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input v-model="sprintSeleccionado.numero" type="numero" class="form-control" id="numero" required />
                                    <label for="numero">Número</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input v-model="sprintSeleccionado.detalle" type="text" class="form-control" id="detalle" required />
                                    <label for="detalle">Detalle</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input
                                        v-model="sprintSeleccionado.fecha_inicio"
                                        type="date"
                                        class="form-control"
                                        id="fecha_inicio"
                                        required
                                    />
                                    <label for="fecha_inicio">Fecha Inicio</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input
                                        v-model="sprintSeleccionado.fecha_fin"
                                        type="date"
                                        class="form-control"
                                        id="fecha_fin"
                                        required
                                    />
                                    <label for="fecha_fin">Fecha Fin</label>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formularioSprint" class="btn btn-primary">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import SprintService from "../../services/SprintService";
import Funciones from "../../common/Funciones";

const accion = ref("");
const listaSprints = ref([]);
const listaProyectos = ref([]);
const sprint = ref({
    id_sprint: 0,
    id_proyecto: 0,
    numero: 0,
    detalle: "",
    fecha_inicio: "",
    fecha_fin: "",
    flag_activo: true,
    proyecto: {
        id_proyecto: 0,
        descripcion: "",
    },
});
const sprintSeleccionado = ref({ ...sprint.value });

const abrirModalSprint = (item = null) => {
    if (item == null) {
        accion.value = "Agregar";
        sprintSeleccionado.value = { ...sprint.value };
    } else {
        accion.value = "Editar";
        sprintSeleccionado.value = { ...item };
    }
    const modal = new bootstrap.Modal(document.getElementById("sprintModal"));
    modal.show();
};

const guardarSprint = async () => {
    let response;
    try {
        if (accion.value == "Agregar") {
            response = await SprintService.agregarSprint(sprintSeleccionado.value);
        } else if (accion.value == "Editar") {
            response = await SprintService.editarSprint(sprintSeleccionado.value);
        }
    } catch (e) {
        response = e.response;
    }
    interpretarRespuesta(response);
};

const eliminarSprint = (item) => {
    Funciones.MostrarMensajePregunta("¿Está seguro que desea eliminar el sprint?", async () => {
        let response = await SprintService.eliminarSprint(item);
        interpretarRespuesta(response);
    });
};

const interpretarRespuesta = (response) => {
    if (response.data.success) {
        listarSprints();
        Funciones.MostrarMensajeExito("", response.data.message);
        var modal = bootstrap.Modal.getInstance(document.getElementById("sprintModal"));
        modal.hide();
    } else {
        Funciones.MostrarMensajeError("", response.data.message);
    }
};

const listarSprints = async () => {
    listaSprints.value = (await SprintService.listarSprints()).data.data;
    listaProyectos.value = (await SprintService.listarProyectos()).data.data;
    feather.replace();
};

onMounted(() => {
    listarSprints();
});
</script>
