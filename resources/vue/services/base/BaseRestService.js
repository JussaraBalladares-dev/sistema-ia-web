import axios from "axios";

const _axios = function (metodo, ruta, parametros) {
    return axios.request({
        method: metodo,
        url: ruta,
        data: parametros,
        headers: {
            "Access-Control-Allow-Origin": "*"
        }
    });
};

export default {
    axiosGet(ruta) {
        return _axios('get', ruta, null)
    },
    axiosPost(ruta, parametros) {
        return _axios('post', ruta, parametros)
    },
    axiosPut(ruta, parametros) {
        return _axios('put', ruta, parametros)
    },
    axiosDelete(ruta, parametros) {
        return _axios('delete', ruta, parametros)
    },
    axiosPatch(ruta, parametros) {
        return _axios('patch', ruta, parametros)
    },
}
