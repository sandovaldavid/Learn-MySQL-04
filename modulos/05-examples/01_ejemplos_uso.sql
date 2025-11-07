-- =====================================================
-- ARCHIVO DE EJEMPLOS Y PRUEBAS
-- Archivo: 01_ejemplos_uso.sql
-- =====================================================
-- Descripción: Ejemplos de uso del sistema de ventas
-- Orden de ejecución: 11 de 12
-- Requisitos: Todos los archivos anteriores ejecutados
-- =====================================================

-- =====================================================
-- EJEMPLO 1: Generar ventas individuales
-- =====================================================

-- Generar una venta para el 19 de junio de 2021
-- Parámetros: fecha, máximo de items (3), cantidad máxima por item (100)
CALL sp_venta('2021-06-19', 3, 100);

-- Generar otra venta para el 22 de junio de 2021
-- Parámetros: fecha, máximo de items (15), cantidad máxima por item (100)
CALL sp_venta('2021-06-22', 15, 100);

-- =====================================================
-- EJEMPLO 2: Consultar facturación por fecha
-- =====================================================

-- Ver el resumen de facturación (actualizado automáticamente por triggers)
SELECT * FROM facturacion ORDER BY FECHA;

-- Ver facturación de una fecha específica
SELECT * FROM facturacion WHERE FECHA = '2021-06-22';

-- =====================================================
-- EJEMPLO 3: Consultar facturas y sus items
-- =====================================================

-- Ver todas las facturas con sus items
SELECT 
    f.NUMERO,
    f.FECHA,
    f.DNI,
    c.NOMBRE AS CLIENTE,
    f.MATRICULA,
    v.NOMBRE AS VENDEDOR,
    i.CODIGO,
    p.DESCRIPCION AS PRODUCTO,
    i.CANTIDAD,
    i.PRECIO,
    (i.CANTIDAD * i.PRECIO) AS SUBTOTAL
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
INNER JOIN clientes c ON f.DNI = c.DNI
INNER JOIN vendedores v ON f.MATRICULA = v.MATRICULA
INNER JOIN productos p ON i.CODIGO = p.CODIGO
ORDER BY f.NUMERO, i.CODIGO;

-- Ver el detalle de la última factura generada
SELECT 
    f.*,
    i.CODIGO,
    i.CANTIDAD,
    i.PRECIO,
    (i.CANTIDAD * i.PRECIO) AS SUBTOTAL
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
WHERE f.NUMERO = (SELECT MAX(NUMERO) FROM facturas);

-- =====================================================
-- EJEMPLO 4: Estadísticas de ventas
-- =====================================================

-- Total de ventas por fecha
SELECT 
    FECHA,
    COUNT(DISTINCT NUMERO) AS total_facturas,
    VENTA_TOTAL
FROM facturacion
ORDER BY FECHA;

-- Total general de ventas
SELECT SUM(VENTA_TOTAL) AS venta_total_general FROM facturacion;

-- Productos más vendidos
SELECT 
    p.CODIGO,
    p.DESCRIPCION,
    p.SABOR,
    SUM(i.CANTIDAD) AS cantidad_total_vendida,
    SUM(i.CANTIDAD * i.PRECIO) AS ingresos_totales
FROM items i
INNER JOIN productos p ON i.CODIGO = p.CODIGO
GROUP BY p.CODIGO, p.DESCRIPCION, p.SABOR
ORDER BY cantidad_total_vendida DESC
LIMIT 10;

-- Clientes con más compras
SELECT 
    c.DNI,
    c.NOMBRE,
    COUNT(DISTINCT f.NUMERO) AS total_facturas,
    SUM(i.CANTIDAD * i.PRECIO) AS total_gastado
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
INNER JOIN clientes c ON f.DNI = c.DNI
GROUP BY c.DNI, c.NOMBRE
ORDER BY total_gastado DESC
LIMIT 10;

-- Vendedores con más ventas
SELECT 
    v.MATRICULA,
    v.NOMBRE,
    COUNT(DISTINCT f.NUMERO) AS total_facturas,
    SUM(i.CANTIDAD * i.PRECIO) AS total_vendido
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
INNER JOIN vendedores v ON f.MATRICULA = v.MATRICULA
GROUP BY v.MATRICULA, v.NOMBRE
ORDER BY total_vendido DESC;

-- =====================================================
-- EJEMPLO 5: Generar múltiples ventas (simulación)
-- =====================================================

-- Generar 10 ventas para diferentes fechas
-- Descomentar para ejecutar

-- CALL sp_venta('2021-06-23', 10, 50);
-- CALL sp_venta('2021-06-23', 8, 75);
-- CALL sp_venta('2021-06-24', 12, 100);
-- CALL sp_venta('2021-06-24', 5, 30);
-- CALL sp_venta('2021-06-25', 15, 80);
-- CALL sp_venta('2021-06-25', 7, 40);
-- CALL sp_venta('2021-06-26', 20, 100);
-- CALL sp_venta('2021-06-26', 3, 20);
-- CALL sp_venta('2021-06-27', 9, 60);
-- CALL sp_venta('2021-06-27', 11, 90);

-- =====================================================
-- EJEMPLO 6: Verificar funcionamiento de triggers
-- =====================================================

-- Ver facturación antes de insertar
SELECT * FROM facturacion WHERE FECHA = '2021-06-28';

-- Generar una nueva venta
CALL sp_venta('2021-06-28', 5, 50);

-- Ver facturación después de insertar (debe actualizarse automáticamente)
SELECT * FROM facturacion WHERE FECHA = '2021-06-28';
