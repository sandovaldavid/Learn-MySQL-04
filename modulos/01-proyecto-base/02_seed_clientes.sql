-- =====================================================
-- SECCIÓN 1: PROYECTANDO LA BASE DE DATOS
-- Archivo: 02_seed_clientes.sql
-- =====================================================
-- Descripción: Carga de datos iniciales para la tabla clientes
-- Orden de ejecución: 2 de 12
-- Requisitos: Tabla clientes creada (ejecutar 01_create_database_and_tables.sql primero)
-- =====================================================

-- Insertar primer cliente (ejemplo individual)
INSERT INTO clientes VALUES(
    '3623344710', 
    'Marcos Rosas', 
    'Av. Universidad',
    'Del Valle', 
    'Ciudad de México', 
    'EM', 
    '22002012', 
    '1995-01-13', 
    26, 
    'M',
    110000, 
    220000, 
    1
);

-- Insertar múltiples clientes
INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('2600586709', 'Raúl Meneses', 'Estudiantes 89', 'Centro', 'Ciudad de México', 'EM', '22002012', '1999-08-13', 21, 'M', 120000, 210000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('19290992743', 'Rodrigo Villa', 'Libertadores 65', 'Héroes', 'Ciudad de México', 'EM', '21002020', '1998-05-30', 22, 'M', 120000, 220000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('9283760794', 'Edson Calisaya', 'Sta Úrsula Xitla', 'Barrio del Niño Jesús', 'Ciudad de México', 'EM', '22002002', '1995-01-07', 25, 'M', 150000, 250000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('7771579779', 'Marcelo Perez', 'F.C. de Cuernavaca 13', 'Carola', 'Ciudad de México', 'EM', '88202912', '1992-01-25', 29, 'M', 120000, 200000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('5576228758', 'Patricia Olivera', 'Pachuca 75', 'Condesa', 'Ciudad de México', 'EM', '88192029', '1995-01-14', 25, 'F', 70000, 160000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('8502682733', 'Luis Silva', 'Prol. 16 de Septiembre 1156', 'Contadero', 'Ciudad de México', 'EM', '82122020', '1995-01-07', 25, 'M', 110000, 190000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('1471156710', 'Erica Carvajo', 'Heriberto Frías 1107', 'Del Valle', 'Ciudad de México', 'EM', '80012212', '1990-01-01', 30, 'F', 170000, 245000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('50534475787', 'Abel Pintos', 'Carr. México-Toluca 1499', 'Cuajimalpa', 'Ciudad de México', 'EM', '22000212', '1995-01-11', 25, 'M', 170000, 260000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('5840119709', 'Gabriel Roca', 'Eje Central Lázaro Cárdenas 911', 'Del Valle', 'Ciudad de México', 'EM', '80010221', '1985-01-16', 36, 'M', 140000, 210000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('8719655770', 'Carlos Santivañez', 'Calz. del Hueso 363', 'Floresta Coyoacán', 'Ciudad de México', 'EM', '81192002', '1983-01-20', 37, 'M', 200000, 240000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('5648641702', 'Paolo Mendez', 'Martires de Tacubaya 65', 'Héroes de Padierna', 'Ciudad de México', 'EM', '21002020', '1991-01-30', 29, 'M', 120000, 220000, 0);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('492472718', 'Jorge Castro', 'Federal México-Toluca 5690', 'Locaxco', 'Ciudad de México', 'EM', '22012002', '1994-01-19', 26, 'M', 75000, 95000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('9275760794', 'Alberto Rodriguez', 'Circunvalación Oblatos 690', 'Oblatos', 'Guadalajara', 'JC', '44700000', '1991-12-28', 26, 'M', 75000, 95000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('94387575700', 'María Jimenez', 'Av. Libertadores 457', 'Barragán Hernández', 'Guadalajara', 'JC', '44469000', '1995-05-13', 26, 'F', 120000, 300000, 1);

INSERT INTO clientes (DNI, NOMBRE, DIRECCION, BARRIO, CIUDAD, ESTADO, CP, FECHA_NACIMIENTO, EDAD, SEXO, LIMITE_CREDITO, VOLUMEN_COMPRA, PRIMERA_COMPRA) 
VALUES ('95939180787', 'Ximena Gómez', 'Jaguares 822', 'Alcalde Barranquitas', 'Guadalajara', 'JC', '44270000', '1992-01-05', 16, 'F', 90000, 18000, 0);

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Verificar los datos insertados
SELECT COUNT(*) AS total_clientes FROM clientes;
-- SELECT * FROM clientes;
