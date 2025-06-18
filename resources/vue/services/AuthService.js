import Api from './base/BaseRestService'

const login = async (data) => {
    return Api.axiosPost('api/login', data);
}

export default {
    login,
};
