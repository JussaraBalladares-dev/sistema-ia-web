CREATE DATABASE prueba_ia;
USE prueba_ia;


CREATE TABLE rol(
  id_rol  INT PRIMARY KEY AUTO_INCREMENT,
  descripcion varchar(100)
);


INSERT INTO rol (id_rol, descripcion)
VALUES
  (1, 'Lider TI'),
  (2, 'Desarrollador')
ON DUPLICATE KEY UPDATE
  descripcion = VALUES(descripcion);


CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
  id_rol int,
  nombres varchar(100),
  email varchar(100),
  contrasena varchar(500),
  flag_activo bit,
  fecha_registro datetime,
  fecha_editado datetime,
  FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);


INSERT INTO usuario (id_usuario, id_rol, nombres, email, contrasena, flag_activo, fecha_registro)
VALUES
  (1, 1, 'Jairo Navez',        'prueba1@example.com', 'eyJpdiI6Ii91Q0pCTUU4K1hEQVk1RGFxUVFPemc9PSIsInZhbHVlIjoidmV1Tjh0bFpGeFhPb2M0UFNQbjVodz09IiwibWFjIjoiMGFkNTZjMTgyNWViMWVkNTgwMDJkZTYzNzZjMmRjZmIyYzlkMmNjZmI2ZDVhOGUzYTFhOTNmMzJmYTVhMzI3NCIsInRhZyI6IiJ9', 0, NOW()),
  (2, 2, 'Jussara Balladares', 'prueba2@example.com', 'eyJpdiI6IjNjSXZHaWtEbFJCWkpXY0lFc3RUVGc9PSIsInZhbHVlIjoiZVRKT0dzVjQ4ZnpIOW1rcVIvUmQrQT09IiwibWFjIjoiNjI1YjJhMjc5N2FkZjhkOGMyNmQ0NmE2MzViOWQ0NmM5Y2Q3Yjk1M2ZjMGM3Y2NhOTQwNDkyMDk5ZDVkOWZlMiIsInRhZyI6IiJ9', 1, NOW()),
  (3, 2, 'Kleber Granados', 'prueba3@example.com', 'eyJpdiI6IjNjSXZHaWtEbFJCWkpXY0lFc3RUVGc9PSIsInZhbHVlIjoiZVRKT0dzVjQ4ZnpIOW1rcVIvUmQrQT09IiwibWFjIjoiNjI1YjJhMjc5N2FkZjhkOGMyNmQ0NmE2MzViOWQ0NmM5Y2Q3Yjk1M2ZjMGM3Y2NhOTQwNDkyMDk5ZDVkOWZlMiIsInRhZyI6IiJ9', 1, NOW())
ON DUPLICATE KEY UPDATE
  id_rol = VALUES(id_rol),
  nombres = VALUES(nombres),
  email = VALUES(email),
  contrasena = VALUES(contrasena),
  flag_activo = VALUES(flag_activo),
  fecha_registro = VALUES(fecha_registro);




CREATE TABLE proyecto(
  id_proyecto INT PRIMARY KEY AUTO_INCREMENT,
  descripcion varchar(100)
);


INSERT INTO proyecto(id_proyecto, descripcion)
VALUES
  (1, 'Hojas de Piso B2'),
  (2, 'Balance Metalùrgico')
ON DUPLICATE KEY UPDATE
  descripcion = VALUES(descripcion);



CREATE TABLE sprint(
  id_sprint INT PRIMARY KEY AUTO_INCREMENT,
  id_proyecto int,
  numero int,
  detalle varchar(100),
  fecha_inicio date,
  fecha_fin date,
  flag_activo bit,
  fecha_registro datetime,
  fecha_editado datetime,
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto)
);


INSERT INTO sprint(id_sprint, id_proyecto, numero, detalle, fecha_inicio, fecha_fin, flag_activo, fecha_registro)
VALUES
  (1, 1, 1, 'Mùdulo de seguridad',       '2025-01-01', '2025-01-31', 1, NOW()),
  (2, 1, 2, 'Mùdulo de notificaciones',  '2025-02-01', '2025-02-28', 1, NOW()),
  (3, 1, 3, 'Mùdulo de Reportes',        '2025-03-01', '2025-03-31', 1, NOW()),
  (4, 2, 1, 'Dashboard en Power BI',     '2025-01-01', '2025-04-30', 1, NOW())
ON DUPLICATE KEY UPDATE
  id_proyecto = VALUES(id_proyecto),
  numero = VALUES(numero),
  detalle = VALUES(detalle),
  fecha_inicio = VALUES(fecha_inicio),
  fecha_fin = VALUES(fecha_fin),
  flag_activo = VALUES(flag_activo),
  fecha_registro = VALUES(fecha_registro);



CREATE TABLE estado_tarea(
  id_estado_tarea int not NULL PRIMARY KEY AUTO_INCREMENT,
  descripcion varchar(50),
  orden int
);

INSERT INTO estado_tarea(id_estado_tarea, descripcion, orden)
VALUES
  (1, 'Pendiente', 1),
  (2, 'En curso', 2),
  (3, 'Completado', 3)
ON DUPLICATE KEY UPDATE
  descripcion = VALUES(descripcion),
  orden = VALUES(orden);


CREATE TABLE valor_literal(
  id_valor_literal int not NULL PRIMARY KEY AUTO_INCREMENT,
  descripcion varchar(200),
  tipo varchar(50),
  orden decimal(10, 2),
  peso_ia decimal(10, 2)
);

INSERT INTO valor_literal(id_valor_literal, descripcion, tipo, orden, peso_ia)
VALUES
  ( 1, 'Baja',   'prioridad', 3, 1),
  ( 2, 'Media',  'prioridad', 2, 3),
  ( 3, 'Alta',   'prioridad', 1, 5),
  ( 4, 'Gestiùn',  'habilidad', 1, 1),
  ( 5, 'Backend',  'habilidad', 2, 3),
  ( 6, 'Frontend', 'habilidad', 3, 5),
  ( 7, 'QA',       'habilidad', 4, 7),
  ( 8, 'Nada clara',          'tarea_clara', 5, 1),
  ( 9, 'Poco clara',          'tarea_clara', 4, 2),
  (10, 'Aceptable',           'tarea_clara', 3, 3),
  (11, 'Medianamente clara',  'tarea_clara', 2, 4),
  (12, 'Muy clara',           'tarea_clara', 1, 5),
  (13, 'Excesiva',      'carga_trabajo', 3, 1),
  (14, 'Aceptable',     'carga_trabajo', 2, 3),
  (15, 'Muy liviana',   'carga_trabajo', 1, 5),
  (16, 'Nada relacionado',          'adecuado_habilidades', 1, 1),
  (17, 'Medianamente relacionado',  'adecuado_habilidades', 2, 3),
  (18, 'Muy relacionado',           'adecuado_habilidades', 3, 5)
ON DUPLICATE KEY UPDATE
  descripcion = VALUES(descripcion),
  tipo = VALUES(tipo),
  orden = VALUES(orden),
  peso_ia = VALUES(peso_ia),
  orden = VALUES(orden);


CREATE TABLE tarea(
  id_tarea int not NULL PRIMARY KEY AUTO_INCREMENT,
  id_proyecto int,
  id_sprint INT,
  titulo varchar(100),
  descripcion varchar(200),
  valor_literal_prioridad int,
  valor_literal_habilidad int,
  tiempo_estimado decimal(10, 1),
  tiempo_real decimal(10, 1),
  porcentaje_avance decimal(10, 1),
  valor_literal_tarea_clara int,
  valor_literal_carga_trabajo int,
  valor_literal_adecuado_habilidades int,
  flag_activo bit,
  fecha_registro datetime,
  fecha_editado datetime,
  id_estado_tarea int,
  id_usuario_asignado int,
  FOREIGN KEY (id_proyecto) REFERENCES proyecto(id_proyecto),
  FOREIGN KEY (id_sprint) REFERENCES sprint(id_sprint),
  FOREIGN KEY (id_estado_tarea) REFERENCES estado_tarea(id_estado_tarea),
  FOREIGN KEY (id_usuario_asignado) REFERENCES usuario(id_usuario)
);





INSERT INTO tarea (id_tarea, id_proyecto, id_sprint, titulo, descripcion, valor_literal_prioridad, valor_literal_habilidad, tiempo_estimado, tiempo_real, porcentaje_avance,
valor_literal_tarea_clara, valor_literal_carga_trabajo, valor_literal_adecuado_habilidades, flag_activo, fecha_registro, fecha_editado, id_estado_tarea, id_usuario_asignado)
VALUES
  ( 1, 1, 1, 'Crear endpoint API', 'Usuarios -> POST /api/users', 2, 4, 6.0, 7.0, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 2, 1, 1, 'Diseùo landing page', 'Figma versiùn 2', 3, 6, 8.0, 6.5, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  ( 3, 1, 1, 'Revisar pull request', 'PR #23 de Juan', 1, 5, 2.0, 1.5, 100, 10, 15, 17, b'1', NOW(), NOW(), 3, 3),
  ( 4, 1, 1, 'Actualizar dependencias', 'npm audit fix', 3, 6, 1.5, 1.5, 100, 9, 14, 16, b'1', NOW(), NOW(), 3, 2),
  ( 5, 1, 1, 'Configuraciùn CI/CD', 'Deploy automùtico en main', 2, 7, 5.0, 4.5, 100, 12, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 6, 1, 1, 'Diseùar logo nuevo', 'Colores corporativos', 1, 4, 3.0, 3.0, 100, 8, 13, 17, b'1', NOW(), NOW(), 3, 2),
  ( 7, 1, 1, 'Test unitarios login', 'Cobertura > 90%', 2, 5, 4.0, 0.0, 0, 11, 15, 18, b'1', NOW(), NOW(), 1, 3),
  ( 8, 1, 1, 'Refactor de componente Sidebar', 'Optimizar reactividad', 3, 6, 3.5, 0.0, 0, 10, 14, 16, b'1', NOW(), NOW(), 1, 2),
  ( 9, 1, 1, 'Crear pruebas de integraciùn', 'Escenarios de extremo a extremo', 1, 4, 6.0, 2.5, 50, 9, 13, 17, b'1', NOW(), NOW(), 2, 3),
  ( 10, 1, 1, 'Implementar login JWT', 'Seguridad con token', 3, 7, 6.0, 6.0, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  ( 11, 1, 1, 'Integrar Stripe', 'Pagos con tarjeta', 2, 5, 5.0, 5.5, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  ( 12, 1, 1, 'Crear mùdulo usuarios', 'CRUD completo', 1, 4, 7.0, 7.0, 100, 12, 15, 17, b'1', NOW(), NOW(), 3, 3),
  ( 13, 1, 1, 'Diseùo de dashboard', 'UI Admin', 3, 6, 4.0, 3.8, 100, 9, 14, 16, b'1', NOW(), NOW(), 3, 2),
  ( 14, 1, 1, 'Configurar Docker', 'Contenedor backend', 2, 7, 2.0, 2.2, 100, 8, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 15, 1, 1, 'Actualizar documentaciùn', 'Wiki tùcnica', 1, 4, 1.5, 1.5, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 3),
  ( 16, 1, 1, 'Revisiùn de accesibilidad', 'WAVE y ARIA', 2, 5, 3.0, 2.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 17, 1, 1, 'Subida inicial a GitHub', 'Push main', 3, 6, 0.5, 0.5, 100, 9, 13, 16, b'1', NOW(), NOW(), 3, 2),
  ( 18, 1, 1, 'Crear entidades EF Core', 'Base de datos', 2, 7, 6.5, 6.8, 100, 11, 15, 17, b'1', NOW(), NOW(), 3, 3),
  ( 19, 1, 1, 'Test integraciùn frontend', 'e2e con Cypress', 1, 5, 5.0, 5.2, 100, 8, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 20, 1, 1, 'Agregar PWA manifest', 'Soporte offline', 3, 6, 2.0, 2.0, 100, 10, 15, 17, b'1', NOW(), NOW(), 3, 2),
  ( 21, 1, 1, 'Configurar ESLint + Prettier', 'Estilo de cùdigo', 2, 4, 1.0, 1.1, 100, 11, 14, 16, b'1', NOW(), NOW(), 3, 3),
  ( 22, 1, 1, 'Agregar sistema de roles', 'Admin/Usuario', 1, 5, 4.0, 4.0, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 23, 1, 1, 'Revisiùn legal privacidad', 'Tùrminos y condiciones', 2, 6, 2.5, 2.4, 100, 12, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 24, 1, 1, 'Crear mockups', 'Wireframes iniciales', 3, 4, 2.0, 2.2, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 25, 1, 1, 'Documentar API Swagger', 'Definiciones claras', 1, 7, 3.5, 3.5, 100, 10, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 26, 1, 1, 'Pruebas de carga', 'Apache JMeter', 2, 6, 5.0, 5.1, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 27, 1, 1, 'Agregar logs', 'Serilog + file output', 3, 5, 3.0, 3.0, 100, 9, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 28, 1, 1, 'Crear polùticas de backup', 'Automatizaciùn diaria', 1, 5, 3.0, 0.0, 0, 10, 15, 17, b'1', NOW(), NOW(), 1, 2),
  ( 29, 1, 1, 'Mejorar usabilidad mùvil', 'Diseùo responsive', 2, 6, 4.0, 0.0, 0, 11, 14, 16, b'1', NOW(), NOW(), 1, 3),
  ( 30, 1, 1, 'Auditorùa de seguridad', 'OWASP checklist', 3, 7, 6.0, 0.0, 0, 8, 14, 17, b'1', NOW(), NOW(), 1, 2),
  ( 31, 1, 1, 'Plan de pruebas', 'Casos QA', 2, 6, 3.0, 0.0, 0, 9, 13, 16, b'1', NOW(), NOW(), 1, 3),
  ( 32, 1, 1, 'Diseùar landing secundaria', 'Marketing', 1, 4, 4.5, 0.0, 0, 12, 13, 18, b'1', NOW(), NOW(), 1, 2),
  ( 33, 1, 1, 'Optimizar imùgenes', 'Compresiùn automùtica', 3, 5, 4.0, 2.0, 50, 10, 15, 17, b'1', NOW(), NOW(), 2, 3),
  ( 34, 1, 1, 'Integrar Google Analytics', 'Tracking de visitas', 2, 4, 2.5, 1.0, 25, 9, 13, 16, b'1', NOW(), NOW(), 2, 2),
  ( 35, 1, 1, 'Analizar requerimientos del cliente', 'Reuniùn con el cliente para definir alcance', 1, 4, 6.0, 5.5, 0, 10, 13, 16, b'1', NOW(), NOW(), 1, 2),
  ( 36, 1, 2, 'Diseùar la arquitectura de la soluciùn', 'Diagrama de alto nivel del sistema', 2, 7, 8.0, 7.2, 0, 11, 15, 18, b'1', NOW(), NOW(), 1, 3),
  ( 37, 1, 3, 'Codificar el mùdulo de autenticaciùn', 'Implementaciùn de login y registro', 3, 6, 12.0, 11.5, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 38, 1, 1, 'Probar la integraciùn con el API externo', 'Validar la comunicaciùn de datos', 2, 5, 4.0, 4.3, 80, 12, 13, 16, b'1', NOW(), NOW(), 2, 3),
  ( 39, 1, 2, 'Documentar la base de datos', 'Crear diccionario de datos y modelo ER', 1, 4, 7.0, 6.8, 100, 8, 15, 17, b'1', NOW(), NOW(), 3, 2),
  ( 40, 1, 2, 'Configurar Docker para desarrollo', 'Crear Dockerfile y docker-compose.yml', 2, 5, 4.0, 4.5, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 41, 1, 3, 'Corregir error en botùn Guardar', 'Issue #7 en Jira', 1, 4, 2.0, 1.8, 95, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  ( 42, 1, 1, 'Generar comprobante con Nubefact', 'Implementar API de facturaciùn electrùnica', 3, 6, 8.0, 8.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  ( 43, 1, 2, 'Integrar pasarela de pagos Culqi', 'Implementar API de pagos con tarjeta', 3, 7, 10.0, 9.2, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 44, 1, 3, 'Implementar autenticaciùn JWT', 'Asegurar endpoints de la API', 2, 6, 6.0, 6.8, 100, 8, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 45, 1, 2, 'Crear modelo de base de datos', 'Diagrama Entidad-Relaciùn para mùdulo de ventas', 2, 5, 7.0, 7.3, 100, 10, 14, 16, b'1', NOW(), NOW(), 3, 3),
  ( 46, 1, 1, 'Diseùar interfaz de usuario para dashboard', 'Mockups en Figma', 3, 4, 8.0, 7.5, 100, 11, 15, 17, b'1', NOW(), NOW(), 3, 2),
  ( 47, 1, 3, 'Implementar pruebas unitarias para servicio de usuarios', 'Cobertura mùnima del 80%', 2, 6, 5.0, 5.1, 100, 9, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 48, 1, 1, 'Refactorizar servicio de notificaciones', 'Mejorar rendimiento y escalabilidad', 3, 7, 9.0, 9.8, 100, 12, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 49, 1, 2, 'Crear documentaciùn de la API', 'Documentaciùn con Swagger', 2, 5, 6.0, 5.5, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 50, 1, 1, 'Investigar alternativas de cachù', 'Analizar Redis y Memcached', 1, 4, 3.0, 2.8, 0, 10, 13, 18, b'1', NOW(), NOW(), 1, 2),
  ( 51, 1, 3, 'Implementar logging centralizado', 'Integrar con Elasticsearch', 3, 6, 7.0, 6.9, 0, 11, 15, 16, b'1', NOW(), NOW(), 1, 3),
  ( 52, 1, 1, 'Definir arquitectura de microservicios', 'Diagrama de componentes', 2, 7, 10.0, 9.5, 0, 9, 14, 17, b'1', NOW(), NOW(), 1, 2),
  ( 53, 1, 2, 'Implementar sistema de colas con RabbitMQ', 'Procesamiento asùncrono de tareas', 3, 5, 8.0, 7.8, 0, 12, 13, 18, b'1', NOW(), NOW(), 1, 3),
  ( 54, 1, 3, 'Analizar rendimiento de la base de datos', 'Identificar cuellos de botella', 1, 4, 4.0, 3.9, 0, 10, 15, 16, b'1', NOW(), NOW(), 1, 2),
  ( 55, 1, 1, 'Crear script de migraciùn de datos', 'Migrar datos de la versiùn anterior', 2, 6, 6.0, 5.7, 60, 8, 14, 17, b'1', NOW(), NOW(), 2, 3),
  ( 56, 1, 2, 'Desarrollar mùdulo de reportes', 'Generar informes en PDF', 3, 5, 9.0, 8.6, 70, 11, 13, 18, b'1', NOW(), NOW(), 2, 2),
  ( 57, 1, 3, 'Implementar sistema de alertas por correo electrùnico', 'Notificaciones automùticas', 2, 7, 5.0, 5.3, 80, 9, 15, 16, b'1', NOW(), NOW(), 2, 3),
  ( 58, 1, 2, 'Integrar con API externa de geolocalizaciùn', 'Obtener coordenadas de usuarios', 3, 4, 7.0, 6.5, 90, 12, 14, 17, b'1', NOW(), NOW(), 2, 2),
  ( 59, 1, 1, 'Optimizar consultas SQL', 'Mejorar tiempos de respuesta de la API', 2, 6, 4.0, 4.2, 50, 10, 13, 18, b'1', NOW(), NOW(), 2, 3),
  ( 60, 1, 2, 'Implementar pruebas E2E con Cypress', 'Validar flujo completo de usuario', 3, 5, 10.0, 9.7, 100, 11, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 61, 1, 3, 'Configurar balanceador de carga', 'Distribuir trùfico entre servidores', 2, 7, 6.0, 6.1, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 62, 1, 1, 'Crear script de despliegue en AWS', 'Automatizar la implementaciùn', 3, 4, 8.0, 7.9, 100, 12, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 63, 1, 2, 'Implementar mùtricas con Prometheus y Grafana', 'Monitoreo del sistema', 2, 6, 5.0, 5.4, 100, 10, 15, 16, b'1', NOW(), NOW(), 3, 3),
  ( 64, 1, 1, 'Refactorizar componente de autenticaciùn', 'Mejorar seguridad', 3, 5, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 65, 1, 3, 'Documentar API con OpenAPI', 'Generar documentaciùn automùtica', 2, 7, 4.0, 4.1, 100, 8, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 66, 1, 1, 'Implementar sistema de versionamiento de API', 'Soportar mùltiples versiones', 3, 4, 7.0, 6.7, 0, 12, 15, 16, b'1', NOW(), NOW(), 1, 2),
  ( 67, 1, 2, 'Analizar y optimizar rendimiento frontend', 'Mejorar tiempos de carga', 2, 6, 6.0, 5.9, 0, 10, 14, 17, b'1', NOW(), NOW(), 1, 3),
  ( 68, 1, 3, 'Implementar internacionalizaciùn (i18n)', 'Soportar mùltiples idiomas', 3, 5, 8.0, 7.7, 0, 11, 13, 18, b'1', NOW(), NOW(), 1, 2),
  ( 69, 1, 1, 'Configurar firewall', 'Asegurar acceso al servidor', 2, 7, 4.0, 4.3, 0, 9, 15, 16, b'1', NOW(), NOW(), 1, 3),
  ( 70, 1, 2, 'Implementar pruebas de integraciùn', 'Validar interacciùn entre mùdulos', 3, 4, 9.0, 8.5, 75, 12, 14, 17, b'1', NOW(), NOW(), 2, 2),
  ( 71, 1, 3, 'Implementar cachù con Redis', 'Mejorar tiempos de respuesta de consultas frecuentes', 2, 6, 5.0, 5.2, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 72, 1, 1, 'Refactorizar componente de tabla', 'Mejorar rendimiento y usabilidad', 3, 5, 7.0, 6.8, 100, 11, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 73, 1, 2, 'Implementar pruebas de accesibilidad', 'Cumplir con WCAG 2.1 AA', 2, 7, 6.0, 6.3, 100, 9, 15, 16, b'1', NOW(), NOW(), 3, 3),
  ( 74, 1, 1, 'Integrar con sistema de email marketing', 'Enviar notificaciones a usuarios', 3, 4, 8.0, 7.9, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 75, 1, 3, 'Crear script para respaldo de base de datos', 'Automatizar backups diarios', 2, 6, 4.0, 4.1, 100, 10, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 76, 1, 2, 'Implementar sistema de colas con Kafka', 'Procesamiento de eventos en tiempo real', 3, 7, 9.0, 9.5, 100, 11, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 77, 1, 1, 'Analizar y optimizar consultas NoSQL', 'Mejorar rendimiento de MongoDB', 2, 5, 5.0, 4.8, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 78, 1, 3, 'Implementar sistema de control de versiones de documentos', 'Integrar con Git LFS', 3, 4, 7.0, 7.1, 100, 12, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 79, 1, 2, 'Configurar servidor web con Nginx', 'Optimizar la configuraciùn', 2, 6, 4.0, 3.9, 100, 10, 15, 16, b'1', NOW(), NOW(), 3, 3),
  ( 80, 1, 1, 'Implementar pruebas de rendimiento con JMeter', 'Evaluar la escalabilidad del API', 3, 5, 10.0, 9.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 81, 1, 3, 'Crear dashboard de mùtricas del sistema', 'Visualizar el rendimiento en tiempo real', 2, 7, 6.0, 6.2, 100, 9, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 82, 1, 2, 'Implementar sistema de logs con ELK Stack', 'Centralizar y analizar logs', 3, 4, 8.0, 8.1, 100, 12, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 83, 1, 1, 'Refactorizar cùdigo legado', 'Mejorar la mantenibilidad', 2, 6, 7.0, 6.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 84, 1, 3, 'Implementar sistema de autorizaciùn con OAuth2', 'Asegurar el acceso a los recursos', 3, 5, 5.0, 5.1, 100, 11, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 85, 1, 2, 'Crear script para limpieza de datos antiguos', 'Automatizar la eliminaciùn de datos obsoletos', 2, 7, 4.0, 4.2, 100, 9, 15, 16, b'1', NOW(), NOW(), 3, 3),
  ( 86, 1, 1, 'Implementar pruebas de humo', 'Verificar la funcionalidad bùsica', 3, 4, 3.0, 3.1, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 87, 1, 3, 'Configurar DNS', 'Gestionar los registros de dominio', 2, 6, 2.0, 1.8, 100, 10, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 88, 1, 2, 'Implementar sistema de monitoreo de salud del API', 'Alertas automùticas en caso de fallas', 3, 5, 7.0, 7.3, 100, 11, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 89, 1, 1, 'Refactorizar estilos CSS', 'Mejorar la consistencia visual', 2, 7, 5.0, 4.9, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 90, 1, 3, 'Implementar sistema de seguimiento de errores con Sentry', 'Capturar y analizar errores', 3, 4, 6.0, 6.1, 100, 12, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 91, 1, 2, 'Crear script para rotaciùn de logs', 'Gestionar el tamaùo de los archivos de log', 2, 6, 3.0, 3.2, 0, 10, 15, 16, b'1', NOW(), NOW(), 1, 3),
  ( 92, 1, 1, 'Analizar y optimizar imùgenes', 'Mejorar el tiempo de carga del frontend', 3, 5, 4.0, 3.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 93, 1, 3, 'Implementar pruebas de regresiùn', 'Asegurar la estabilidad despuùs de cambios', 2, 7, 7.0, 7.5, 100, 9, 13, 18, b'1', NOW(), NOW(), 3, 3),
  ( 94, 1, 2, 'Configurar balanceo de carga para base de datos', 'Mejorar la disponibilidad de la base de datos', 3, 4, 8.0, 7.9, 100, 12, 15, 16, b'1', NOW(), NOW(), 3, 2),
  ( 95, 1, 1, 'Implementar sistema de backups incrementales', 'Optimizar el espacio de almacenamiento de backups', 2, 6, 5.0, 5.3, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  ( 96, 1, 3, 'Crear script para anùlisis de logs', 'Identificar patrones y errores', 3, 5, 6.0, 5.8, 100, 11, 13, 18, b'1', NOW(), NOW(), 3, 2),
  ( 97, 1, 2, 'Implementar sistema de auditorùa', 'Registrar acciones importantes del sistema', 2, 7, 9.0, 9.2, 100, 9, 15, 16, b'1', NOW(), NOW(), 3, 3),
  ( 98, 1, 1, 'Refactorizar API para RESTful', 'Mejorar la arquitectura de la API', 3, 4, 7.0, 6.9, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  ( 99, 1, 3, 'Implementar sistema de gestiùn de secretos', 'Almacenar credenciales de forma segura', 2, 6, 4.0, 4.1, 100, 10, 13, 18, b'1', NOW(), NOW(), 3, 3),
  (100, 1, 2, 'Crear documentaciùn tùcnica detallada', 'Manual de usuario y guùa de implementaciùn', 3, 5, 10.0, 9.7, 100, 11, 15, 16, b'1', NOW(), NOW(), 3, 2),
  (101, 1, 1, 'Implementar Autenticaciùn de Dos Factores', 'Aùadir capa de seguridad con TOTP', 2, 6, 8.0, 7.5, 100, 9, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (102, 1, 2, 'Crear API para Gestiùn de Pedidos', 'Endpoints para crear, leer, actualizar y eliminar pedidos', 3, 7, 12.0, 11.8, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (103, 1, 1, 'Diseùar Dashboard de Ventas', 'Mockups para visualizar mùtricas clave de ventas', 1, 5, 6.0, 5.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (104, 1, 3, 'Integrar con Servicio de SMS', 'Enviar notificaciones por SMS a usuarios', 2, 4, 4.0, 4.2, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (105, 1, 2, 'Refactorizar Componente de Formulario', 'Mejorar la reutilizaciùn y validaciùn', 3, 6, 7.0, 6.8, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (106, 1, 1, 'Implementar Bùsqueda Avanzada de Productos', 'Permitir filtrar por mùltiples criterios', 1, 7, 9.0, 8.7, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (107, 1, 2, 'Crear Directiva para Subida de Archivos', 'Permitir la carga de diferentes tipos de archivos', 2, 5, 5.0, 5.1, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (108, 1, 3, 'Integrar con Pasarela de Pago PayPal', 'Aùadir mùtodo de pago con PayPal', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (109, 1, 2, 'Diseùar Panel de Administraciùn de Usuarios', 'Mockups para gestionar usuarios y roles', 1, 6, 7.5, 7.3, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (110, 1, 1, 'Implementar Paginaciùn en Resultados de Bùsqueda', 'Mostrar resultados en mùltiples pùginas', 2, 7, 4.5, 4.3, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (111, 1, 3, 'Refactorizar Servicio de Email', 'Mejorar la gestiùn de plantillas y envùo', 3, 5, 6.5, 6.2, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (112, 1, 2, 'Implementar Sistema de Recomendaciones de Productos', 'Sugerir productos basados en el historial de compras', 1, 4, 9.5, 9.1, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (113, 1, 2, 'Crear Componente de Notificaciones en Tiempo Real', 'Mostrar alertas a los usuarios en tiempo real', 2, 6, 5.5, 5.3, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (114, 1, 1, 'Integrar con Servicio de Geolocalizaciùn', 'Mostrar la ubicaciùn de los usuarios en un mapa', 3, 7, 7.0, 6.9, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (115, 1, 3, 'Diseùar Interfaz para Gestiùn de Inventario', 'Mockups para administrar el stock de productos', 1, 5, 6.0, 5.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (116, 1, 3, 'Implementar Pruebas de Integraciùn Continua', 'Configurar Jenkins para ejecutar pruebas automùticamente', 2, 4, 8.5, 8.2, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (117, 1, 2, 'Refactorizar Componente de Tabla Dinùmica', 'Mejorar la manipulaciùn y visualizaciùn de datos', 3, 6, 7.5, 7.1, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (118, 1, 1, 'Implementar Sistema de Reportes en PDF', 'Generar informes descargables en formato PDF', 1, 7, 9.0, 8.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (119, 1, 1, 'Crear Directiva para Formato de Fecha', 'Mostrar fechas en diferentes formatos', 2, 5, 4.0, 3.8, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (120, 1, 3, 'Integrar con Servicio de Analùtica Web', 'Enviar datos a Google Analytics', 3, 4, 6.0, 5.7, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (121, 1, 2, 'Refactorizar Servicio de Autenticaciùn', 'Implementar JWT para la API', 2, 6, 7.0, 6.6, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (122, 1, 1, 'Implementar Sistema de Gestiùn de Roles y Permisos', 'Controlar el acceso a diferentes funcionalidades', 1, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (123, 1, 3, 'Crear Componente de Breadcrumbs', 'Mostrar la ruta de navegaciùn del usuario', 2, 5, 3.0, 2.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (124, 1, 2, 'Integrar con Servicio de Almacenamiento en la Nube', 'Subir y descargar archivos a AWS S3', 3, 4, 6.0, 5.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (125, 1, 1, 'Refactorizar Servicio de Logging', 'Implementar un sistema de logging mùs robusto', 1, 6, 7.0, 6.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (126, 1, 1, 'Implementar Pruebas Unitarias para Servicio de Usuarios', 'Asegurar la correcta funcionalidad del servicio', 2, 7, 5.0, 4.9, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (127, 1, 3, 'Crear Directiva para Formato de Moneda', 'Mostrar valores monetarios con el formato correcto', 3, 5, 4.0, 3.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (128, 1, 2, 'Integrar con Servicio de Traducciùn', 'Permitir la traducciùn de la interfaz a mùltiples idiomas', 1, 4, 9.0, 8.7, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (129, 1, 2, 'Refactorizar Componente de Modal', 'Mejorar la usabilidad y accesibilidad de las ventanas modales', 2, 6, 5.0, 4.8, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (130, 1, 1, 'Implementar Sistema de Gestiùn de Errores', 'Capturar y mostrar errores de forma amigable', 3, 7, 7.0, 6.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (131, 1, 3, 'Crear Directiva para Validaciùn de Email', 'Asegurar el formato correcto de los correos electrùnicos', 2, 5, 3.0, 2.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (132, 1, 2, 'Integrar con Servicio de Mapas con Marcadores Personalizados', 'Mostrar ubicaciones especùficas con iconos personalizados', 1, 4, 6.0, 5.8, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (133, 1, 1, 'Refactorizar Servicio de Bùsqueda', 'Mejorar la eficiencia y la relevancia de los resultados', 2, 6, 7.0, 6.7, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (134, 1, 3, 'Implementar Sistema de Gestiùn de Sesiones', 'Manejar las sesiones de usuario de forma segura', 3, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (135, 1, 1, 'Crear Componente de Paginaciùn Personalizado', 'Adaptar la paginaciùn a los requerimientos del diseùo', 1, 5, 4.0, 3.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (136, 1, 2, 'Integrar con Servicio de Streaming de Video', 'Mostrar videos en la plataforma', 2, 4, 6.0, 5.7, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (137, 1, 1, 'Refactorizar Directiva de Subida de Archivos', 'Aùadir validaciones de tamaùo y tipo de archivo', 3, 6, 7.0, 6.6, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (138, 1, 3, 'Implementar Sistema de Calificaciùn de Productos', 'Permitir a los usuarios calificar los productos', 1, 7, 9.0, 8.9, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (139, 1, 3, 'Crear Componente de Barra de Progreso', 'Mostrar el avance de las tareas', 2, 5, 3.0, 2.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (140, 1, 2, 'Integrar con Servicio de Chat en Vivo', 'Permitir la comunicaciùn con soporte en tiempo real', 3, 4, 6.0, 5.7, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (141, 1, 1, 'Refactorizar Servicio de Geolocalizaciùn', 'Optimizar la precisiùn y el rendimiento', 2, 6, 7.0, 6.6, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (142, 1, 3, 'Implementar Sistema de Favoritos', 'Permitir a los usuarios guardar productos favoritos', 1, 7, 9.0, 8.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (143, 1, 2, 'Crear Componente de Selector de Fechas', 'Permitir la selecciùn de rangos de fechas', 2, 5, 4.0, 3.8, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (144, 1, 1, 'Integrar con Servicio de Email Transaccional', 'Enviar correos electrùnicos de confirmaciùn y restablecimiento de contraseùa', 3, 4, 6.0, 5.7, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (145, 1, 2, 'Refactorizar Servicio de Gestiùn de Errores', 'Implementar un sistema de seguimiento de errores', 1, 6, 7.0, 6.6, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (146, 1, 3, 'Implementar Pruebas de Aceptaciùn del Usuario (UAT)', 'Validar las funcionalidades con los usuarios finales', 2, 7, 9.0, 8.9, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (147, 1, 2, 'Crear Componente de Tabla Editable', 'Permitir la ediciùn de datos directamente en la tabla', 3, 5, 6.0, 5.7, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (148, 1, 2, 'Crear Componente de Tarjetas Interactivas', 'Mostrar informaciùn de forma dinùmica al interactuar', 3, 5, 6.0, 5.8, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (149, 1, 2, 'Refactorizar Directiva de Formato de Moneda', 'Aùadir soporte para diferentes divisas', 2, 6, 5.0, 4.8, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (150, 1, 3, 'Implementar Sistema de Historial de Navegaciùn', 'Permitir a los usuarios ver su actividad reciente', 3, 7, 7.0, 6.9, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (151, 1, 1, 'Crear Componente de Carrusel de Productos', 'Mostrar productos relacionados o destacados', 1, 5, 6.0, 5.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (152, 1, 1, 'Integrar con Servicio de Video Conferencia', 'Permitir reuniones virtuales dentro de la plataforma', 2, 4, 9.0, 8.7, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (153, 1, 2, 'Refactorizar Servicio de Validaciùn', 'Centralizar y mejorar la lùgica de validaciùn', 3, 6, 5.0, 4.9, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (154, 1, 3, 'Implementar Sistema de Wishlist', 'Permitir a los usuarios guardar productos para mùs tarde', 1, 7, 7.0, 6.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (155, 1, 2, 'Crear Directiva para Autocompletado', 'Sugerir opciones mientras el usuario escribe', 2, 5, 4.0, 3.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (156, 1, 1, 'Integrar con Servicio de Firma Electrùnica', 'Permitir la firma de documentos digitalmente', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (157, 1, 2, 'Diseùar Panel de Control de Suscripciones', 'Mockups para gestionar las suscripciones de los usuarios', 1, 6, 6.0, 5.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (158, 1, 3, 'Implementar Sistema de Traducciùn Automùtica', 'Traducir el contenido a diferentes idiomas', 2, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (159, 1, 2, 'Refactorizar Servicio de Reportes', 'Mejorar la generaciùn y personalizaciùn de informes', 3, 5, 7.0, 6.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (160, 1, 1, 'Implementar Sistema de Alertas Personalizadas', 'Permitir a los usuarios configurar sus propias alertas', 1, 4, 6.0, 5.7, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (161, 1, 2, 'Crear Componente de Calendario', 'Mostrar eventos y permitir la selecciùn de fechas', 2, 6, 8.0, 7.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (162, 1, 3, 'Integrar con Servicio de Reconocimiento de Voz', 'Permitir la interacciùn con la plataforma mediante la voz', 3, 7, 10.0, 9.8, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (163, 1, 2, 'Diseùar Interfaz para Gestiùn de Pagos', 'Mockups para administrar las transacciones de los usuarios', 1, 5, 6.0, 5.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (164, 1, 1, 'Implementar Sistema de Invitaciones', 'Permitir a los usuarios invitar a otros a la plataforma', 2, 4, 5.0, 4.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (165, 1, 2, 'Refactorizar Servicio de Bùsqueda por Voz', 'Mejorar la precisiùn y la comprensiùn del lenguaje', 3, 6, 7.0, 6.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (166, 1, 3, 'Implementar Sistema de Gestiùn de Tickets de Soporte', 'Permitir a los usuarios crear y seguir tickets', 1, 7, 9.0, 8.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (167, 1, 2, 'Crear Componente de Grùficos', 'Visualizar datos mediante diferentes tipos de grùficos', 2, 5, 6.0, 5.8, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (168, 1, 1, 'Integrar con Servicio de Videollamadas', 'Permitir llamadas de audio y video dentro de la plataforma', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (169, 1, 3, 'Refactorizar Servicio de Notificaciones Push', 'Mejorar la entrega y personalizaciùn de notificaciones', 2, 6, 5.0, 4.9, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (170, 1, 2, 'Implementar Sistema de Foros de Discusiùn', 'Permitir a los usuarios interactuar y compartir ideas', 1, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (171, 1, 1, 'Crear Componente de Mapa Interactivo', 'Mostrar informaciùn adicional al interactuar con el mapa', 2, 5, 7.0, 6.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (172, 1, 3, 'Integrar con Servicio de Reconocimiento de Imùgenes', 'Analizar el contenido de las imùgenes cargadas', 3, 4, 8.0, 7.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (173, 1, 2, 'Refactorizar Servicio de Gestiùn de Sesiones', 'Mejorar la seguridad y la persistencia de las sesiones', 1, 6, 6.0, 5.9, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (174, 1, 2, 'Implementar Sistema de Encuestas', 'Permitir a los usuarios responder preguntas y recopilar datos', 2, 7, 9.0, 8.7, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (175, 1, 1, 'Crear Componente de Timeline', 'Mostrar eventos en orden cronolùgico', 3, 5, 5.0, 4.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (176, 1, 3, 'Integrar con Servicio de Recomendaciùn de Contenido', 'Sugerir artùculos o videos relevantes a los usuarios', 1, 4, 7.0, 6.9, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (177, 1, 2, 'Refactorizar Servicio de Generaciùn de Informes', 'Aùadir la capacidad de exportar a diferentes formatos', 2, 6, 8.0, 7.8, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (178, 1, 1, 'Implementar Sistema de Gestiùn de Anuncios', 'Permitir la creaciùn y visualizaciùn de anuncios', 3, 7, 9.0, 8.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (179, 1, 3, 'Crear Componente de Mapa de Calor', 'Visualizar la densidad de datos en un mapa', 1, 5, 6.0, 5.7, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (180, 1, 2, 'Integrar con Servicio de Firma Digital', 'Permitir la firma de documentos con certificados digitales', 2, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (181, 1, 1, 'Refactorizar Servicio de Autocompletado', 'Mejorar la precisiùn y la velocidad de las sugerencias', 3, 6, 5.0, 4.9, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (182, 1, 3, 'Implementar Sistema de Gestiùn de Eventos', 'Permitir la creaciùn y visualizaciùn de eventos', 1, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (183, 1, 2, 'Crear Componente de Acordeùn', 'Mostrar contenido oculto de forma expandible', 2, 5, 3.0, 2.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (184, 1, 1, 'Integrar con Servicio de Generaciùn de Cùdigos QR', 'Generar cùdigos QR para diferentes propùsitos', 3, 4, 6.0, 5.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (185, 1, 3, 'Refactorizar Servicio de Traducciùn Automùtica', 'Mejorar la calidad y la fluidez de las traducciones', 1, 6, 7.0, 6.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (186, 1, 2, 'Implementar Sistema de Chatbot', 'Permitir la interacciùn con un asistente virtual', 2, 7, 9.0, 8.9, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (187, 1, 1, 'Crear Componente de Slider de Imùgenes', 'Mostrar imùgenes de forma secuencial y animada', 3, 5, 5.0, 4.8, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (188, 1, 3, 'Integrar con Servicio de Reconocimiento Facial', 'Permitir la autenticaciùn mediante reconocimiento facial', 1, 4, 7.0, 6.9, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (189, 1, 2, 'Refactorizar Servicio de Recomendaciùn de Contenido', 'Mejorar la personalizaciùn de las sugerencias', 2, 6, 8.0, 7.8, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (190, 1, 1, 'Implementar Sistema de Gestiùn de Notificaciones In-App', 'Mostrar notificaciones dentro de la aplicaciùn', 3, 7, 9.0, 8.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (191, 1, 3, 'Crear Componente de ùrbol de Navegaciùn', 'Mostrar la estructura jerùrquica de la informaciùn', 2, 5, 6.0, 5.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (192, 1, 2, 'Integrar con Servicio de Firma de Documentos', 'Permitir la firma de documentos directamente en la plataforma', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (193, 1, 1, 'Refactorizar Servicio de Gestiùn de Anuncios', 'Aùadir la capacidad de segmentar anuncios', 1, 6, 7.0, 6.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (194, 1, 3, 'Implementar Sistema de Gestiùn de Cookies', 'Mostrar el banner de cookies y gestionar el consentimiento', 2, 7, 5.0, 4.9, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (195, 1, 1, 'Crear Componente de Tarjetas Interactivas', 'Mostrar informaciùn de forma dinùmica al interactuar', 1, 4, 7.0, 6.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (196, 1, 2, 'Refactorizar Servicio de Gestiùn de Usuarios', 'Mejorar la seguridad y la gestiùn de perfiles', 2, 6, 8.0, 7.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (197, 1, 3, 'Implementar Sistema de Gestiùn de Inventario Avanzado', 'Controlar stock, movimientos y alertas', 3, 7, 12.0, 11.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (198, 1, 2, 'Diseùar Panel de Reportes Personalizados', 'Mockups para crear y visualizar informes customizados', 1, 5, 6.0, 5.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (199, 1, 1, 'Integrar con Servicio de Calendario Externo', 'Sincronizar eventos con Google Calendar', 2, 4, 5.0, 4.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (200, 1, 3, 'Refactorizar Componente de Navegaciùn Mùvil', 'Mejorar la usabilidad en dispositivos mùviles', 3, 6, 7.0, 6.8, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (201, 1, 2, 'Implementar Sistema de Gestiùn de Permisos Avanzado', 'Control de acceso granular a funcionalidades', 1, 7, 9.0, 8.7, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (202, 1, 2, 'Crear Directiva para Formato de Nùmero', 'Mostrar nùmeros con separadores de miles y decimales', 2, 5, 4.0, 3.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (203, 1, 1, 'Integrar con Servicio de Firma Digital Remota', 'Permitir la firma de documentos desde cualquier lugar', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (204, 1, 3, 'Diseùar Panel de Control de Alertas', 'Mockups para gestionar las alertas del sistema', 1, 6, 6.0, 5.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (205, 1, 3, 'Implementar Sistema de Versionamiento de APIs', 'Soportar mùltiples versiones de la API', 2, 7, 9.0, 8.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (206, 1, 2, 'Refactorizar Servicio de Email Marketing', 'Mejorar la segmentaciùn y personalizaciùn de emails', 3, 5, 7.0, 6.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (207, 1, 1, 'Implementar Sistema de Gestiùn de Tareas Recurrentes', 'Programar tareas automùticas', 1, 4, 6.0, 5.7, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (208, 1, 2, 'Crear Componente de Diagrama de Flujo', 'Visualizar procesos mediante diagramas interactivos', 2, 6, 8.0, 7.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (209, 1, 3, 'Integrar con Servicio de Traducciùn Profesional', 'Permitir la traducciùn por traductores humanos', 3, 7, 10.0, 9.8, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (210, 1, 2, 'Diseùar Interfaz para Gestiùn de Contenido', 'Mockups para administrar textos, imùgenes y videos', 1, 5, 6.0, 5.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (211, 1, 1, 'Implementar Sistema de Encuestas Avanzado', 'Permitir diferentes tipos de preguntas y lùgica condicional', 2, 4, 7.0, 6.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (212, 1, 3, 'Refactorizar Servicio de Recomendaciùn de Contenido', 'Aùadir algoritmos de filtrado colaborativo', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (213, 1, 2, 'Implementar Sistema de Gestiùn de Documentos', 'Permitir la carga, visualizaciùn y descarga de documentos', 1, 7, 9.0, 8.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (214, 1, 2, 'Crear Componente de Selector de Tiempo', 'Permitir la selecciùn de horas y minutos', 2, 5, 3.0, 2.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (215, 1, 1, 'Integrar con Servicio de Firma Biomùtrica', 'Permitir la firma de documentos con huella digital', 3, 4, 6.0, 5.8, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (216, 1, 3, 'Refactorizar Servicio de Gestiùn de Tickets', 'Aùadir la capacidad de asignar prioridades y categorùas', 1, 6, 7.0, 6.7, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (217, 1, 3, 'Implementar Sistema de Gestiùn de Proyectos', 'Permitir la creaciùn y seguimiento de proyectos', 2, 7, 10.0, 9.8, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (218, 1, 2, 'Crear Componente de Barra Lateral Desplegable', 'Mostrar opciones de navegaciùn de forma compacta', 3, 5, 4.0, 3.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (219, 1, 1, 'Integrar con Servicio de Reconocimiento de Texto (OCR)', 'Extraer texto de imùgenes o documentos', 1, 4, 7.0, 6.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (220, 1, 1, 'Refactorizar Servicio de Autenticaciùn de Dos Factores', 'Aùadir soporte para mùltiples mùtodos (SMS, Email)', 2, 6, 9.0, 8.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (221, 1, 3, 'Implementar Sistema de Gestiùn de Reservas', 'Permitir a los usuarios realizar reservas de recursos', 3, 7, 11.0, 10.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (222, 1, 2, 'Crear Componente de Tabla con Filtros Avanzados', 'Permitir el filtrado de datos por mùltiples columnas', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (223, 1, 2, 'Integrar con Servicio de Generaciùn de Informes Programados', 'Enviar informes automùticamente por correo electrùnico', 2, 4, 6.0, 5.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (224, 1, 1, 'Refactorizar Servicio de Gestiùn de Pedidos', 'Aùadir la capacidad de cancelar o modificar pedidos', 3, 6, 8.0, 7.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (225, 1, 3, 'Implementar Sistema de Gestiùn de Incidencias', 'Permitir a los usuarios reportar y seguir incidencias', 1, 7, 9.0, 8.9, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (226, 1, 3, 'Crear Componente de Diagrama de Gantt', 'Visualizar la planificaciùn de proyectos', 2, 5, 10.0, 9.8, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (227, 1, 2, 'Integrar con Servicio de Firma de Cùdigo', 'Asegurar la integridad del cùdigo desplegado', 3, 4, 5.0, 4.8, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (228, 1, 1, 'Refactorizar Servicio de Gestiùn de Documentos', 'Aùadir control de versiones y permisos', 1, 6, 7.0, 6.7, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (229, 1, 1, 'Implementar Sistema de Gestiùn de Conocimiento', 'Crear una base de datos de artùculos y preguntas frecuentes', 2, 7, 11.0, 10.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (230, 1, 3, 'Crear Componente de Selector de Color', 'Permitir la selecciùn de colores personalizados', 3, 5, 3.0, 2.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (231, 1, 2, 'Integrar con Servicio de Reconocimiento de Voz Avanzado', 'Soportar comandos de voz complejos', 1, 4, 8.0, 7.9, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (232, 1, 2, 'Refactorizar Servicio de Gestiùn de Sesiones', 'Implementar invalidaciùn de sesiones y control de concurrencia', 2, 6, 9.0, 8.8, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (233, 1, 1, 'Implementar Sistema de Gestiùn de Campaùas', 'Permitir la creaciùn y seguimiento de campaùas de marketing', 3, 7, 13.0, 12.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (234, 1, 3, 'Crear Componente de Mapa con Marcadores Agrupados', 'Mostrar mùltiples ubicaciones en un mapa de forma organizada', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (235, 1, 3, 'Integrar con Servicio de Generaciùn de Documentos', 'Generar documentos dinùmicamente (PDF, Word)', 2, 4, 6.0, 5.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (236, 1, 2, 'Refactorizar Servicio de Gestiùn de Permisos Avanzado', 'Implementar herencia de permisos y roles personalizados', 3, 6, 8.0, 7.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (237, 1, 1, 'Implementar Sistema de Gestiùn de Activos', 'Permitir el seguimiento y la gestiùn de activos de la empresa', 1, 7, 10.0, 9.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (238, 1, 2, 'Crear Componente de Editor de Texto Enriquecido', 'Permitir la ediciùn de texto con formato (WYSIWYG)', 2, 5, 9.0, 8.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (239, 1, 3, 'Integrar con Servicio de Anùlisis de Sentimiento', 'Analizar el sentimiento de los comentarios de los usuarios', 3, 4, 6.0, 5.7, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (240, 1, 2, 'Refactorizar Servicio de Gestiùn de Tareas Recurrentes', 'Aùadir la capacidad de programar tareas complejas', 1, 6, 7.0, 6.6, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (241, 1, 1, 'Implementar Sistema de Gestiùn de Flujos de Trabajo', 'Permitir la definiciùn y seguimiento de flujos de trabajo', 2, 7, 12.0, 11.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (242, 1, 3, 'Crear Componente de Diagrama de Sankey', 'Visualizar flujos de datos o energùa', 3, 5, 8.0, 7.8, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (243, 1, 2, 'Integrar con Servicio de Traducciùn en Tiempo Real', 'Traducir texto dinùmicamente mientras el usuario escribe', 1, 4, 7.0, 6.9, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (244, 1, 2, 'Refactorizar Servicio de Gestiùn de Cookies', 'Aùadir opciones de personalizaciùn para el usuario', 2, 6, 5.0, 4.8, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (245, 1, 1, 'Implementar Sistema de Gestiùn de Aprobaciones', 'Permitir la definiciùn de flujos de aprobaciùn para documentos', 3, 7, 11.0, 10.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (246, 1, 3, 'Crear Componente de Visor de Documentos', 'Mostrar documentos PDF o Word dentro de la plataforma', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (247, 1, 3, 'Integrar con Servicio de Firma de Cùdigo Remota', 'Permitir la firma de cùdigo en entornos distribuidos', 2, 4, 6.0, 5.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (248, 1, 2, 'Refactorizar Servicio de Gestiùn de Campaùas', 'Aùadir la capacidad de programar campaùas', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (249, 1, 1, 'Implementar Sistema de Gestiùn de Riesgos', 'Identificar, analizar y mitigar riesgos del proyecto', 1, 7, 10.0, 9.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (250, 1, 1, 'Crear Componente de Editor Markdown', 'Permitir la ediciùn de texto con sintaxis Markdown', 2, 5, 4.0, 3.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (251, 1, 3, 'Implementar Sistema de Gestiùn de Contratos', 'Permitir la creaciùn, firma y seguimiento de contratos', 3, 7, 13.0, 12.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (252, 1, 2, 'Crear Componente de Diagrama de Barras Apiladas', 'Visualizar datos comparativos con mùltiples segmentos', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (253, 1, 3, 'Integrar con Servicio de Reconocimiento de Patrones', 'Identificar patrones en los datos de los usuarios', 2, 4, 6.0, 5.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (254, 1, 1, 'Refactorizar Servicio de Gestiùn de Aprobaciones', 'Aùadir la capacidad de delegar aprobaciones', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (255, 1, 3, 'Implementar Sistema de Gestiùn de Reuniones', 'Permitir la programaciùn y seguimiento de reuniones', 1, 7, 10.0, 9.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (256, 1, 1, 'Crear Componente de Visor de Imùgenes con Zoom', 'Permitir ampliar y ver detalles de las imùgenes', 2, 5, 4.0, 3.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (257, 1, 2, 'Integrar con Servicio de Firma de Video', 'Permitir la firma de documentos mediante grabaciùn de video', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (258, 1, 1, 'Refactorizar Servicio de Gestiùn de Riesgos', 'Aùadir la capacidad de asignar responsables a los riesgos', 1, 6, 7.0, 6.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (259, 1, 2, 'Implementar Sistema de Gestiùn de Proyectos ùgil', 'Adaptar metodologùas Scrum o Kanban', 2, 7, 11.0, 10.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (260, 1, 3, 'Crear Componente de Selector de Iconos', 'Permitir la selecciùn de iconos de una librerùa', 3, 5, 3.0, 2.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (261, 1, 2, 'Integrar con Servicio de Reconocimiento de Voz a Texto', 'Convertir audio a texto en tiempo real', 1, 4, 7.0, 6.9, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (262, 1, 3, 'Refactorizar Servicio de Gestiùn de Cookies Avanzado', 'Aùadir la capacidad de revocar el consentimiento', 2, 6, 9.0, 8.8, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (263, 1, 1, 'Implementar Sistema de Gestiùn de Subscripciones Avanzado', 'Permitir planes, pruebas gratuitas y cancelaciones', 3, 7, 13.0, 12.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (264, 2, 4, 'Crear Componente de Tabla con Agrupaciùn', 'Mostrar datos relacionados agrupados por columnas', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (265, 2, 4, 'Integrar con Servicio de Generaciùn de Cùdigo QR Avanzado', 'Generar cùdigos QR con logo y colores personalizados', 2, 4, 6.0, 5.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (266, 2, 4, 'Refactorizar Servicio de Gestiùn de Email Marketing', 'Aùadir la capacidad de programar envùos', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (267, 2, 4, 'Implementar Sistema de Gestiùn de Activos Fijos', 'Controlar la ubicaciùn, el estado y el mantenimiento de activos', 1, 7, 10.0, 9.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (268, 2, 4, 'Crear Componente de Editor de Texto Markdown Avanzado', 'Aùadir soporte para extensiones de Markdown', 2, 5, 5.0, 4.9, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (269, 2, 4, 'Integrar con Servicio de Anùlisis de Sentimiento Avanzado', 'Detectar la emociùn detrùs del texto', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (270, 2, 4, 'Refactorizar Servicio de Gestiùn de Reuniones', 'Aùadir la capacidad de grabar reuniones', 1, 6, 7.0, 6.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (271, 2, 4, 'Implementar Sistema de Gestiùn de Flujos de Trabajo Avanzado', 'Permitir la definiciùn de flujos condicionales', 2, 7, 12.0, 11.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (272, 2, 4, 'Crear Componente de Diagrama de Gantt Interactivo', 'Permitir la ediciùn de tareas directamente en el diagrama', 3, 5, 9.0, 8.7, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (273, 2, 4, 'Integrar con Servicio de Traducciùn Automùtica Avanzado', 'Mejorar la calidad y el contexto de las traducciones', 1, 4, 7.0, 6.9, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (274, 2, 4, 'Refactorizar Servicio de Gestiùn de Permisos', 'Aùadir la capacidad de definir permisos a nivel de objeto', 2, 6, 8.0, 7.7, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (275, 2, 4, 'Implementar Sistema de Gestiùn de Subscripciones Recurrentes', 'Manejar pagos periùdicos automùticamente', 3, 7, 14.0, 13.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (276, 2, 4, 'Crear Componente de Tabla con Columnas Reordenables', 'Permitir al usuario cambiar el orden de las columnas', 1, 5, 6.0, 5.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (277, 2, 4, 'Integrar con Servicio de Generaciùn de Cùdigo QR Dinùmico', 'Generar cùdigos QR con contenido variable', 2, 4, 5.0, 4.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (278, 2, 4, 'Refactorizar Servicio de Gestiùn de Alertas', 'Aùadir la capacidad de configurar reglas de alerta complejas', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (279, 2, 4, 'Implementar Sistema de Gestiùn de Activos Digitales (DAM)', 'Almacenar, organizar y gestionar archivos multimedia', 1, 7, 11.0, 10.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (280, 2, 4, 'Crear Componente de Editor de Texto Colaborativo', 'Permitir la ediciùn simultùnea por mùltiples usuarios', 2, 5, 10.0, 9.5, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (281, 2, 4, 'Integrar con Servicio de Anùlisis de Datos Avanzado', 'Realizar anùlisis predictivos y de tendencias', 3, 4, 8.0, 7.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (282, 2, 4, 'Refactorizar Servicio de Gestiùn de Reuniones Avanzado', 'Aùadir la capacidad de crear salas de espera y encuestas', 1, 6, 7.0, 6.8, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (283, 2, 4, 'Implementar Sistema de Gestiùn de Flujos de Trabajo Visual', 'Permitir la definiciùn de flujos mediante un editor grùfico', 2, 7, 14.0, 13.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (284, 2, 4, 'Crear Componente de Diagrama de Venn', 'Visualizar las intersecciones entre conjuntos de datos', 3, 5, 6.0, 5.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (285, 2, 4, 'Integrar con Servicio de Traducciùn Profesional Avanzado', 'Permitir la revisiùn y ediciùn de traducciones', 1, 4, 9.0, 8.7, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (286, 2, 4, 'Refactorizar Servicio de Gestiùn de Cookies Completo', 'Implementar un panel de control de preferencias de cookies', 2, 6, 10.0, 9.8, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (287, 2, 4, 'Implementar Sistema de Gestiùn de Subscripciones Empresariales', 'Soportar mùltiples planes, usuarios y facturaciùn compleja', 3, 7, 16.0, 15.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (288, 2, 4, 'Crear Componente de Tabla con Columnas Ancladas', 'Mantener ciertas columnas visibles al hacer scroll horizontal', 1, 5, 7.0, 6.9, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (289, 2, 4, 'Integrar con Servicio de Generaciùn de Cùdigo QR Masivo', 'Generar mùltiples cùdigos QR a partir de una lista', 2, 4, 5.0, 4.8, 100, 12, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (290, 2, 4, 'Refactorizar Servicio de Gestiùn de Alertas Avanzado', 'Aùadir la capacidad de configurar umbrales y destinatarios', 3, 6, 9.0, 8.7, 100, 8, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (291, 2, 4, 'Implementar Sistema de Gestiùn de Activos Digitales (DAM) Avanzado', 'Aùadir metadatos, bùsqueda avanzada y control de versiones', 1, 7, 12.0, 11.8, 100, 11, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (292, 2, 4, 'Crear Componente de Editor de Texto Colaborativo Avanzado', 'Aùadir historial de revisiones y comentarios en lùnea', 2, 5, 11.0, 10.5, 100, 10, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (293, 2, 4, 'Integrar con Servicio de Anùlisis de Datos en Tiempo Real', 'Visualizar mùtricas y tendencias en vivo', 3, 4, 9.0, 8.9, 100, 12, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (294, 2, 4, 'Refactorizar Servicio de Gestiùn de Reuniones Completo', 'Aùadir la capacidad de grabar transcripciones y generar resùmenes', 1, 6, 8.0, 7.7, 100, 8, 13, 16, b'1', NOW(), NOW(), 3, 3),
  (295, 2, 4, 'Implementar Sistema de Gestiùn de Flujos de Trabajo Visual Avanzado', 'Permitir la creaciùn de flujos complejos con subprocesos', 2, 7, 15.0, 14.5, 100, 11, 14, 17, b'1', NOW(), NOW(), 3, 2),
  (296, 2, 4, 'Crear Componente de Diagrama de Pareto', 'Identificar las causas mùs importantes de un problema', 3, 5, 7.0, 6.9, 100, 10, 15, 18, b'1', NOW(), NOW(), 3, 3),
  (297, 2, 4, 'Integrar con Servicio de Traducciùn Profesional Completo', 'Permitir la gestiùn de glosarios y memorias de traducciùn', 1, 4, 10.0, 9.8, 100, 12, 13, 16, b'1', NOW(), NOW(), 3, 2),
  (298, 2, 4, 'Refactorizar Servicio de Gestiùn de Cookies Total', 'Implementar auditorùa y registro de consentimiento de cookies', 2, 6, 11.0, 10.5, 100, 8, 14, 17, b'1', NOW(), NOW(), 3, 3),
  (299, 2, 4, 'Implementar Sistema de Gestiùn de Subscripciones Corporativas', 'Soportar facturaciùn por uso y planes personalizados', 3, 7, 17.0, 16.5, 100, 11, 15, 18, b'1', NOW(), NOW(), 3, 2),
  (300, 2, 4, 'Crear Componente de Tabla con Columnas Agrupadas y Colapsables', 'Mostrar datos jerùrquicos de forma organizada', 1, 5, 8.0, 7.7, 100, 10, 13, 16, b'1', NOW(), NOW(), 3, 3)
ON DUPLICATE KEY UPDATE
  id_proyecto = VALUES(id_proyecto),
  id_sprint = VALUES(id_sprint),
  titulo = VALUES(titulo),
  descripcion = VALUES(descripcion),
  valor_literal_prioridad = VALUES(valor_literal_prioridad),
  valor_literal_habilidad = VALUES(valor_literal_habilidad),
  tiempo_estimado = VALUES(tiempo_estimado),
  tiempo_real = VALUES(tiempo_real),
  porcentaje_avance = VALUES(porcentaje_avance),
  valor_literal_tarea_clara = VALUES(valor_literal_tarea_clara),
  valor_literal_carga_trabajo = VALUES(valor_literal_carga_trabajo),
  valor_literal_adecuado_habilidades = VALUES(valor_literal_adecuado_habilidades),
  flag_activo = VALUES(flag_activo),
  fecha_registro = VALUES(fecha_registro),
  fecha_editado = VALUES(fecha_editado),
  id_estado_tarea = VALUES(id_estado_tarea),
  id_usuario_asignado = VALUES(id_usuario_asignado);

-- 
UPDATE tarea set valor_literal_prioridad = 3, valor_literal_habilidad = 7, valor_literal_tarea_clara = 10, valor_literal_carga_trabajo = 15, valor_literal_adecuado_habilidades = 17 WHERE id_usuario_asignado = 2;
UPDATE tarea SET valor_literal_prioridad = 1, valor_literal_habilidad = 4, valor_literal_tarea_clara = 10, valor_literal_carga_trabajo = 15, valor_literal_adecuado_habilidades = 17 WHERE id_usuario_asignado = 3;
-- 



-- 
-- UPDATE tarea set valor_literal_prioridad = 3, valor_literal_habilidad = 7 WHERE id_usuario_asignado = 2;
-- UPDATE tarea SET valor_literal_prioridad = 1, valor_literal_habilidad = 4 WHERE id_usuario_asignado = 3;


SELECT  * FROM proyecto;
SELECT  * FROM sprint s;

SELECT  * FROM tarea;




