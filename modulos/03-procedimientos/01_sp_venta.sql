-- =====================================================
-- SECCIÓN 4: GENERANDO VENTAS Y PROBLEMA CON PK
-- Archivo: 01_sp_venta.sql
-- =====================================================
-- Descripción: Procedimiento almacenado para generar ventas aleatorias
-- Orden de ejecución: 7 de 12
-- Requisitos: Funciones f_aleatorio, f_cliente_aleatorio, f_producto_aleatorio, f_vendedor_aleatorio creadas
-- =====================================================

-- =====================================================
-- PROCEDIMIENTO: sp_venta
-- =====================================================
-- Descripción: Genera una venta (factura + items) con datos aleatorios
-- Parámetros:
--   - fecha: Fecha de la venta (DATE)
--   - maxitems: Número máximo de ítems en la factura (INT)
--   - maxcantidad: Cantidad máxima por ítem (INT)
-- Mejoras implementadas:
--   - Uso de IFNULL para evitar NULL cuando no hay facturas
--   - Validación de productos duplicados en la misma factura
-- =====================================================

DROP PROCEDURE IF EXISTS sp_venta;

DELIMITER $$
CREATE PROCEDURE `sp_venta`(fecha DATE, maxitems INT, maxcantidad INT)
BEGIN
    DECLARE vcliente VARCHAR(11);
    DECLARE vproducto VARCHAR(10);
    DECLARE vvendedor VARCHAR(5);
    DECLARE vcantidad INT;
    DECLARE vprecio FLOAT;
    DECLARE vitens INT;
    DECLARE vnfactura INT;
    DECLARE vcontador INT DEFAULT 1;
    DECLARE vnumitems INT;
    
    -- Obtener el siguiente número de factura (mejora: usa IFNULL para evitar NULL)
    SELECT IFNULL(MAX(NUMERO), 0) + 1 INTO vnfactura FROM facturas;
    
    -- Seleccionar cliente y vendedor aleatorios
    SET vcliente = f_cliente_aleatorio();
    SET vvendedor = f_vendedor_aleatorio();
    
    -- Insertar la factura
    INSERT INTO facturas (NUMERO, FECHA, DNI, MATRICULA, IMPUESTO) 
    VALUES (vnfactura, fecha, vcliente, vvendedor, 0.16);
    
    -- Determinar cuántos ítems tendrá la factura
    SET vitens = f_aleatorio(1, maxitems);
    
    -- Generar los ítems de la factura
    WHILE vcontador <= vitens
    DO
        SET vproducto = f_producto_aleatorio();
        
        -- Verificar que el producto no esté ya en esta factura (evita duplicados)
        SELECT COUNT(*) INTO vnumitems FROM items
        WHERE CODIGO = vproducto AND NUMERO = vnfactura;
        
        -- Solo insertar si el producto no está duplicado
        IF vnumitems = 0 THEN
            SET vcantidad = f_aleatorio(1, maxcantidad);
            SELECT PRECIO INTO vprecio FROM productos WHERE CODIGO = vproducto;
            INSERT INTO items(NUMERO, CODIGO, CANTIDAD, PRECIO) 
            VALUES(vnfactura, vproducto, vcantidad, vprecio);
        END IF;
        
        SET vcontador = vcontador + 1;
    END WHILE;
END $$
DELIMITER ;

-- =====================================================
-- PRUEBAS
-- =====================================================
-- Generar una venta con fecha '2021-06-19', hasta 3 items, cantidad máxima 100
CALL sp_venta('2021-06-19', 3, 100);

-- Verificar la factura creada
SELECT MAX(NUMERO) AS ultima_factura FROM facturas;

-- Ver el detalle de la última factura
SELECT f.*, i.CODIGO, i.CANTIDAD, i.PRECIO 
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
WHERE f.NUMERO = (SELECT MAX(NUMERO) FROM facturas);

-- =====================================================
-- NOTA HISTÓRICA: Problema con PK
-- =====================================================
-- En versiones anteriores del curso, la tabla facturas usaba VARCHAR(5) para NUMERO.
-- Esto causaba problemas:
--   1. Ordenamiento incorrecto (ej: '10' < '2' en ordenamiento de strings)
--   2. Cálculo de MAX() inconsistente
--   3. Dificultad para generar números secuenciales
-- 
-- Solución implementada:
--   - Cambio de NUMERO a INT NOT NULL
--   - Uso de IFNULL(MAX(NUMERO), 0) + 1 para generar el siguiente número
--   - Las tablas se recrearon en 01_create_database_and_tables.sql
