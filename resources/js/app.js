import './bootstrap';

import { createApp } from "vue/dist/vue.esm-bundler";

import Login from '../vue/pages/Auth/Login.vue';
import Sprints from '../vue/pages/Web/Sprints.vue';
import RegistrarTareas from '../vue/pages/Web/RegistrarTareas.vue';
import MiPerfil from '../vue/pages/Web/MiPerfil.vue';
import Usuarios from '../vue/pages/Web/Usuarios.vue';

import Badge from '../vue/components/kanban/Badge.vue';
import TaskCard from '../vue/components/kanban/TaskCard.vue';

const app = createApp({});

app.component("login", Login);
app.component("sprints", Sprints);
app.component("registrar-tareas", RegistrarTareas);
app.component("mi-perfil", MiPerfil);
app.component("usuarios", Usuarios);

app.component("badge", Badge);
app.component("task-card", TaskCard);

const mountedApp = app.mount("#app");
