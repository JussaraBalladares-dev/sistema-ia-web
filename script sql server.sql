CREATE DATABASE prueba_ia;
USE prueba_ia;


CREATE TABLE rol(
  id_rol  INT PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(100)
);

SET IDENTITY_INSERT rol ON
INSERT INTO rol (id_rol, descripcion)
VALUES
  (1, 'Lider TI'),
  (2, 'Desarrollador')
SET IDENTITY_INSERT rol OFF

CREATE TABLE usuario(
	id_usuario INT PRIMARY KEY IDENTITY(1,1),
  id_rol int,
  nombres varchar(100),
  email varchar(100),
  contrasena varchar(500),
  flag_activo bit,
  fecha_registro datetime,
  fecha_editado datetime,
  FOREIGN KEY (id_rol) REFERENCES rol(id_rol)
);


SET IDENTITY_INSERT usuario ON
INSERT INTO usuario (id_usuario, id_rol, nombres, email, contrasena, flag_activo, fecha_registro)
VALUES
  (1, 1, 'Jairo Navez',        'prueba1@example.com', 'eyJpdiI6Ii91Q0pCTUU4K1hEQVk1RGFxUVFPemc9PSIsInZhbHVlIjoidmV1Tjh0bFpGeFhPb2M0UFNQbjVodz09IiwibWFjIjoiMGFkNTZjMTgyNWViMWVkNTgwMDJkZTYzNzZjMmRjZmIyYzlkMmNjZmI2ZDVhOGUzYTFhOTNmMzJmYTVhMzI3NCIsInRhZyI6IiJ9', 0, GETDATE()),
  (2, 2, 'Jussara Balladares', 'prueba2@example.com', 'eyJpdiI6IjNjSXZHaWtEbFJCWkpXY0lFc3RUVGc9PSIsInZhbHVlIjoiZVRKT0dzVjQ4ZnpIOW1rcVIvUmQrQT09IiwibWFjIjoiNjI1YjJhMjc5N2FkZjhkOGMyNmQ0NmE2MzViOWQ0NmM5Y2Q3Yjk1M2ZjMGM3Y2NhOTQwNDkyMDk5ZDVkOWZlMiIsInRhZyI6IiJ9', 1, GETDATE()),
  (3, 2, 'Kleber Granados', 'prueba3@example.com', 'eyJpdiI6IjNjSXZHaWtEbFJCWkpXY0lFc3RUVGc9PSIsInZhbHVlIjoiZVRKT0dzVjQ4ZnpIOW1rcVIvUmQrQT09IiwibWFjIjoiNjI1YjJhMjc5N2FkZjhkOGMyNmQ0NmE2MzViOWQ0NmM5Y2Q3Yjk1M2ZjMGM3Y2NhOTQwNDkyMDk5ZDVkOWZlMiIsInRhZyI6IiJ9', 1, GETDATE())
SET IDENTITY_INSERT usuario OFF



CREATE TABLE proyecto(
  id_proyecto INT PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(100)
);

SET IDENTITY_INSERT proyecto ON
INSERT INTO proyecto(id_proyecto, descripcion)
VALUES
  (1, 'Hojas de Piso B2'),
  (2, 'Balance Metalúrgico')
SET IDENTITY_INSERT proyecto OFF



CREATE TABLE sprint(
  id_sprint INT PRIMARY KEY IDENTITY(1,1),
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

SET IDENTITY_INSERT sprint ON
INSERT INTO sprint(id_sprint, id_proyecto, numero, detalle, fecha_inicio, fecha_fin, flag_activo, fecha_registro)
VALUES
  (1, 1, 1, 'Módulo de seguridad',       '2025-01-01', '2025-01-31', 1, GETDATE()),
  (2, 1, 2, 'Módulo de notificaciones',  '2025-02-01', '2025-02-28', 1, GETDATE()),
  (3, 1, 3, 'Módulo de Reportes',        '2025-03-01', '2025-03-31', 1, GETDATE()),
  (4, 2, 1, 'Dashboard en Power BI',     '2025-01-01', '2025-04-30', 1, GETDATE())
SET IDENTITY_INSERT sprint OFF



CREATE TABLE estado_tarea(
  id_estado_tarea int not NULL PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(50),
  orden int
);

SET IDENTITY_INSERT estado_tarea ON
INSERT INTO estado_tarea(id_estado_tarea, descripcion, orden)
VALUES
  (1, 'Pendiente', 1),
  (2, 'En curso', 2),
  (3, 'Completado', 3)
SET IDENTITY_INSERT estado_tarea OFF


CREATE TABLE valor_literal(
  id_valor_literal int not NULL PRIMARY KEY IDENTITY(1,1),
  descripcion varchar(200),
  tipo varchar(50),
  orden decimal(10, 2),
  peso_ia decimal(10, 2)
);

SET IDENTITY_INSERT valor_literal ON
INSERT INTO valor_literal(id_valor_literal, descripcion, tipo, orden, peso_ia)
VALUES
  ( 1, 'Baja',   'prioridad', 3, 1),
  ( 2, 'Media',  'prioridad', 2, 3),
  ( 3, 'Alta',   'prioridad', 1, 5),
  ( 4, 'Gestin',  'habilidad', 1, 1),
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
SET IDENTITY_INSERT valor_literal OFF


CREATE TABLE tarea(
  id_tarea int not NULL PRIMARY KEY IDENTITY(1,1),
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




SET IDENTITY_INSERT tarea ON
INSERT INTO tarea (id_tarea, id_proyecto, id_sprint, titulo, descripcion, valor_literal_prioridad, valor_literal_habilidad, tiempo_estimado, tiempo_real, porcentaje_avance,
valor_literal_tarea_clara, valor_literal_carga_trabajo, valor_literal_adecuado_habilidades, flag_activo, fecha_registro, fecha_editado, id_estado_tarea, id_usuario_asignado)
VALUES
(1, 1, 1, 'Crear endpoint API', 'Usuarios -> POST /api/users', 3, 6, 6.0, 7.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(2, 1, 1, 'Diseño landing page', 'Figma versión 2', 3, 6, 8.0, 6.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(3, 1, 1, 'Revisar pull request', 'PR #23 de Juan', 1, 4, 2.0, 1.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(4, 1, 1, 'Actualizar dependencias', 'npm audit fix', 3, 6, 1.5, 1.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(5, 1, 1, 'Configuración CI/CD', 'Deploy automático en main', 1, 4, 5.0, 4.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(6, 1, 1, 'Diseñar logo nuevo', 'Colores corporativos', 3, 6, 3.0, 3.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(7, 1, 1, 'Test unitarios login', 'Cobertura > 90%', 1, 4, 4.0, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(8, 1, 1, 'Refactor de componente Sidebar', 'Optimizar reactividad', 3, 6, 3.5, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(9, 1, 1, 'Crear pruebas de integración', 'Escenarios de extremo a extremo', 1, 4, 6.0, 2.5, 50.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(10, 1, 1, 'Implementar login JWT', 'Seguridad con token', 3, 6, 6.0, 6.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(11, 1, 1, 'Integrar Stripe', 'Pagos con tarjeta', 1, 4, 5.0, 5.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(12, 1, 1, 'Crear módulo usuarios', 'CRUD completo', 1, 4, 7.0, 7.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(13, 1, 1, 'Diseño de dashboard', 'UI Admin', 3, 6, 4.0, 3.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(14, 1, 1, 'Configurar Docker', 'Contenedor backend', 3, 6, 2.0, 2.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(15, 1, 1, 'Actualizar documentación', 'Wiki técnica', 1, 4, 1.5, 1.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(16, 1, 1, 'Revisión de accesibilidad', 'WAVE y ARIA', 3, 6, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(17, 1, 1, 'Subida inicial a GitHub', 'Push main', 3, 6, 0.5, 0.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(18, 1, 1, 'Crear entidades EF Core', 'Base de datos', 1, 4, 6.5, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(19, 1, 1, 'Test integración frontend', 'e2e con Cypress', 3, 6, 5.0, 5.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(20, 1, 1, 'Agregar PWA manifest', 'Soporte offline', 3, 6, 2.0, 2.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(21, 1, 1, 'Configurar ESLint + Prettier', 'Estilo de código', 1, 4, 1.0, 1.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(22, 1, 1, 'Agregar sistema de roles', 'Admin/Usuario', 1, 4, 4.0, 4.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(23, 1, 1, 'Revisión legal privacidad', 'Términos y condiciones', 3, 6, 2.5, 2.4, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(24, 1, 1, 'Crear mockups', 'Wireframes iniciales', 1, 4, 2.0, 2.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(25, 1, 1, 'Documentar API Swagger', 'Definiciones claras', 3, 6, 3.5, 3.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(26, 1, 1, 'Pruebas de carga', 'Apache JMeter', 1, 4, 5.0, 5.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(27, 1, 1, 'Agregar logs', 'Serilog + file output', 3, 6, 3.0, 3.0, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(28, 1, 1, 'Crear políticas de backup', 'Automatización diaria', 3, 6, 3.0, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(29, 1, 1, 'Mejorar usabilidad móvil', 'Diseño responsive', 1, 4, 4.0, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(30, 1, 1, 'Auditoría de seguridad', 'OWASP checklist', 3, 6, 6.0, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(31, 1, 1, 'Plan de pruebas', 'Casos QA', 1, 4, 3.0, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(32, 1, 1, 'Diseñar landing secundaria', 'Marketing', 3, 6, 4.5, 0.0, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(33, 1, 1, 'Optimizar imágenes', 'Compresión automática', 1, 4, 4.0, 2.0, 50.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(34, 1, 1, 'Integrar Google Analytics', 'Tracking de visitas', 3, 6, 2.5, 1.0, 25.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 2),
(35, 1, 1, 'Analizar requerimientos del cliente', 'Reunión con el cliente para definir alcance', 3, 6, 6.0, 5.5, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(36, 1, 2, 'Diseñar la arquitectura de la solución', 'Diagrama de alto nivel del sistema', 1, 4, 8.0, 7.2, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(37, 1, 3, 'Codificar el módulo de autenticación', 'Implementación de login y registro', 3, 6, 12.0, 11.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(38, 1, 1, 'Probar la integración con el API externo', 'Validar la comunicación de datos', 1, 4, 4.0, 4.3, 80.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(39, 1, 2, 'Documentar la base de datos', 'Crear diccionario de datos y modelo ER', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(40, 1, 2, 'Configurar Docker para desarrollo', 'Crear Dockerfile y docker-compose.yml', 3, 6, 4.0, 4.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(41, 1, 3, 'Corregir error en botón Guardar', 'Issue #7 en Jira', 1, 4, 2.0, 1.8, 95.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(42, 1, 1, 'Generar comprobante con Nubefact', 'Implementar API de facturación electrónica', 3, 6, 8.0, 8.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(43, 1, 2, 'Integrar pasarela de pagos Culqi', 'Implementar API de pagos con tarjeta', 1, 4, 10.0, 9.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(44, 1, 3, 'Implementar autenticación JWT', 'Asegurar endpoints de la API', 3, 6, 6.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(45, 1, 2, 'Crear modelo de base de datos', 'Diagrama Entidad-Relación para módulo de ventas', 1, 4, 7.0, 7.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(46, 1, 1, 'Diseñar interfaz de usuario para dashboard', 'Mockups en Figma', 3, 6, 8.0, 7.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(47, 1, 3, 'Implementar pruebas unitarias para servicio de usuarios', 'Cobertura mínima del 80%', 1, 4, 5.0, 5.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(48, 1, 1, 'Refactorizar servicio de notificaciones', 'Mejorar rendimiento y escalabilidad', 3, 6, 9.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(49, 1, 2, 'Crear documentación de la API', 'Documentación con Swagger', 1, 4, 6.0, 5.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(50, 1, 1, 'Investigar alternativas de caché', 'Analizar Redis y Memcached', 3, 6, 3.0, 2.8, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(51, 1, 3, 'Implementar logging centralizado', 'Integrar con Elasticsearch', 1, 4, 7.0, 6.9, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(52, 1, 1, 'Definir arquitectura de microservicios', 'Diagrama de componentes', 3, 6, 10.0, 9.5, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(53, 1, 2, 'Implementar sistema de colas con RabbitMQ', 'Procesamiento asíncrono de tareas', 1, 4, 8.0, 7.8, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(54, 1, 3, 'Analizar rendimiento de la base de datos', 'Identificar cuellos de botella', 3, 6, 4.0, 3.9, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(55, 1, 1, 'Crear script de migración de datos', 'Migrar datos de la versión anterior', 1, 4, 6.0, 5.7, 60.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(56, 1, 2, 'Desarrollar módulo de reportes', 'Generar informes en PDF', 3, 6, 9.0, 8.6, 70.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 2),
(57, 1, 3, 'Implementar sistema de alertas por correo electrónico', 'Notificaciones automáticas', 1, 4, 5.0, 5.3, 80.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(58, 1, 2, 'Integrar con API externa de geolocalización', 'Obtener coordenadas de usuarios', 3, 6, 7.0, 6.5, 90.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 2),
(59, 1, 1, 'Optimizar consultas SQL', 'Mejorar tiempos de respuesta de la API', 1, 4, 4.0, 4.2, 50.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 3),
(60, 1, 2, 'Implementar pruebas E2E con Cypress', 'Validar flujo completo de usuario', 3, 6, 10.0, 9.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(61, 1, 3, 'Configurar balanceador de carga', 'Distribuir tráfico entre servidores', 1, 4, 6.0, 6.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(62, 1, 1, 'Crear script de despliegue en AWS', 'Automatizar la implementación', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(63, 1, 2, 'Implementar métricas con Prometheus y Grafana', 'Monitoreo del sistema', 1, 4, 5.0, 5.4, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(64, 1, 1, 'Refactorizar componente de autenticación', 'Mejorar seguridad', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(65, 1, 3, 'Documentar API con OpenAPI', 'Generar documentación automática', 1, 4, 4.0, 4.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(66, 1, 1, 'Implementar sistema de versionamiento de API', 'Soportar múltiples versiones', 3, 6, 7.0, 6.7, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(67, 1, 2, 'Analizar y optimizar rendimiento frontend', 'Mejorar tiempos de carga', 1, 4, 6.0, 5.9, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(68, 1, 3, 'Implementar internacionalización (i18n)', 'Soportar múltiples idiomas', 3, 6, 8.0, 7.7, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 2),
(69, 1, 1, 'Configurar firewall', 'Asegurar acceso al servidor', 1, 4, 4.0, 4.3, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(70, 1, 2, 'Implementar pruebas de integración', 'Validar interacción entre módulos', 3, 6, 9.0, 8.5, 75.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 2, 2),
(71, 1, 3, 'Implementar caché con Redis', 'Mejorar tiempos de respuesta de consultas frecuentes', 1, 4, 5.0, 5.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(72, 1, 1, 'Refactorizar componente de tabla', 'Mejorar rendimiento y usabilidad', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(73, 1, 2, 'Implementar pruebas de accesibilidad', 'Cumplir con WCAG 2.1 AA', 1, 4, 6.0, 6.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(74, 1, 1, 'Integrar con sistema de email marketing', 'Enviar notificaciones a usuarios', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(75, 1, 3, 'Crear script para respaldo de base de datos', 'Automatizar backups diarios', 1, 4, 4.0, 4.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(76, 1, 2, 'Implementar sistema de colas con Kafka', 'Procesamiento de eventos en tiempo real', 3, 6, 9.0, 9.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(77, 1, 1, 'Analizar y optimizar consultas NoSQL', 'Mejorar rendimiento de MongoDB', 1, 4, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(78, 1, 3, 'Implementar sistema de control de versiones de documentos', 'Integrar con Git LFS', 3, 6, 7.0, 7.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(79, 1, 2, 'Configurar servidor web con Nginx', 'Optimizar la configuración', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(80, 1, 1, 'Implementar pruebas de rendimiento con JMeter', 'Evaluar la escalabilidad del API', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(81, 1, 3, 'Crear dashboard de métricas del sistema', 'Visualizar el rendimiento en tiempo real', 1, 4, 6.0, 6.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(82, 1, 2, 'Implementar sistema de logs con ELK Stack', 'Centralizar y analizar logs', 3, 6, 8.0, 8.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(83, 1, 1, 'Refactorizar código legado', 'Mejorar la mantenibilidad', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(84, 1, 3, 'Implementar sistema de autorización con OAuth2', 'Asegurar el acceso a los recursos', 3, 6, 5.0, 5.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(85, 1, 2, 'Crear script para limpieza de datos antiguos', 'Automatizar la eliminación de datos obsoletos', 1, 4, 4.0, 4.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(86, 1, 1, 'Implementar pruebas de humo', 'Verificar la funcionalidad básica', 3, 6, 3.0, 3.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(87, 1, 3, 'Configurar DNS', 'Gestionar los registros de dominio', 1, 4, 2.0, 1.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(88, 1, 2, 'Implementar sistema de monitoreo de salud del API', 'Alertas automáticas en caso de fallas', 3, 6, 7.0, 7.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(89, 1, 1, 'Refactorizar estilos CSS', 'Mejorar la consistencia visual', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(90, 1, 3, 'Implementar sistema de seguimiento de errores con Sentry', 'Capturar y analizar errores', 3, 6, 6.0, 6.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(91, 1, 2, 'Crear script para rotación de logs', 'Gestionar el tamaño de los archivos de log', 1, 4, 3.0, 3.2, 0.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 1, 3),
(92, 1, 1, 'Analizar y optimizar imágenes', 'Mejorar el tiempo de carga del frontend', 3, 6, 4.0, 3.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(93, 1, 3, 'Implementar pruebas de regresión', 'Asegurar la estabilidad después de cambios', 1, 4, 7.0, 7.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(94, 1, 2, 'Configurar balanceo de carga para base de datos', 'Mejorar la disponibilidad de la base de datos', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(95, 1, 1, 'Implementar sistema de backups incrementales', 'Optimizar el espacio de almacenamiento de backups', 1, 4, 5.0, 5.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(96, 1, 3, 'Crear script para análisis de logs', 'Identificar patrones y errores', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(97, 1, 2, 'Implementar sistema de auditoría', 'Registrar acciones importantes del sistema', 1, 4, 9.0, 9.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(98, 1, 1, 'Refactorizar API para RESTful', 'Mejorar la arquitectura de la API', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(99, 1, 3, 'Implementar sistema de gestión de secretos', 'Almacenar credenciales de forma segura', 1, 4, 4.0, 4.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(100, 1, 2, 'Crear documentación técnica detallada', 'Manual de usuario y guía de implementación', 3, 6, 10.0, 9.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(101, 1, 1, 'Implementar Autenticación de Dos Factores', 'Añadir capa de seguridad con TOTP', 3, 6, 8.0, 7.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(102, 1, 2, 'Crear API para Gestión de Pedidos', 'Endpoints para crear, leer, actualizar y eliminar pedidos', 1, 4, 12.0, 11.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(103, 1, 1, 'Diseñar Dashboard de Ventas', 'Mockups para visualizar métricas clave de ventas', 3, 6, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(104, 1, 3, 'Integrar con Servicio de SMS', 'Enviar notificaciones por SMS a usuarios', 1, 4, 4.0, 4.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(105, 1, 2, 'Refactorizar Componente de Formulario', 'Mejorar la reutilización y validación', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(106, 1, 1, 'Implementar Búsqueda Avanzada de Productos', 'Permitir filtrar por múltiples criterios', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(107, 1, 2, 'Crear Directiva para Subida de Archivos', 'Permitir la carga de diferentes tipos de archivos', 3, 6, 5.0, 5.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(108, 1, 3, 'Integrar con Pasarela de Pago PayPal', 'Añadir método de pago con PayPal', 1, 4, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(109, 1, 2, 'Diseñar Panel de Administración de Usuarios', 'Mockups para gestionar usuarios y roles', 3, 6, 7.5, 7.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(110, 1, 1, 'Implementar Paginación en Resultados de Búsqueda', 'Mostrar resultados en múltiples páginas', 1, 4, 4.5, 4.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(111, 1, 3, 'Refactorizar Servicio de Email', 'Mejorar la gestión de plantillas y envío', 3, 6, 6.5, 6.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(112, 1, 2, 'Implementar Sistema de Recomendaciones de Productos', 'Sugerir productos basados en el historial de compras', 1, 4, 9.5, 9.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(113, 1, 2, 'Crear Componente de Notificaciones en Tiempo Real', 'Mostrar alertas a los usuarios en tiempo real', 3, 6, 5.5, 5.3, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(114, 1, 1, 'Integrar con Servicio de Geolocalización', 'Mostrar la ubicación de los usuarios en un mapa', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(115, 1, 3, 'Diseñar Interfaz para Gestión de Inventario', 'Mockups para administrar el stock de productos', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(116, 1, 3, 'Implementar Pruebas de Integración Continua', 'Configurar Jenkins para ejecutar pruebas automáticamente', 1, 4, 8.5, 8.2, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(117, 1, 2, 'Refactorizar Componente de Tabla Dinámica', 'Mejorar la manipulación y visualización de datos', 3, 6, 7.5, 7.1, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(118, 1, 1, 'Implementar Sistema de Reportes en PDF', 'Generar informes descargables en formato PDF', 1, 4, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(119, 1, 1, 'Crear Directiva para Formato de Fecha', 'Mostrar fechas en diferentes formatos', 3, 6, 4.0, 3.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(120, 1, 3, 'Integrar con Servicio de Analítica Web', 'Enviar datos a Google Analytics', 1, 4, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(121, 1, 2, 'Refactorizar Servicio de Autenticación', 'Implementar JWT para la API', 3, 6, 7.0, 6.6, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(122, 1, 1, 'Implementar Sistema de Gestión de Roles y Permisos', 'Controlar el acceso a diferentes funcionalidades', 1, 4, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(123, 1, 3, 'Crear Componente de Breadcrumbs', 'Mostrar la ruta de navegación del usuario', 3, 6, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(124, 1, 2, 'Integrar con Servicio de Almacenamiento en la Nube', 'Subir y descargar archivos a AWS S3', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(125, 1, 1, 'Refactorizar Servicio de Logging', 'Implementar un sistema de logging más robusto', 3, 6, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(126, 1, 1, 'Implementar Pruebas Unitarias para Servicio de Usuarios', 'Asegurar la correcta funcionalidad del servicio', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(127, 1, 3, 'Crear Directiva para Formato de Moneda', 'Mostrar valores monetarios con el formato correcto', 3, 6, 4.0, 3.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(128, 1, 2, 'Integrar con Servicio de Traducción', 'Permitir la traducción de la interfaz a múltiples idiomas', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(129, 1, 2, 'Refactorizar Componente de Modal', 'Mejorar la usabilidad y accesibilidad de las ventanas modales', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(130, 1, 1, 'Implementar Sistema de Gestión de Errores', 'Capturar y mostrar errores de forma amigable', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(131, 1, 3, 'Crear Directiva para Validación de Email', 'Asegurar el formato correcto de los correos electrónicos', 3, 6, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(132, 1, 2, 'Integrar con Servicio de Mapas con Marcadores Personalizados', 'Mostrar ubicaciones específicas con iconos personalizados', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(133, 1, 1, 'Refactorizar Servicio de Búsqueda', 'Mejorar la eficiencia y la relevancia de los resultados', 3, 6, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(134, 1, 3, 'Implementar Sistema de Gestión de Sesiones', 'Manejar las sesiones de usuario de forma segura', 1, 4, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(135, 1, 1, 'Crear Componente de Paginación Personalizado', 'Adaptar la paginación a los requerimientos del diseño', 3, 6, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(136, 1, 2, 'Integrar con Servicio de Streaming de Video', 'Mostrar videos en la plataforma', 1, 4, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(137, 1, 1, 'Refactorizar Directiva de Subida de Archivos', 'Añadir validaciones de tamaño y tipo de archivo', 3, 6, 7.0, 6.6, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(138, 1, 3, 'Implementar Sistema de Calificación de Productos', 'Permitir a los usuarios calificar los productos', 1, 4, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(139, 1, 3, 'Crear Componente de Barra de Progreso', 'Mostrar el avance de las tareas', 3, 6, 3.0, 2.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(140, 1, 2, 'Integrar con Servicio de Chat en Vivo', 'Permitir la comunicación con soporte en tiempo real', 1, 4, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(141, 1, 1, 'Refactorizar Servicio de Geolocalización', 'Optimizar la precisión y el rendimiento', 3, 6, 7.0, 6.6, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(142, 1, 3, 'Implementar Sistema de Favoritos', 'Permitir a los usuarios guardar productos favoritos', 1, 4, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(143, 1, 2, 'Crear Componente de Selector de Fechas', 'Permitir la selección de rangos de fechas', 3, 6, 4.0, 3.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(144, 1, 1, 'Integrar con Servicio de Email Transaccional', 'Enviar correos electrónicos de confirmación y restablecimiento de contraseña', 1, 4, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(145, 1, 2, 'Refactorizar Servicio de Gestión de Errores', 'Implementar un sistema de seguimiento de errores', 3, 6, 7.0, 6.6, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(146, 1, 3, 'Implementar Pruebas de Aceptación del Usuario (UAT)', 'Validar las funcionalidades con los usuarios finales', 1, 4, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(147, 1, 2, 'Crear Componente de Tabla Editable', 'Permitir la edición de datos directamente en la tabla', 3, 6, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(148, 1, 2, 'Crear Componente de Tarjetas Interactivas', 'Mostrar información de forma dinámica al interactuar', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(149, 1, 2, 'Refactorizar Directiva de Formato de Moneda', 'Añadir soporte para diferentes divisas', 1, 4, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(150, 1, 3, 'Implementar Sistema de Historial de Navegación', 'Permitir a los usuarios ver su actividad reciente', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(151, 1, 1, 'Crear Componente de Carrusel de Productos', 'Mostrar productos relacionados o destacados', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(152, 1, 1, 'Integrar con Servicio de Video Conferencia', 'Permitir reuniones virtuales dentro de la plataforma', 3, 6, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(153, 1, 2, 'Refactorizar Servicio de Validación', 'Centralizar y mejorar la lógica de validación', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(154, 1, 3, 'Implementar Sistema de Wishlist', 'Permitir a los usuarios guardar productos para más tarde', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(155, 1, 2, 'Crear Directiva para Autocompletado', 'Sugerir opciones mientras el usuario escribe', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(156, 1, 1, 'Integrar con Servicio de Firma Electrónica', 'Permitir la firma de documentos digitalmente', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(157, 1, 2, 'Diseñar Panel de Control de Suscripciones', 'Mockups para gestionar las suscripciones de los usuarios', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(158, 1, 3, 'Implementar Sistema de Traducción Automática', 'Traducir el contenido a diferentes idiomas', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(159, 1, 2, 'Refactorizar Servicio de Reportes', 'Mejorar la generación y personalización de informes', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(160, 1, 1, 'Implementar Sistema de Alertas Personalizadas', 'Permitir a los usuarios configurar sus propias alertas', 3, 6, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(161, 1, 2, 'Crear Componente de Calendario', 'Mostrar eventos y permitir la selección de fechas', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(162, 1, 3, 'Integrar con Servicio de Reconocimiento de Voz', 'Permitir la interacción con la plataforma mediante la voz', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(163, 1, 2, 'Diseñar Interfaz para Gestión de Pagos', 'Mockups para administrar las transacciones de los usuarios', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(164, 1, 1, 'Implementar Sistema de Invitaciones', 'Permitir a los usuarios invitar a otros a la plataforma', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(165, 1, 2, 'Refactorizar Servicio de Búsqueda por Voz', 'Mejorar la precisión y la comprensión del lenguaje', 1, 4, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(166, 1, 3, 'Implementar Sistema de Gestión de Tickets de Soporte', 'Permitir a los usuarios crear y seguir tickets', 3, 6, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(167, 1, 2, 'Crear Componente de Gráficos', 'Visualizar datos mediante diferentes tipos de gráficos', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(168, 1, 1, 'Integrar con Servicio de Videollamadas', 'Permitir llamadas de audio y video dentro de la plataforma', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(169, 1, 3, 'Refactorizar Servicio de Notificaciones Push', 'Mejorar la entrega y personalización de notificaciones', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(170, 1, 2, 'Implementar Sistema de Foros de Discusión', 'Permitir a los usuarios interactuar y compartir ideas', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(171, 1, 1, 'Crear Componente de Mapa Interactivo', 'Mostrar información adicional al interactuar con el mapa', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(172, 1, 3, 'Integrar con Servicio de Reconocimiento de Imágenes', 'Analizar el contenido de las imágenes cargadas', 3, 6, 8.0, 7.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(173, 1, 2, 'Refactorizar Servicio de Gestión de Sesiones', 'Mejorar la seguridad y la persistencia de las sesiones', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(174, 1, 2, 'Implementar Sistema de Encuestas', 'Permitir a los usuarios responder preguntas y recopilar datos', 3, 6, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(175, 1, 1, 'Crear Componente de Timeline', 'Mostrar eventos en orden cronológico', 1, 4, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(176, 1, 3, 'Integrar con Servicio de Recomendación de Contenido', 'Sugerir artículos o videos relevantes a los usuarios', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(177, 1, 2, 'Refactorizar Servicio de Generación de Informes', 'Añadir la capacidad de exportar a diferentes formatos', 1, 4, 8.0, 7.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(178, 1, 1, 'Implementar Sistema de Gestión de Anuncios', 'Permitir la creación y visualización de anuncios', 3, 6, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(179, 1, 3, 'Crear Componente de Mapa de Calor', 'Visualizar la densidad de datos en un mapa', 1, 4, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(180, 1, 2, 'Integrar con Servicio de Firma Digital', 'Permitir la firma de documentos con certificados digitales', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(181, 1, 1, 'Refactorizar Servicio de Autocompletado', 'Mejorar la precisión y la velocidad de las sugerencias', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(182, 1, 3, 'Implementar Sistema de Gestión de Eventos', 'Permitir la creación y visualización de eventos', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(183, 1, 2, 'Crear Componente de Acordeón', 'Mostrar contenido oculto de forma expandible', 1, 4, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(184, 1, 1, 'Integrar con Servicio de Generación de Códigos QR', 'Generar códigos QR para diferentes propósitos', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(185, 1, 3, 'Refactorizar Servicio de Traducción Automática', 'Mejorar la calidad y la fluidez de las traducciones', 1, 4, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(186, 1, 2, 'Implementar Sistema de Chatbot', 'Permitir la interacción con un asistente virtual', 3, 6, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(187, 1, 1, 'Crear Componente de Slider de Imágenes', 'Mostrar imágenes de forma secuencial y animada', 1, 4, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(188, 1, 3, 'Integrar con Servicio de Reconocimiento Facial', 'Permitir la autenticación mediante reconocimiento facial', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(189, 1, 2, 'Refactorizar Servicio de Recomendación de Contenido', 'Mejorar la personalización de las sugerencias', 1, 4, 8.0, 7.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(190, 1, 1, 'Implementar Sistema de Gestión de Notificaciones In-App', 'Mostrar notificaciones dentro de la aplicación', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(191, 1, 3, 'Crear Componente de Árbol de Navegación', 'Mostrar la estructura jerárquica de la información', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(192, 1, 2, 'Integrar con Servicio de Firma de Documentos', 'Permitir la firma de documentos directamente en la plataforma', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(193, 1, 1, 'Refactorizar Servicio de Gestión de Anuncios', 'Añadir la capacidad de segmentar anuncios', 1, 4, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(194, 1, 3, 'Implementar Sistema de Gestión de Cookies', 'Mostrar el banner de cookies y gestionar el consentimiento', 3, 6, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(195, 1, 1, 'Crear Componente de Tarjetas Interactivas', 'Mostrar información de forma dinámica al interactuar', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(196, 1, 2, 'Refactorizar Servicio de Gestión de Usuarios', 'Mejorar la seguridad y la gestión de perfiles', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(197, 1, 3, 'Implementar Sistema de Gestión de Inventario Avanzado', 'Controlar stock, movimientos y alertas', 3, 6, 12.0, 11.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(198, 1, 2, 'Diseñar Panel de Reportes Personalizados', 'Mockups para crear y visualizar informes customizados', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(199, 1, 1, 'Integrar con Servicio de Calendario Externo', 'Sincronizar eventos con Google Calendar', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(200, 1, 3, 'Refactorizar Componente de Navegación Móvil', 'Mejorar la usabilidad en dispositivos móviles', 1, 4, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(201, 1, 2, 'Implementar Sistema de Gestión de Permisos Avanzado', 'Control de acceso granular a funcionalidades', 3, 6, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(202, 1, 2, 'Crear Directiva para Formato de Número', 'Mostrar números con separadores de miles y decimales', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(203, 1, 1, 'Integrar con Servicio de Firma Digital Remota', 'Permitir la firma de documentos desde cualquier lugar', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(204, 1, 3, 'Diseñar Panel de Control de Alertas', 'Mockups para gestionar las alertas del sistema', 1, 4, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(205, 1, 3, 'Implementar Sistema de Versionamiento de APIs', 'Soportar múltiples versiones de la API', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(206, 1, 2, 'Refactorizar Servicio de Email Marketing', 'Mejorar la segmentación y personalización de emails', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(207, 1, 1, 'Implementar Sistema de Gestión de Tareas Recurrentes', 'Programar tareas automáticas', 3, 6, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(208, 1, 2, 'Crear Componente de Diagrama de Flujo', 'Visualizar procesos mediante diagramas interactivos', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(209, 1, 3, 'Integrar con Servicio de Traducción Profesional', 'Permitir la traducción por traductores humanos', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(210, 1, 2, 'Diseñar Interfaz para Gestión de Contenido', 'Mockups para administrar textos, imágenes y videos', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(211, 1, 1, 'Implementar Sistema de Encuestas Avanzado', 'Permitir diferentes tipos de preguntas y lógica condicional', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(212, 1, 3, 'Refactorizar Servicio de Recomendación de Contenido', 'Añadir algoritmos de filtrado colaborativo', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(213, 1, 2, 'Implementar Sistema de Gestión de Documentos', 'Permitir la carga, visualización y descarga de documentos', 3, 6, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(214, 1, 2, 'Crear Componente de Selector de Tiempo', 'Permitir la selección de horas y minutos', 1, 4, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(215, 1, 1, 'Integrar con Servicio de Firma Biométrica', 'Permitir la firma de documentos con huella digital', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(216, 1, 3, 'Refactorizar Servicio de Gestión de Tickets', 'Añadir la capacidad de asignar prioridades y categorías', 1, 4, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(217, 1, 3, 'Implementar Sistema de Gestión de Proyectos', 'Permitir la creación y seguimiento de proyectos', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(218, 1, 2, 'Crear Componente de Barra Lateral Desplegable', 'Mostrar opciones de navegación de forma compacta', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(219, 1, 1, 'Integrar con Servicio de Reconocimiento de Texto (OCR)', 'Extraer texto de imágenes o documentos', 3, 6, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(220, 1, 1, 'Refactorizar Servicio de Autenticación de Dos Factores', 'Añadir soporte para múltiples métodos (SMS, Email)', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(221, 1, 3, 'Implementar Sistema de Gestión de Reservas', 'Permitir a los usuarios realizar reservas de recursos', 3, 6, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(222, 1, 2, 'Crear Componente de Tabla con Filtros Avanzados', 'Permitir el filtrado de datos por múltiples columnas', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(223, 1, 2, 'Integrar con Servicio de Generación de Informes Programados', 'Enviar informes automáticamente por correo electrónico', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(224, 1, 1, 'Refactorizar Servicio de Gestión de Pedidos', 'Añadir la capacidad de cancelar o modificar pedidos', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(225, 1, 3, 'Implementar Sistema de Gestión de Incidencias', 'Permitir a los usuarios reportar y seguir incidencias', 3, 6, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(226, 1, 3, 'Crear Componente de Diagrama de Gantt', 'Visualizar la planificación de proyectos', 1, 4, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(227, 1, 2, 'Integrar con Servicio de Firma de Código', 'Asegurar la integridad del código desplegado', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(228, 1, 1, 'Refactorizar Servicio de Gestión de Documentos', 'Añadir control de versiones y permisos', 1, 4, 7.0, 6.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(229, 1, 1, 'Implementar Sistema de Gestión de Conocimiento', 'Crear una base de datos de artículos y preguntas frecuentes', 3, 6, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(230, 1, 3, 'Crear Componente de Selector de Color', 'Permitir la selección de colores personalizados', 1, 4, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(231, 1, 2, 'Integrar con Servicio de Reconocimiento de Voz Avanzado', 'Soportar comandos de voz complejos', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(232, 1, 2, 'Refactorizar Servicio de Gestión de Sesiones', 'Implementar invalidación de sesiones y control de concurrencia', 1, 4, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(233, 1, 1, 'Implementar Sistema de Gestión de Campañas', 'Permitir la creación y seguimiento de campañas de marketing', 3, 6, 13.0, 12.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(234, 1, 3, 'Crear Componente de Mapa con Marcadores Agrupados', 'Mostrar múltiples ubicaciones en un mapa de forma organizada', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(235, 1, 3, 'Integrar con Servicio de Generación de Documentos', 'Generar documentos dinámicamente (PDF, Word)', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(236, 1, 2, 'Refactorizar Servicio de Gestión de Permisos Avanzado', 'Implementar herencia de permisos y roles personalizados', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(237, 1, 1, 'Implementar Sistema de Gestión de Activos', 'Permitir el seguimiento y la gestión de activos de la empresa', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(238, 1, 2, 'Crear Componente de Editor de Texto Enriquecido', 'Permitir la edición de texto con formato (WYSIWYG)', 1, 4, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(239, 1, 3, 'Integrar con Servicio de Análisis de Sentimiento', 'Analizar el sentimiento de los comentarios de los usuarios', 3, 6, 6.0, 5.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(240, 1, 2, 'Refactorizar Servicio de Gestión de Tareas Recurrentes', 'Añadir la capacidad de programar tareas complejas', 1, 4, 7.0, 6.6, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(241, 1, 1, 'Implementar Sistema de Gestión de Flujos de Trabajo', 'Permitir la definición y seguimiento de flujos de trabajo', 3, 6, 12.0, 11.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(242, 1, 3, 'Crear Componente de Diagrama de Sankey', 'Visualizar flujos de datos o energía', 1, 4, 8.0, 7.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(243, 1, 2, 'Integrar con Servicio de Traducción en Tiempo Real', 'Traducir texto dinámicamente mientras el usuario escribe', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(244, 1, 2, 'Refactorizar Servicio de Gestión de Cookies', 'Añadir opciones de personalización para el usuario', 1, 4, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(245, 1, 1, 'Implementar Sistema de Gestión de Aprobaciones', 'Permitir la definición de flujos de aprobación para documentos', 3, 6, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(246, 1, 3, 'Crear Componente de Visor de Documentos', 'Mostrar documentos PDF o Word dentro de la plataforma', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(247, 1, 3, 'Integrar con Servicio de Firma de Código Remota', 'Permitir la firma de código en entornos distribuidos', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(248, 1, 2, 'Refactorizar Servicio de Gestión de Campañas', 'Añadir la capacidad de programar campañas', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(249, 1, 1, 'Implementar Sistema de Gestión de Riesgos', 'Identificar, analizar y mitigar riesgos del proyecto', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(250, 1, 1, 'Crear Componente de Editor Markdown', 'Permitir la edición de texto con sintaxis Markdown', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(251, 1, 3, 'Implementar Sistema de Gestión de Contratos', 'Permitir la creación, firma y seguimiento de contratos', 3, 6, 13.0, 12.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(252, 1, 2, 'Crear Componente de Diagrama de Barras Apiladas', 'Visualizar datos comparativos con múltiples segmentos', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(253, 1, 3, 'Integrar con Servicio de Reconocimiento de Patrones', 'Identificar patrones en los datos de los usuarios', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(254, 1, 1, 'Refactorizar Servicio de Gestión de Aprobaciones', 'Añadir la capacidad de delegar aprobaciones', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(255, 1, 3, 'Implementar Sistema de Gestión de Reuniones', 'Permitir la programación y seguimiento de reuniones', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(256, 1, 1, 'Crear Componente de Visor de Imágenes con Zoom', 'Permitir ampliar y ver detalles de las imágenes', 1, 4, 4.0, 3.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(257, 1, 2, 'Integrar con Servicio de Firma de Video', 'Permitir la firma de documentos mediante grabación de video', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(258, 1, 1, 'Refactorizar Servicio de Gestión de Riesgos', 'Añadir la capacidad de asignar responsables a los riesgos', 1, 4, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(259, 1, 2, 'Implementar Sistema de Gestión de Proyectos Ágil', 'Adaptar metodologías Scrum o Kanban', 3, 6, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(260, 1, 3, 'Crear Componente de Selector de Iconos', 'Permitir la selección de iconos de una librería', 1, 4, 3.0, 2.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(261, 1, 2, 'Integrar con Servicio de Reconocimiento de Voz a Texto', 'Convertir audio a texto en tiempo real', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(262, 1, 3, 'Refactorizar Servicio de Gestión de Cookies Avanzado', 'Añadir la capacidad de revocar el consentimiento', 1, 4, 9.0, 8.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(263, 1, 1, 'Implementar Sistema de Gestión de Subscripciones Avanzado', 'Permitir planes, pruebas gratuitas y cancelaciones', 3, 6, 13.0, 12.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(264, 2, 4, 'Crear Componente de Tabla con Agrupación', 'Mostrar datos relacionados agrupados por columnas', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-28 11:05:12', 1, 3),
(265, 2, 4, 'Integrar con Servicio de Generación de Código QR Avanzado', 'Generar códigos QR con logo y colores personalizados', 3, 6, 6.0, 5.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-28 11:09:07', 3, 2),
(266, 2, 4, 'Refactorizar Servicio de Gestión de Email Marketing', 'Añadir la capacidad de programar envíos', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(267, 2, 4, 'Implementar Sistema de Gestión de Activos Fijos', 'Controlar la ubicación, el estado y el mantenimiento de activos', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-28 11:05:17', 2, 2),
(268, 2, 4, 'Crear Componente de Editor de Texto Markdown Avanzado', 'Añadir soporte para extensiones de Markdown', 1, 4, 5.0, 4.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-28 11:05:19', 2, 3),
(269, 2, 4, 'Integrar con Servicio de Análisis de Sentimiento Avanzado', 'Detectar la emoción detrás del texto', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(270, 2, 4, 'Refactorizar Servicio de Gestión de Reuniones', 'Añadir la capacidad de grabar reuniones', 1, 4, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(271, 2, 4, 'Implementar Sistema de Gestión de Flujos de Trabajo Avanzado', 'Permitir la definición de flujos condicionales', 3, 6, 12.0, 11.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(272, 2, 4, 'Crear Componente de Diagrama de Gantt Interactivo', 'Permitir la edición de tareas directamente en el diagrama', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(273, 2, 4, 'Integrar con Servicio de Traducción Automática Avanzado', 'Mejorar la calidad y el contexto de las traducciones', 3, 6, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(274, 2, 4, 'Refactorizar Servicio de Gestión de Permisos', 'Añadir la capacidad de definir permisos a nivel de objeto', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(275, 2, 4, 'Implementar Sistema de Gestión de Subscripciones Recurrentes', 'Manejar pagos periódicos automáticamente', 3, 6, 14.0, 13.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(276, 2, 4, 'Crear Componente de Tabla con Columnas Reordenables', 'Permitir al usuario cambiar el orden de las columnas', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(277, 2, 4, 'Integrar con Servicio de Generación de Código QR Dinámico', 'Generar códigos QR con contenido variable', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(278, 2, 4, 'Refactorizar Servicio de Gestión de Alertas', 'Añadir la capacidad de configurar reglas de alerta complejas', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(279, 2, 4, 'Implementar Sistema de Gestión de Activos Digitales (DAM)', 'Almacenar, organizar y gestionar archivos multimedia', 3, 6, 11.0, 10.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(280, 2, 4, 'Crear Componente de Editor de Texto Colaborativo', 'Permitir la edición simultánea por múltiples usuarios', 1, 4, 10.0, 9.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(281, 2, 4, 'Integrar con Servicio de Análisis de Datos Avanzado', 'Realizar análisis predictivos y de tendencias', 3, 6, 8.0, 7.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(282, 2, 4, 'Refactorizar Servicio de Gestión de Reuniones Avanzado', 'Añadir la capacidad de crear salas de espera y encuestas', 1, 4, 7.0, 6.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(283, 2, 4, 'Implementar Sistema de Gestión de Flujos de Trabajo Visual', 'Permitir la definición de flujos mediante un editor gráfico', 3, 6, 14.0, 13.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(284, 2, 4, 'Crear Componente de Diagrama de Venn', 'Visualizar las intersecciones entre conjuntos de datos', 1, 4, 6.0, 5.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(285, 2, 4, 'Integrar con Servicio de Traducción Profesional Avanzado', 'Permitir la revisión y edición de traducciones', 3, 6, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(286, 2, 4, 'Refactorizar Servicio de Gestión de Cookies Completo', 'Implementar un panel de control de preferencias de cookies', 1, 4, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(287, 2, 4, 'Implementar Sistema de Gestión de Subscripciones Empresariales', 'Soportar múltiples planes, usuarios y facturación compleja', 3, 6, 16.0, 15.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(288, 2, 4, 'Crear Componente de Tabla con Columnas Ancladas', 'Mantener ciertas columnas visibles al hacer scroll horizontal', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(289, 2, 4, 'Integrar con Servicio de Generación de Código QR Masivo', 'Generar múltiples códigos QR a partir de una lista', 3, 6, 5.0, 4.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(290, 2, 4, 'Refactorizar Servicio de Gestión de Alertas Avanzado', 'Añadir la capacidad de configurar umbrales y destinatarios', 1, 4, 9.0, 8.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(291, 2, 4, 'Implementar Sistema de Gestión de Activos Digitales (DAM) Avanzado', 'Añadir metadatos, búsqueda avanzada y control de versiones', 3, 6, 12.0, 11.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(292, 2, 4, 'Crear Componente de Editor de Texto Colaborativo Avanzado', 'Añadir historial de revisiones y comentarios en línea', 1, 4, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(293, 2, 4, 'Integrar con Servicio de Análisis de Datos en Tiempo Real', 'Visualizar métricas y tendencias en vivo', 3, 6, 9.0, 8.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(294, 2, 4, 'Refactorizar Servicio de Gestión de Reuniones Completo', 'Añadir la capacidad de grabar transcripciones y generar resúmenes', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(295, 2, 4, 'Implementar Sistema de Gestión de Flujos de Trabajo Visual Avanzado', 'Permitir la creación de flujos complejos con subprocesos', 3, 6, 15.0, 14.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(296, 2, 4, 'Crear Componente de Diagrama de Pareto', 'Identificar las causas más importantes de un problema', 1, 4, 7.0, 6.9, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(297, 2, 4, 'Integrar con Servicio de Traducción Profesional Completo', 'Permitir la gestión de glosarios y memorias de traducción', 3, 6, 10.0, 9.8, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(298, 2, 4, 'Refactorizar Servicio de Gestión de Cookies Total', 'Implementar auditoría y registro de consentimiento de cookies', 1, 4, 11.0, 10.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3),
(299, 2, 4, 'Implementar Sistema de Gestión de Subscripciones Corporativas', 'Soportar facturación por uso y planes personalizados', 3, 6, 17.0, 16.5, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 2),
(300, 2, 4, 'Crear Componente de Tabla con Columnas Agrupadas y Colapsables', 'Mostrar datos jerárquicos de forma organizada', 1, 4, 8.0, 7.7, 100.0, 10, 15, 17, 1, '2025-05-20 00:42:59', '2025-05-20 00:42:59', 3, 3)
SET IDENTITY_INSERT tarea OFF




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




