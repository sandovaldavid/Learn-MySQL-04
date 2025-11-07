-- =====================================================
-- SECCIÓN 5: STORED PROCEDURES Y TRIGGERS
-- Archivo: 02_sp_triggers.sql
-- =====================================================
-- Descripción: Procedimiento para actualizar tabla de facturación
-- Orden de ejecución: 8 de 12
-- Requisitos: Tabla facturacion creada
-- =====================================================

-- =====================================================
-- PROCEDIMIENTO: sp_triggers
-- =====================================================
-- Descripción: Recalcula la tabla facturacion con las ventas totales por fecha
-- Este procedimiento es llamado por los triggers para mantener actualizada
-- la tabla de facturación cada vez que hay cambios en items
-- =====================================================

DROP PROCEDURE IF EXISTS sp_triggers;

DELIMITER $$
CREATE PROCEDURE `sp_triggers`()
BEGIN
    -- Limpiar la tabla de facturación
    DELETE FROM facturacion;
    
    -- Recalcular las ventas totales por fecha
    INSERT INTO facturacion
    SELECT 
        A.FECHA, 
        SUM(B.CANTIDAD * B.PRECIO) AS VENTA_TOTAL
    FROM facturas A
    INNER JOIN items B ON A.NUMERO = B.NUMERO
    GROUP BY A.FECHA;
END $$
DELIMITER ;

-- =====================================================
-- PRUEBA
-- =====================================================
-- Ejecutar el procedimiento manualmente
-- CALL sp_triggers();

-- Verificar el contenido de facturacion
-- SELECT * FROM facturacion ORDER BY FECHA;
