-- Base de Datos I - Unidad 4 - Ej20: Coworking
-- Script portable (SQLite / MySQL). En SQLite activar antes: PRAGMA foreign_keys = ON;

DROP TABLE IF EXISTS CONSUMO;
DROP TABLE IF EXISTS RESERVA;
DROP TABLE IF EXISTS ACCESO;
DROP TABLE IF EXISTS TARJETA_RFID;
DROP TABLE IF EXISTS SERVICIO;
DROP TABLE IF EXISTS ESPACIO_TRABAJO;
DROP TABLE IF EXISTS MIEMBRO;

CREATE TABLE MIEMBRO (
    id_miembro INT PRIMARY KEY,
    dni_miembro INT,
    nombre_miembro VARCHAR(50),
    empresa VARCHAR(50),
    email_miembro VARCHAR(50) UNIQUE,
    telefono_miembro VARCHAR(100),
    fecha_alta DATE
);

CREATE TABLE ESPACIO_TRABAJO (
    id_espacio INT PRIMARY KEY,
    codigo_espacio VARCHAR(50) UNIQUE,
    nombre_espacio VARCHAR(50),
    tipo_espacio VARCHAR(50),
    ubicacion_piso INT,
    capacidad_maxima INT,
    tarifa_hora DECIMAL(12,2),
    tarifa_jornada DECIMAL(12,2)
);

CREATE TABLE SERVICIO (
    id_servicio INT PRIMARY KEY,
    codigo_servicio VARCHAR(50) UNIQUE,
    nombre_servicio VARCHAR(50),
    descripcion_servicio VARCHAR(100),
    precio_unitario DECIMAL(12,2),
    tipo_servicio VARCHAR(50)
);

CREATE TABLE TARJETA_RFID (
    id_tarjeta INT PRIMARY KEY,
    id_miembro INT,
    numero_tarjeta VARCHAR(50),
    fecha_emision DATE,
    fecha_vencimiento DATE,
    estado_tarjeta VARCHAR(50),
    tipo_tarjeta VARCHAR(50),
    FOREIGN KEY (id_miembro) REFERENCES MIEMBRO(id_miembro)
);

CREATE TABLE ACCESO (
    id_acceso INT PRIMARY KEY,
    id_tarjeta INT,
    fecha_hora_fichaje DATETIME,
    sentido_movimiento VARCHAR(50),
    id_molinete VARCHAR(100),
    zona_acceso VARCHAR(50),
    resultado_validacion VARCHAR(100),
    FOREIGN KEY (id_tarjeta) REFERENCES TARJETA_RFID(id_tarjeta)
);

CREATE TABLE RESERVA (
    id_reserva INT PRIMARY KEY,
    id_miembro INT,
    id_espacio INT,
    numero_reserva VARCHAR(100),
    fecha_uso DATE,
    hora_inicio TIME,
    hora_fin TIME,
    estado_reserva VARCHAR(50),
    importe_estimado DECIMAL(12,2),
    FOREIGN KEY (id_miembro) REFERENCES MIEMBRO(id_miembro),
    FOREIGN KEY (id_espacio) REFERENCES ESPACIO_TRABAJO(id_espacio)
);

CREATE TABLE CONSUMO (
    id_consumo INT PRIMARY KEY,
    id_miembro INT,
    id_servicio INT,
    numero_consumo VARCHAR(100),
    fecha_consumo DATE,
    cantidad INT,
    costo_total DECIMAL(12,2),
    FOREIGN KEY (id_miembro) REFERENCES MIEMBRO(id_miembro),
    FOREIGN KEY (id_servicio) REFERENCES SERVICIO(id_servicio)
);

-- Datos de MIEMBRO
INSERT INTO MIEMBRO (id_miembro, dni_miembro, nombre_miembro, empresa, email_miembro) VALUES (1, 40111000, 'Ariel', 'Freelance', 'ariel@mail.com');
INSERT INTO MIEMBRO (id_miembro, dni_miembro, nombre_miembro, empresa, email_miembro) VALUES (2, 40333000, 'Cristian', 'Freelance', 'cristian@mail.com');
INSERT INTO MIEMBRO (id_miembro, dni_miembro, nombre_miembro, empresa, email_miembro) VALUES (3, 40444000, 'Delfina', 'Bodega Sur', 'delfina@mail.com');
INSERT INTO MIEMBRO (id_miembro, dni_miembro, nombre_miembro, empresa, email_miembro) VALUES (4, 40555000, 'Emanuel', 'StartLab', 'emanuel@mail.com');

-- Datos de ESPACIO_TRABAJO
INSERT INTO ESPACIO_TRABAJO (id_espacio, codigo_espacio, nombre_espacio, tipo_espacio, tarifa_hora) VALUES (1, 'ESP-01', 'Escritorio Flex 1', 'Escritorio', 2500);
INSERT INTO ESPACIO_TRABAJO (id_espacio, codigo_espacio, nombre_espacio, tipo_espacio, tarifa_hora) VALUES (2, 'ESP-03', 'Sala de Reuniones 1', 'Sala', 6000);
INSERT INTO ESPACIO_TRABAJO (id_espacio, codigo_espacio, nombre_espacio, tipo_espacio, tarifa_hora) VALUES (3, 'ESP-04', 'Escritorio Flex 2', 'Escritorio', 2500);
INSERT INTO ESPACIO_TRABAJO (id_espacio, codigo_espacio, nombre_espacio, tipo_espacio, tarifa_hora) VALUES (4, 'ESP-05', 'Sala Podcast', 'Sala', 4000);

-- Datos de SERVICIO
INSERT INTO SERVICIO (id_servicio, codigo_servicio, nombre_servicio, precio_unitario, tipo_servicio) VALUES (1, 'SRV-01', 'Café ilimitado', 3000, 'Bebida');
INSERT INTO SERVICIO (id_servicio, codigo_servicio, nombre_servicio, precio_unitario, tipo_servicio) VALUES (2, 'SRV-02', 'Impresiones', 50, 'Oficina');
INSERT INTO SERVICIO (id_servicio, codigo_servicio, nombre_servicio, precio_unitario, tipo_servicio) VALUES (3, 'SRV-04', 'Estacionamiento', 5000, 'Movilidad');
INSERT INTO SERVICIO (id_servicio, codigo_servicio, nombre_servicio, precio_unitario, tipo_servicio) VALUES (4, 'SRV-05', 'Sala de reuniones por hora', 6000, 'Alquiler');

-- Datos de TARJETA_RFID
INSERT INTO TARJETA_RFID (id_tarjeta, id_miembro, numero_tarjeta, estado_tarjeta, tipo_tarjeta) VALUES (1, 1, 'RF-1001', 'Activa', 'Mensual');
INSERT INTO TARJETA_RFID (id_tarjeta, id_miembro, numero_tarjeta, estado_tarjeta, tipo_tarjeta) VALUES (2, 2, 'RF-1003', 'Activa', 'Diaria');
INSERT INTO TARJETA_RFID (id_tarjeta, id_miembro, numero_tarjeta, estado_tarjeta, tipo_tarjeta) VALUES (3, 3, 'RF-1004', 'Bloqueada', 'Mensual');
INSERT INTO TARJETA_RFID (id_tarjeta, id_miembro, numero_tarjeta, estado_tarjeta, tipo_tarjeta) VALUES (4, 4, 'RF-1005', 'Activa', 'Mensual');

-- Datos de ACCESO
INSERT INTO ACCESO (id_acceso, id_tarjeta, fecha_hora_fichaje, sentido_movimiento, zona_acceso) VALUES (1, 1, '2026-10-01 08:55', 'Entrada', 'Hall principal');
INSERT INTO ACCESO (id_acceso, id_tarjeta, fecha_hora_fichaje, sentido_movimiento, zona_acceso) VALUES (2, 1, '2026-10-01 18:10', 'Salida', 'Hall principal');
INSERT INTO ACCESO (id_acceso, id_tarjeta, fecha_hora_fichaje, sentido_movimiento, zona_acceso) VALUES (3, 2, '2026-10-02 10:05', 'Entrada', 'Hall principal');
INSERT INTO ACCESO (id_acceso, id_tarjeta, fecha_hora_fichaje, sentido_movimiento, zona_acceso) VALUES (4, 4, '2026-10-02 08:40', 'Entrada', 'Oficinas');

-- Datos de RESERVA
INSERT INTO RESERVA (id_reserva, id_miembro, id_espacio, fecha_uso, estado_reserva) VALUES (1, 1, 1, '2026-10-05', 'Confirmada');
INSERT INTO RESERVA (id_reserva, id_miembro, id_espacio, fecha_uso, estado_reserva) VALUES (2, 2, 2, '2026-10-07', 'Cancelada');
INSERT INTO RESERVA (id_reserva, id_miembro, id_espacio, fecha_uso, estado_reserva) VALUES (3, 3, 3, '2026-10-08', 'Confirmada');
INSERT INTO RESERVA (id_reserva, id_miembro, id_espacio, fecha_uso, estado_reserva) VALUES (4, 4, 4, '2026-10-09', 'Confirmada');

-- Datos de CONSUMO
INSERT INTO CONSUMO (id_consumo, id_miembro, id_servicio, cantidad, fecha_consumo) VALUES (1, 1, 1, 1, '2026-10-01');
INSERT INTO CONSUMO (id_consumo, id_miembro, id_servicio, cantidad, fecha_consumo) VALUES (2, 1, 2, 40, '2026-10-01');
INSERT INTO CONSUMO (id_consumo, id_miembro, id_servicio, cantidad, fecha_consumo) VALUES (3, 2, 3, 2, '2026-10-02');
INSERT INTO CONSUMO (id_consumo, id_miembro, id_servicio, cantidad, fecha_consumo) VALUES (4, 4, 4, 3, '2026-10-03');
