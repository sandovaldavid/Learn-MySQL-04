-- =====================================================
-- SECCIÓN 1: PROYECTANDO LA BASE DE DATOS
-- Archivo: 03_seed_vendedores.sql
-- =====================================================
-- Descripción: Carga de datos iniciales para la tabla vendedores
-- Orden de ejecución: 3 de 12
-- Requisitos: Tabla vendedores creada (ejecutar 01_create_database_and_tables.sql primero)
-- =====================================================

-- OPCIÓN 1: Insertar vendedores manualmente
-- Descomentar y ajustar según los datos reales

-- INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION) 
-- VALUES ('00235', 'Márcio Almeida Silva', 0.08);
-- 
-- INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION) 
-- VALUES ('00236', 'Cláudia Morais', 0.08);
-- 
-- INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION) 
-- VALUES ('00237', 'Roberta Martins', 0.11);
-- 
-- INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION) 
-- VALUES ('00238', 'Péricles Alves', 0.11);

-- =====================================================
-- OPCIÓN 2: Cargar desde archivo CSV
-- =====================================================
-- Si tienes el archivo vendedores.csv en data/csv/, usa:
-- LOAD DATA INFILE '/ruta/completa/data/csv/vendedores.csv'
-- INTO TABLE vendedores
-- FIELDS TERMINATED BY ',' 
-- ENCLOSED BY '"'
-- LINES TERMINATED BY '\n'
-- IGNORE 1 ROWS
-- (MATRICULA, NOMBRE, PORCENTAJE_COMISION);

-- Nota: Ajusta la ruta según tu sistema operativo
-- En Linux: /home/usuario/workspaces/.../data/csv/vendedores.csv
-- En Windows: C:/Users/usuario/.../data/csv/vendedores.csv
-- Requiere privilegios FILE y configuración secure_file_priv

-- =====================================================
-- OPCIÓN 3: Importar desde dump de jugos_ventas
-- =====================================================
-- Si los datos existen en jugos_ventas.tabla_de_vendedores:
-- INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION)
-- SELECT MATRICULA, NOMBRE, PORCENTAJE_COMISION 
-- FROM jugos_ventas.tabla_de_vendedores;

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Verificar los datos insertados
-- SELECT COUNT(*) AS total_vendedores FROM vendedores;
-- SELECT * FROM vendedores;
