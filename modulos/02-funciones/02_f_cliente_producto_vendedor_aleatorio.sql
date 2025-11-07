-- =====================================================
-- SECCIÓN 3: FUNCIÓN CLIENTE ALEATORIO
-- Archivo: 02_f_cliente_producto_vendedor_aleatorio.sql
-- =====================================================
-- Descripción: Funciones para seleccionar clientes, productos y vendedores aleatorios
-- Orden de ejecución: 6 de 12
-- Requisitos: Función f_aleatorio creada, tablas clientes/productos/vendedores con datos
-- =====================================================

-- =====================================================
-- EJEMPLOS DE USO DE LIMIT
-- =====================================================
-- Contar registros en la tabla clientes
SELECT COUNT(*) FROM clientes;

-- Obtener los primeros 5 clientes
SELECT * FROM clientes LIMIT 5;

-- Obtener 1 cliente empezando desde la posición 5 (offset)
SELECT * FROM clientes LIMIT 5, 1;

-- Obtener 1 cliente empezando desde la posición 15
SELECT * FROM clientes LIMIT 15, 1;

-- Obtener el primer cliente (posición 0)
SELECT * FROM clientes LIMIT 0, 1;

-- Obtener el segundo cliente (posición 1)
SELECT * FROM clientes LIMIT 1, 1;

-- =====================================================
-- FUNCIÓN: f_cliente_aleatorio
-- =====================================================
-- Descripción: Selecciona un DNI de cliente aleatorio
-- Retorna: DNI del cliente (VARCHAR(11))
-- =====================================================

DROP FUNCTION IF EXISTS f_cliente_aleatorio;

DELIMITER $$
CREATE FUNCTION `f_cliente_aleatorio`() RETURNS varchar(11) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE vresultado VARCHAR(11);
    DECLARE vmax INT;
    DECLARE valeatorio INT;
    
    -- Obtener el total de clientes
    SELECT COUNT(*) INTO vmax FROM clientes;
    
    -- Generar un índice aleatorio (1 a vmax)
    SET valeatorio = f_aleatorio(1, vmax);
    
    -- Ajustar para usar como offset (0-based)
    SET valeatorio = valeatorio - 1;
    
    -- Seleccionar el DNI del cliente en la posición aleatoria
    SELECT DNI INTO vresultado FROM clientes LIMIT valeatorio, 1;
    
    RETURN vresultado;
END$$
DELIMITER ;

-- =====================================================
-- FUNCIÓN: f_producto_aleatorio
-- =====================================================
-- Descripción: Selecciona un CODIGO de producto aleatorio
-- Retorna: CODIGO del producto (VARCHAR(10))
-- =====================================================

DROP FUNCTION IF EXISTS f_producto_aleatorio;

DELIMITER $$
CREATE FUNCTION `f_producto_aleatorio`() RETURNS varchar(10) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE vresultado VARCHAR(10);
    DECLARE vmax INT;
    DECLARE valeatorio INT;
    
    -- Obtener el total de productos
    SELECT COUNT(*) INTO vmax FROM productos;
    
    -- Generar un índice aleatorio (1 a vmax)
    SET valeatorio = f_aleatorio(1, vmax);
    
    -- Ajustar para usar como offset (0-based)
    SET valeatorio = valeatorio - 1;
    
    -- Seleccionar el CODIGO del producto en la posición aleatoria
    SELECT CODIGO INTO vresultado FROM productos LIMIT valeatorio, 1;
    
    RETURN vresultado;
END$$
DELIMITER ;

-- =====================================================
-- FUNCIÓN: f_vendedor_aleatorio
-- =====================================================
-- Descripción: Selecciona una MATRICULA de vendedor aleatorio
-- Retorna: MATRICULA del vendedor (VARCHAR(5))
-- =====================================================

DROP FUNCTION IF EXISTS f_vendedor_aleatorio;

DELIMITER $$
CREATE FUNCTION `f_vendedor_aleatorio`() RETURNS varchar(5) CHARSET utf8mb4
    READS SQL DATA
BEGIN
    DECLARE vresultado VARCHAR(5);
    DECLARE vmax INT;
    DECLARE valeatorio INT;
    
    -- Obtener el total de vendedores
    SELECT COUNT(*) INTO vmax FROM vendedores;
    
    -- Generar un índice aleatorio (1 a vmax)
    SET valeatorio = f_aleatorio(1, vmax);
    
    -- Ajustar para usar como offset (0-based)
    SET valeatorio = valeatorio - 1;
    
    -- Seleccionar la MATRICULA del vendedor en la posición aleatoria
    SELECT MATRICULA INTO vresultado FROM vendedores LIMIT valeatorio, 1;
    
    RETURN vresultado;
END$$
DELIMITER ;

-- =====================================================
-- PRUEBAS
-- =====================================================
-- Seleccionar un cliente aleatorio
SELECT f_cliente_aleatorio() AS CLIENTE;

-- Seleccionar un producto aleatorio
SELECT f_producto_aleatorio() AS PRODUCTO;

-- Seleccionar un vendedor aleatorio
SELECT f_vendedor_aleatorio() AS VENDEDOR;

-- Seleccionar los tres al mismo tiempo
SELECT 
    f_cliente_aleatorio() AS CLIENTE, 
    f_producto_aleatorio() AS PRODUCTO,
    f_vendedor_aleatorio() AS VENDEDOR;

-- Ejecutar varias veces para verificar la aleatoriedad
SELECT 
    f_cliente_aleatorio() AS CLIENTE1, 
    f_cliente_aleatorio() AS CLIENTE2,
    f_cliente_aleatorio() AS CLIENTE3;
