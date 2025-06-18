<template>
    <!-- <div class="mb-3">
        <h1 class="h3 d-inline align-middle">Usuarios</h1>
    </div> -->
    <div class="row mb-3 d-flex justify-content-center">
        <div class="col-10 col-lg-10">
            <div class="card">
                <div class="card-header text-center mt-4">
                    <!-- <h2 class="card-title mb-0">Lista de Usuarios</h2> -->
                    <h2 class="fw-light mb-0">Mi Perfil</h2>
                </div>
                <div class="card-body">
                    <div class="mb-3 form-floating">
                        <input type="text" class="form-control" id="floatingInputValue" placeholder="John Doe" value="Jairo Navez" />
                        <label for="floatingInputValue">Nombres</label>
                    </div>
                    <div class="mb-3 form-floating">
                        <input
                            type="email"
                            class="form-control"
                            id="floatingInputValue"
                            placeholder="name@example.com"
                            value="prueba1@example.com"
                        />
                        <label for="floatingInputValue">Email</label>
                    </div>
                    <div class="mb-3 form-check">
                        <input class="form-check-input" type="checkbox" value="" id="flexCheckChecked" checked />
                        <label class="form-check-label" for="flexCheckChecked"> Cambiar Contraseña</label>
                    </div>
                    <div class="mb-3 form-floating">
                        <input type="password" class="form-control" id="floatingInputValue" value="abc123" />
                        <label for="floatingInputValue">Contraseña</label>
                    </div>
                </div>
            </div>
        </div>
    </div>
</template>

<script setup></script>
