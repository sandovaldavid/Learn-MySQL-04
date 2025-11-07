-- =====================================================
-- SECCIÓN 1: PROYECTANDO LA BASE DE DATOS
-- Archivo: 01_create_database_and_tables.sql
-- =====================================================
-- Descripción: Creación de la base de datos y tablas principales
-- Orden de ejecución: 1 de 12
-- Requisitos: Privilegios CREATE DATABASE, CREATE TABLE
-- =====================================================

-- Crear la base de datos principal (si no existe)
-- Nota: Ajusta el nombre según tus necesidades
-- CREATE DATABASE IF NOT EXISTS jugos_ventas_local;
-- USE jugos_ventas_local;

-- =====================================================
-- TABLA: clientes
-- =====================================================
CREATE TABLE IF NOT EXISTS clientes (
    DNI VARCHAR(11) NOT NULL,
    NOMBRE VARCHAR(100) NULL,
    DIRECCION VARCHAR(150),
    BARRIO VARCHAR(50),
    CIUDAD VARCHAR(50),
    ESTADO VARCHAR(10),
    CP VARCHAR(10),
    FECHA_NACIMIENTO DATE,
    EDAD SMALLINT,
    SEXO VARCHAR(1),
    LIMITE_CREDITO FLOAT,
    VOLUMEN_COMPRA FLOAT,
    PRIMERA_COMPRA BIT,
    PRIMARY KEY (DNI)
);

-- =====================================================
-- TABLA: productos
-- =====================================================
CREATE TABLE IF NOT EXISTS productos (
    CODIGO VARCHAR(10) NOT NULL,
    DESCRIPCION VARCHAR(100),
    SABOR VARCHAR(50),
    TAMANO VARCHAR(50),
    ENVASE VARCHAR(50),
    PRECIO FLOAT,
    PRIMARY KEY (CODIGO)
);

-- =====================================================
-- TABLA: vendedores
-- =====================================================
-- Nota: Esta tabla debe existir antes de crear facturas
-- Los datos se cargarán en el siguiente archivo o desde CSV
CREATE TABLE IF NOT EXISTS vendedores (
    MATRICULA VARCHAR(5) NOT NULL,
    NOMBRE VARCHAR(100),
    PORCENTAJE_COMISION FLOAT,
    PRIMARY KEY (MATRICULA)
);

-- =====================================================
-- TABLA: facturas (VERSIÓN MEJORADA CON INT)
-- =====================================================
-- Nota: Se usa INT en lugar de VARCHAR para NUMERO
-- Esto resuelve problemas de ordenamiento y facilita auto-incremento
CREATE TABLE IF NOT EXISTS facturas (
    NUMERO INT NOT NULL,
    FECHA DATE,
    DNI VARCHAR(11) NOT NULL,
    MATRICULA VARCHAR(5) NOT NULL,
    IMPUESTO FLOAT,
    PRIMARY KEY (NUMERO),
    FOREIGN KEY (DNI) REFERENCES clientes(DNI),
    FOREIGN KEY (MATRICULA) REFERENCES vendedores(MATRICULA)
);

-- =====================================================
-- TABLA: items
-- =====================================================
CREATE TABLE IF NOT EXISTS items (
    NUMERO INT NOT NULL,
    CODIGO VARCHAR(10) NOT NULL,
    CANTIDAD INT,
    PRECIO FLOAT,
    PRIMARY KEY (NUMERO, CODIGO),
    FOREIGN KEY (NUMERO) REFERENCES facturas(NUMERO),
    FOREIGN KEY (CODIGO) REFERENCES productos(CODIGO)
);

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Descomentar para verificar las tablas creadas
-- SHOW TABLES;
-- DESCRIBE clientes;
-- DESCRIBE productos;
-- DESCRIBE vendedores;
-- DESCRIBE facturas;
-- DESCRIBE items;
