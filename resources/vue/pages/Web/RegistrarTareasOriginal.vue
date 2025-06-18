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
                            <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
                                <option selected>Balance Metalúrgico</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                            <label for="floatingSelect">Proyecto</label>
                        </div>
                    </div>
                    <div class="col-4">
                        <div class="form-floating">
                            <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
                                <option selected>Sprint 2</option>
                                <option value="1">One</option>
                                <option value="2">Two</option>
                                <option value="3">Three</option>
                            </select>
                            <label for="floatingSelect">Sprint</label>
                        </div>
                    </div>
                </div>
                <div class="text-end my-3 mx-3">
                    <button class="btn btn-primary" @click="agregarTarea">
                        Agregar Tarea
                        <i class="align-middle me-2" data-feather="user-plus"></i> <span class="align-middle"></span>
                    </button>
                </div>
                <div class="card-body">
                    <div class="container-fluid p-4 kanban-board">
                        <div class="d-flex gap-3 overflow-auto flex-nowrap">
                            <div v-for="(column, index) in columns" :key="index" class="kanban-column card shadow-sm">
                                <div class="card-header bg-white border-bottom fw-bold text-primary">
                                    {{ column.name }} ({{ column.tasks.length }})
                                </div>
                                <div class="card-body bg-light px-2 py-3">
                                    <draggable
                                        v-model="column.tasks"
                                        group="tasks"
                                        item-key="id"
                                        ghost-class="drag-ghost"
                                        chosen-class="drag-chosen"
                                    >
                                        <template #item="{ element }">
                                            <div class="kanban-card card mb-2 shadow-sm border-0">
                                                <div class="card-body p-2">
                                                    <div class="fw-semibold">
                                                        {{ element.title }}
                                                        <span @click="verTarea(element)" role="button" style="cursor: pointer">
                                                            <i class="align-middle mx-2" data-feather="eye"></i>
                                                        </span>
                                                        <span @click="eliminarTarea(element)" role="button" style="cursor: pointer">
                                                            <i class="align-middle mx-0" data-feather="delete"></i>
                                                        </span>
                                                    </div>
                                                    <small class="text-muted">{{ element.description }}</small>
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
                            <h5 class="modal-title" id="taskModalLabel">Editar tarea</h5>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
                        </div>
                        <div class="modal-body">
                            <div class="mb-3 form-floating">
                                <input type="text" class="form-control" id="floatingInputValue" value="Refactor de componente Sidebar" />
                                <label for="floatingInputValue">Nombre</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <input
                                    type="text"
                                    class="form-control"
                                    id="floatingInputValue"
                                    value="Refactorizar de componente Sidebar del layout principal..."
                                />
                                <label for="floatingInputValue">Descripción</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
                                    <option selected>Media</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                                </select>
                                <label for="floatingSelect">Prioridad</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <select class="form-select" id="floatingSelect" aria-label="Floating label select example">
                                    <option selected>Frontend</option>
                                    <option value="1">One</option>
                                    <option value="2">Two</option>
                                    <option value="3">Three</option>
                                </select>
                                <label for="floatingSelect">Habilidad Requerida</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <input type="number" class="form-control" id="floatingInputValue" value="12" />
                                <label for="floatingInputValue">Tiempo Estimado (Horas)</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <input type="number" class="form-control" id="floatingInputValue" value="10" />
                                <label for="floatingInputValue">Tiempo Real hasta la fecha (Horas)</label>
                            </div>
                            <div class="mb-3 form-floating">
                                <input type="number" class="form-control" id="floatingInputValue" value="75" />
                                <label for="floatingInputValue">Porcentaje de avance (%)</label>
                            </div>

                            <hr />

                            <div class="mb-3 form-floating">
                                <select class="form-select" required id="claridad">
                                    <option disabled value="">Selecciona</option>
                                    <option value="1">1 - Nada clara</option>
                                    <option value="2">2</option>
                                    <option value="3">3 - Aceptable</option>
                                    <option value="4">4</option>
                                    <option value="5">5 - Muy clara</option>
                                </select>
                                <label for="claridad">¿La tarea estaba clara?</label>
                            </div>
                            <div class="mb-3  form-floating">
                                <select class="form-select" required id="carga">
                                    <option disabled value="">Selecciona</option>
                                    <option value="1">1 - Excesiva</option>
                                    <option value="2">2</option>
                                    <option value="3">3 - Aceptable</option>
                                    <option value="4">4</option>
                                    <option value="5">5 - Muy liviana</option>
                                </select>
                                <label for="carga">¿Cómo fue la carga de trabajo?</label>
                            </div>
                            <div class="mb-3  form-floating">
                                <select class="form-select" required id="idoneidad">
                                    <option disabled value="">Selecciona</option>
                                    <option value="1">1 - Nada relacionada</option>
                                    <option value="2">2</option>
                                    <option value="3">3 - Más o menos</option>
                                    <option value="4">4</option>
                                    <option value="5">5 - Muy adecuada</option>
                                </select>
                                <label for="idoneidad">¿Era adecuada a tus habilidades?</label>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                            <button type="button" class="btn btn-primary">Guardar</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup>
import { ref } from "vue";
import draggable from "vuedraggable";

const columns = ref([
    {
        name: "Pendiente",
        tasks: [
            { id: 1, title: "Crear endpoint API", description: "Usuarios -> POST /api/users" },
            { id: 2, title: "Diseño landing page", description: "Figma versión 2" },
            { id: 3, title: "Revisar pull request", description: "PR #23 de Juan" },
            { id: 4, title: "Actualizar dependencias", description: "npm audit fix" },
        ],
    },
    {
        name: "En curso",
        tasks: [
            { id: 5, title: "Test unitarios login", description: "Cobertura > 90%" },
            { id: 6, title: "Refactor de componente Sidebar", description: "Optimizar reactividad" },
            { id: 7, title: "Diseñar logo nuevo", description: "Colores corporativos" },
        ],
    },
    {
        name: "Terminado",
        tasks: [
            { id: 8, title: "Configuración CI/CD", description: "Deploy automático en main" },
            { id: 9, title: "Documentar setup del proyecto", description: "README.md actualizado" },
            { id: 10, title: "Migrar base de datos", description: "De SQLite a PostgreSQL" },
        ],
    },
]);

const agregarTarea = () => {
    const modal = new bootstrap.Modal(document.getElementById("taskModal"));
    modal.show();
};
const verTarea = (tarea) => {
    console.log(2);
    console.log(tarea);
    const modal = new bootstrap.Modal(document.getElementById("taskModal"));
    console.log(modal);
    modal.show();
};
const eliminarTarea = (tarea) => {
    console.log("eliminarTarea");
};
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
