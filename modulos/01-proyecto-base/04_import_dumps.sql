-- =====================================================
-- SECCIÓN 1: PROYECTANDO LA BASE DE DATOS
-- Archivo: 04_import_dumps.sql
-- =====================================================
-- Descripción: Importación de datos desde dumps de jugos_ventas
-- Orden de ejecución: 4 de 12
-- Requisitos: Dumps importados en la base de datos jugos_ventas
-- =====================================================

-- =====================================================
-- PASO 1: Crear base de datos auxiliar jugos_ventas
-- =====================================================
CREATE DATABASE IF NOT EXISTS jugos_ventas;

-- =====================================================
-- PASO 2: Importar dumps desde línea de comandos
-- =====================================================
-- Ejecutar estos comandos desde la terminal (NO dentro de MySQL):
-- 
-- mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_clientes.sql
-- mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_productos.sql
-- mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_vendedores.sql
-- mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_facturas.sql
-- mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_items_facturas.sql

-- =====================================================
-- PASO 3: Migrar datos de jugos_ventas a tablas locales
-- =====================================================
-- Una vez importados los dumps, ejecutar estas sentencias:

-- Importar items desde jugos_ventas
INSERT INTO items (NUMERO, CODIGO, CANTIDAD, PRECIO)
SELECT NUMERO, CODIGO_DEL_PRODUCTO AS CODIGO, CANTIDAD, PRECIO
FROM jugos_ventas.items_facturas;

-- Importar facturas desde jugos_ventas
INSERT INTO facturas (NUMERO, FECHA, DNI, MATRICULA, IMPUESTO)
SELECT NUMERO, FECHA_VENTA AS FECHA, DNI, MATRICULA, IMPUESTO
FROM jugos_ventas.facturas;

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Verificar que los datos se importaron correctamente
SELECT COUNT(*) AS total_facturas FROM facturas;
SELECT COUNT(*) AS total_items FROM items;

-- Consulta de ejemplo: facturas con items
-- SELECT * FROM facturas F 
-- INNER JOIN items I
-- ON F.NUMERO = I.NUMERO
-- LIMIT 10;
