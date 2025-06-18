import Api from './base/BaseRestService'

const listarProyectos = async () => {
    return Api.axiosGet('api/sprint/listar-proyectos');
}

const listarSprints = async () => {
    return Api.axiosGet('api/sprint/listar-sprints');
}

const agregarSprint = async (data) => {
    return Api.axiosPost('api/sprint/agregar-sprint', data);
}

const editarSprint = async (data) => {
    return Api.axiosPut('api/sprint/editar-sprint', data);
}

const eliminarSprint = async (data) => {
    return Api.axiosDelete('api/sprint/eliminar-sprint', data);
}

export default {
    listarProyectos,
    listarSprints,
    agregarSprint,
    editarSprint,
    eliminarSprint,
};
