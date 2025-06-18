<template>
    <div class="row mb-3">
        <div class="col-12 col-lg-12">
            <div class="card">
                <div class="card-header text-center mt-4">
                    <!-- <h2 class="card-title mb-0">Lista de Usuarios</h2> -->
                    <h2 class="fw-light mb-0">Lista de Tareas</h2>
                </div>
                <div class="row d-flex justify-content-center">
                    <div class="col-4">
                        <div class="form-floating">
                            <select
                                v-model="idProyectoSeleccionado"
                                @change="cargarTablero"
                                class="form-select"
                                id="floatingSelect"
                                aria-label="Floating label select example"
                            >
                                <option v-for="(item, index) in listaProyectos" :key="index" :value="item.id_proyecto">
                                    {{ item.descripcion }}
                                </option>
                            </select>
                            <label for="floatingSelect">Proyecto</label>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-floating">
                            <select
                                v-model="idSprintSeleccionado"
                                @change="cargarTablero"
                                class="form-select"
                                id="floatingSelect"
                                aria-label="Floating label select example"
                            >
                                <option v-for="(item, index) in listaSprints" :key="index" :value="item.id_sprint">
                                    {{ item.detalle }}
                                </option>
                            </select>
                            <label for="floatingSelect">Sprint</label>
                        </div>
                    </div>
                </div>
                <div class="text-end my-3 mx-3">
                    <button class="btn btn-primary" @click="abrirModalTarea()">
                        Agregar Tarea
                        <i class="align-middle me-2" data-feather="user-plus"></i> <span class="align-middle"></span>
                    </button>
                </div>
                <div class="card-body">
                    <div class="container-fluid p-4 kanban-board">
                        <div class="d-flex gap-3 overflow-auto flex-nowrap">
                            <div v-for="(column, index) in listaTareas" :key="index" class="kanban-column card shadow-sm">
                                <div class="card-header bg-white border-bottom fw-bold text-primary">
                                    {{ column.descripcion }} ({{ column.lista_tareas.length }})
                                </div>
                                <div class="card-body bg-light px-2 py-3">
                                    <draggable
                                        v-model="column.lista_tareas"
                                        group="tasks"
                                        item-key="id_tarea"
                                        ghost-class="drag-ghost"
                                        chosen-class="drag-chosen"
                                        @change="cambiarColumna"
                                    >
                                        <template #item="{ element }">
                                            <div class="kanban-card card mb-2 shadow-sm border-0">
                                                <div class="card-body p-2">
                                                    <div class="fw-semibold">
                                                        {{ element.titulo }}
                                                        <span @click="abrirModalTarea(element)" role="button" style="cursor: pointer">
                                                            <i class="align-middle mx-2" data-feather="eye"></i>
                                                        </span>
                                                        <span @click="eliminarTarea(element)" role="button" style="cursor: pointer">
                                                            <i class="align-middle mx-0" data-feather="delete"></i>
                                                        </span>
                                                    </div>
                                                    <small class="text-muted">{{ element.titulo }}</small>
                                                </div>
                                            </div>
                                        </template>
                                    </draggable>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="modal fade" id="taskModal" tabindex="-1" aria-labelledby="taskModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-md">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="taskModalLabel">{{ accion }} tarea</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <form id="formularioTarea" @submit.prevent="guardarTarea">
                                <div class="mb-3 form-floating">
                                    <input v-model="tareaSeleccionada.titulo" type="text" class="form-control" id="titulo" required/>
                                    <label for="titulo">Nombre</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <textarea
                                        v-model="tareaSeleccionada.descripcion"
                                        class="form-control"
                                        id="descripcion"
                                        style="height: 80px" required
                                    ></textarea>
                                    <label for="descripcion">Descripción</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <select
                                        v-model="tareaSeleccionada.valor_literal_prioridad"
                                        class="form-select"
                                        id="floatingSelect"
                                        aria-label="Floating label select example" required
                                    >
                                        <option v-for="item in valoresLiterales.prioridad" :key="item" :value="item.id_valor_literal">
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="floatingSelect">Prioridad</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <select
                                        v-model="tareaSeleccionada.valor_literal_habilidad"
                                        class="form-select"
                                        id="floatingSelect"
                                        aria-label="Floating label select example" required
                                    >
                                        <option v-for="item in valoresLiterales.habilidad" :key="item" :value="item.id_valor_literal">
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="floatingSelect">Habilidad Requerida</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input
                                        v-model="tareaSeleccionada.tiempo_estimado"
                                        type="number"
                                        class="form-control"
                                        id="tiempo_estimado" required
                                    />
                                    <label for="tiempo_estimado">Tiempo Estimado (Horas)</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input v-model="tareaSeleccionada.tiempo_real" type="number" class="form-control" id="tiempo_real" required />
                                    <label for="tiempo_real">Tiempo Real hasta la fecha (Horas)</label>
                                </div>
                                <div class="mb-3 form-floating">
                                    <input
                                        v-model="tareaSeleccionada.porcentaje_avance"
                                        type="number"
                                        class="form-control"
                                        id="porcentaje_avance" required
                                    />
                                    <label for="porcentaje_avance">Porcentaje de avance (%)</label>
                                </div>

                                <hr />

                                <div class="mb-3 form-floating" v-if="!flagRegistrarTareas">
                                    <select
                                        v-model="tareaSeleccionada.valor_literal_tarea_clara"
                                        class="form-select"
                                        required
                                        id="claridad"
                                    >
                                        <option v-for="item in valoresLiterales.tarea_clara" :key="item" :value="item.id_valor_literal">
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="claridad">¿La tarea estaba clara?</label>
                                </div>
                                <div class="mb-3 form-floating" v-if="!flagRegistrarTareas">
                                    <select v-model="tareaSeleccionada.valor_literal_carga_trabajo" class="form-select" required id="carga">
                                        <option v-for="item in valoresLiterales.carga_trabajo" :key="item" :value="item.id_valor_literal">
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="carga">¿Cómo fue la carga de trabajo?</label>
                                </div>
                                <div class="mb-3 form-floating" v-if="!flagRegistrarTareas">
                                    <select
                                        v-model="tareaSeleccionada.valor_literal_adecuado_habilidades"
                                        class="form-select"
                                        required
                                        id="idoneidad"
                                    >
                                        <option
                                            v-for="item in valoresLiterales.adecuado_habilidades"
                                            :key="item"
                                            :value="item.id_valor_literal"
                                        >
                                            {{ item.descripcion }}
                                        </option>
                                    </select>
                                    <label for="idoneidad">¿Era adecuada a tus habilidades?</label>
                                </div>

                                <div class="mb-3 form-floating input-group" v-if="flagRegistrarTareas">
                                    <select
                                        v-model="tareaSeleccionada.id_usuario_asignado"
                                        class="form-select"
                                        required
                                        id="idoneidad"
                                    >
                                        <option
                                            v-for="item in listaUsuarios"
                                            :key="item"
                                            :value="item.id_usuario"
                                        >
                                            {{ item.nombres }}
                                        </option>
                                    </select>
                                    <label for="idoneidad">Usuario Asignado</label>
                                    <button class="input-group-text btn btn-success" @click="sugerirUsuario" type="button">
                                        <span v-if="cargandoSugerencia" class="spinner-grow spinner-grow-sm" role="status" aria-hidden="true"></span>
                                        Sugerir
                                    </button>
                                </div>
                            </form>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="submit" form="formularioTarea" class="btn btn-primary">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref, onMounted, nextTick, toRefs } from "vue";
import draggable from "vuedraggable";
import SprintService from "../../services/SprintService";
import TareasService from "../../services/TareasService";
import Funciones from "../../common/Funciones";
import UsuarioService from "../../services/UsuarioService";
import Constantes from "../../common/Constantes";

const accion = ref("");
const listaSprints = ref([]);
const listaProyectos = ref([]);
const valoresLiterales = ref([]);
const listaUsuarios = ref([]);
const listaTareas = ref([]);
const idSprintSeleccionado = ref(0);
const idProyectoSeleccionado = ref(0);
const tarea = ref({
    id_tarea: 0,
    id_proyecto: 0,
    id_sprint: 0,
    titulo: "",
    descripcion: "",
    valor_literal_prioridad: 0,
    valor_literal_habilidad: 0,
    tiempo_estimado: 0,
    tiempo_real: 0,
    porcentaje_avance: 0,
    valor_literal_tarea_clara: 0,
    valor_literal_carga_trabajo: 0,
    valor_literal_adecuado_habilidades: 0,
    id_estado_tarea: 1,
    id_usuario_asignado: 0,
});
const tareaSeleccionada = ref({ ...tarea.value });
const props = defineProps(["id_usuario_", "flag_registrar_tareas_"]);
const { id_usuario_: id_usuario_, flag_registrar_tareas_: flag_registrar_tareas_ } = toRefs(props);
const idUsuario = ref(0);
const flagRegistrarTareas = ref(false);
const cargandoSugerencia = ref(false);

const abrirModalTarea = (item = null) => {
    if (item == null) {
        accion.value = "Agregar";
        tareaSeleccionada.value = { ...tarea.value };
    } else {
        accion.value = "Editar";
        tareaSeleccionada.value = { ...item };
    }
    const modal = new bootstrap.Modal(document.getElementById("taskModal"));
    modal.show();
};

const guardarTarea = async () => {
    let response;
    try {
        if (accion.value == "Agregar") {
            tareaSeleccionada.value.id_proyecto = idSprintSeleccionado.value;
            tareaSeleccionada.value.id_sprint = idProyectoSeleccionado.value;
            response = await TareasService.agregarTarea(tareaSeleccionada.value);
        } else if (accion.value == "Editar") {
            response = await TareasService.editarTarea(tareaSeleccionada.value);
        }
    } catch (e) {
        response = e.response;
    }
    interpretarRespuesta(response);
};

const cambiarColumna = async (event) => {
    if (event.added == undefined) return;
    // console.log("Elemento movido:", event);
    // console.log("Nueva columna:", event.added.element.id_tarea);
    // const destino = this.listaTareas.find(col => col.id_estado_tarea == event.added.element);
    let estadoNuevoTarea = {};
    for(const item of listaTareas.value){
        for(const tarea of item.lista_tareas){
            if (tarea.id_tarea == event.added.element.id_tarea){
                estadoNuevoTarea = item;
            }
        }
    }
    await TareasService.actualizarEstadoTarea({
        id_tarea: event.added.element.id_tarea,
        id_estado_tarea: estadoNuevoTarea.id_estado_tarea,
    });
};

const eliminarTarea = (tarea) => {
    Funciones.MostrarMensajePregunta("¿Está seguro que desea eliminar la tarea?", async () => {
        let response = await TareasService.eliminarTarea(tarea);
        interpretarRespuesta(response);
    });

};

const interpretarRespuesta = (response) => {
    if (response.data.success) {
        cargarTablero();
        Funciones.MostrarMensajeExito("", response.data.message);
        var modal = bootstrap.Modal.getInstance(document.getElementById("taskModal"));
        modal.hide();
    } else {
        Funciones.MostrarMensajeError("", response.data.message);
    }
};

const sugerirUsuario = async () => {
    cargandoSugerencia.value = true;
    try{
        const response = await TareasService.sugerirUsuarioTarea(tareaSeleccionada.value);
        const id_usuario_asignado = response.data.data.usuario_sugerido;
        tareaSeleccionada.value.id_usuario_asignado = id_usuario_asignado;
    }
    catch(e) {
        console.log(e)
    }
    cargandoSugerencia.value = false;
}

const cargarTablero = async () => {
    const data = {
        id_proyecto: idProyectoSeleccionado.value,
        id_sprint: idSprintSeleccionado.value,
        id_usuario_asignado: idUsuario.value,
    };

    if (flagRegistrarTareas.value){
        data.id_usuario_asignado = 0;
    }

    listaTareas.value = (await TareasService.listarTareas(data)).data.data;
    await nextTick();
    feather.replace();
};

const listarDataInicial = async () => {
    listaSprints.value = (await SprintService.listarSprints()).data.data;
    listaProyectos.value = (await SprintService.listarProyectos()).data.data;
    idSprintSeleccionado.value = listaSprints.value[0].id_sprint;
    idProyectoSeleccionado.value = listaProyectos.value[0].id_proyecto;
    valoresLiterales.value = (await TareasService.obtenerValoresLiterales()).data.data;
    cargarTablero();
    if (flagRegistrarTareas.value){
        listaUsuarios.value = (await UsuarioService.listarUsuarios()).data.data;
        listaUsuarios.value = listaUsuarios.value.filter(x => x.id_rol == Constantes.RolDesarrollador)
    }
};

onMounted(() => {
    listarDataInicial();
    idUsuario.value = id_usuario_.value;
    flagRegistrarTareas.value = flag_registrar_tareas_.value == "1";
});
</script>

<style scoped>
.kanban-board {
    background-color: #f5f7fa;
    /*height: 100vh;*/
}

.kanban-column {
    min-width: 300px;
    max-width: 320px;
    flex: 0 0 auto;
    border-radius: 0.5rem;
}

.kanban-card {
    background-color: #ffffff;
    border-left: 4px solid #0078d4; /* azul tipo Azure */
    cursor: move;
    transition: transform 0.2s ease;
}

.drag-ghost {
    opacity: 0.5;
}

.drag-chosen {
    transform: rotate(2deg);
}
</style>
