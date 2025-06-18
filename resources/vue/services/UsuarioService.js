import Api from './base/BaseRestService'

const listarUsuarios = async () => {
    return Api.axiosGet('api/usuarios/listar-usuarios');
}

const listarRoles = async () => {
    return Api.axiosGet('api/usuarios/listar-roles');
}

const agregarUsuario = async (data) => {
    return Api.axiosPost('api/usuarios/agregar-usuario', data);
}

const editarUsuario = async (data) => {
    return Api.axiosPut('api/usuarios/editar-usuario', data);
}

const activarUsuario = async (data) => {
    return Api.axiosPatch('api/usuarios/activar-usuario', data);
}

const desactivarUsuario = async (data) => {
    return Api.axiosPatch('api/usuarios/desactivar-usuario', data);
}

export default {
    listarUsuarios,
    listarRoles,
    agregarUsuario,
    editarUsuario,
    activarUsuario,
    desactivarUsuario,
};
