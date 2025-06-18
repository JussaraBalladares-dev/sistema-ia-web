import Funciones from '../common/Funciones';
import Api from './base/BaseRestService'

const obtenerValoresLiterales = async () => {
    return Api.axiosGet('api/tareas/obtener-valores-literales');
}

const listarTareas = async (data) => {
    const query = Funciones.jsonToQueryString(data);
    return Api.axiosGet('api/tareas/listar-tareas?' + query);
}

const agregarTarea = async (data) => {
    return Api.axiosPost('api/tareas/agregar-tarea', data);
}

const editarTarea = async (data) => {
    return Api.axiosPut('api/tareas/editar-tarea', data);
}

const actualizarEstadoTarea = async (data) => {
    return Api.axiosPatch('api/tareas/actualizar-estado-tarea', data);
}

const eliminarTarea = async (data) => {
    return Api.axiosDelete('api/tareas/eliminar-tarea', data);
}

const sugerirUsuarioTarea = async (data) => {
    return Api.axiosPost('api/tareas/sugerir-usuario-tarea', data);
}

export default {
    obtenerValoresLiterales,
    listarTareas,
    agregarTarea,
    editarTarea,
    actualizarEstadoTarea,
    eliminarTarea,
    sugerirUsuarioTarea,
};
