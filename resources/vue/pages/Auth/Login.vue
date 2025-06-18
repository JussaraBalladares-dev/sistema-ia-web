<template>
    <div class="d-table-cell align-middle">
        <div class="text-center mt-4">
            <h1 class="h2">Bienvenido</h1>
            <p class="lead">Ingresa tu email y contraseña para acceder</p>
        </div>

        <div class="card">
            <div class="card-body">
                <div class="m-sm-3">
                    <form @submit.prevent="iniciarSesion">
                        <div class="mb-3">
                            <label class="form-label">Email</label>
                            <input
                                v-model="email"
                                class="form-control form-control-lg"
                                type="email"
                                name="email"
                                placeholder="example@example.com"
                            />
                        </div>
                        <div class="mb-3">
                            <label class="form-label">Password</label>
                            <input
                                v-model="contrasena"
                                class="form-control form-control-lg"
                                type="password"
                                name="password"
                                placeholder="********"
                            />
                        </div>
                        <!-- <div>
                            <div class="form-check align-items-center">
                                <input
                                    id="customControlInline"
                                    type="checkbox"
                                    class="form-check-input"
                                    value="remember-me"
                                    name="remember-me"
                                    checked
                                />
                                <label class="form-check-label text-small" for="customControlInline">Remember me</label>
                            </div>
                        </div> -->
                        <div class="d-grid gap-2 mt-3">
                            <button type="submit" class="btn btn-lg btn-primary">Iniciar Sesión</button>
                            <!-- <a href="index.html" class="btn btn-lg btn-primary">Sign in</a> -->
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <!-- <div class="text-center mb-3">Don't have an account? <a href="pages-sign-up.html">Sign up</a></div> -->
    </div>
</template>

<script setup>
import { ref } from "vue";
import AuthService from "../../services/AuthService";
import Funciones from "../../common/Funciones";

// const email = ref("prueba1@example.com");
// const contrasena = ref("abc123");

const email = ref("");
const contrasena = ref("");

const iniciarSesion = async () => {
    const data = {
        email: email.value,
        contrasena: contrasena.value,
    };

    AuthService.login(data)
        .then((data) => {
            if (data.data.success) location.reload();
            else console.log(data.data.success);
        })
        .catch((e) => {
            if (e.response.data.message) Funciones.MostrarMensajeError("Alerta", e.response.data.message);
            else Funciones.MostrarMensajeError("Error", "Ocurrió un error, intente nuevamente");
        });
};
</script>
