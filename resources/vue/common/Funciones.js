import moment from 'moment';
import Swal from 'sweetalert2';

const jsonToQueryString = function (json) {
    json = Object.keys(json).map(item => {
        return item + '=' + json[item] || '';
    });
    return json.join("&");
};

const ShowAlert = (type, title, message) => {
    const customSwal = Swal.mixin({
        customClass: {
            confirmButton: "btn btn-primary",
        },
        buttonsStyling: false
    });
    customSwal.fire({
        position: "center",
        icon: type,
        title: title,
        text: message,
        showConfirmButton: true,
        // confirmButtonClass: "text-secondary",
    });
}

const MostrarMensajeError = (title, message) => {
    return ShowAlert('error', title, message);
}

const MostrarMensajeExito = (title, message) => {
    return ShowAlert('success', title, message);
}

const MostrarMensajePregunta =  (text, callback, text_title = 'Eliminar') => {
    Swal.fire({
        title: text_title,
        text: text,
        icon: 'warning',
        showCancelButton: true,
        confirmButtonColor: '#3085d6',
        cancelButtonColor: '#d33',
        confirmButtonText: 'Si',
        cancelButtonText: 'No'
    }).then((result) => {
        if (result.isConfirmed) {
            callback();
        }
    })
}

const FormatearFechaHora = (fecha) => {
    const fechaFormateada = moment(fecha, "YYYY-MM-DD HH:mm:ss").format("DD/MM/YYYY hh:mm a");
    return fechaFormateada;
}

const FormatearFecha = (fecha) => {
    const fechaFormateada = moment(fecha, "YYYY-MM-DD HH:mm:ss").format("DD/MM/YYYY");
    return fechaFormateada;
}

// function FormatearFechaHora(fecha, hora) {
//     const fechaObj = moment(fecha + " " + hora);

//     let fechaFormateada = fechaObj.format('DD/MM/YYYY');
//     let horaFormateada = fechaObj.format('hh:mm A');

//     return {
//         fechaFormateada,
//         horaFormateada
//     };
// }

export default {
    jsonToQueryString,
    ShowAlert,
    MostrarMensajeError,
    MostrarMensajeExito,
    MostrarMensajePregunta,
    FormatearFechaHora,
    FormatearFecha,
    // FormatearFechaHora,
}
