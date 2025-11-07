-- =====================================================
-- SECCIÓN 5: STORED PROCEDURES Y TRIGGERS
-- Archivo: 02_triggers_facturacion.sql
-- =====================================================
-- Descripción: Triggers para mantener actualizada la tabla facturacion
-- Orden de ejecución: 10 de 12
-- Requisitos: Tabla facturacion creada, procedimiento sp_triggers creado
-- =====================================================

-- =====================================================
-- LIMPIAR TRIGGERS EXISTENTES (si existen)
-- =====================================================
DROP TRIGGER IF EXISTS TG_FACTURACION_INSERT;
DROP TRIGGER IF EXISTS TG_FACTURACION_DELETE;
DROP TRIGGER IF EXISTS TG_FACTURACION_UPDATE;

-- =====================================================
-- TRIGGER: TG_FACTURACION_INSERT
-- =====================================================
-- Descripción: Se ejecuta después de insertar un nuevo ítem
-- Acción: Llama a sp_triggers para recalcular facturación
-- =====================================================

DELIMITER //
CREATE TRIGGER TG_FACTURACION_INSERT 
AFTER INSERT ON items
FOR EACH ROW 
BEGIN
    CALL sp_triggers();
END //
DELIMITER ;

-- =====================================================
-- TRIGGER: TG_FACTURACION_DELETE
-- =====================================================
-- Descripción: Se ejecuta después de eliminar un ítem
-- Acción: Llama a sp_triggers para recalcular facturación
-- =====================================================

DELIMITER //
CREATE TRIGGER TG_FACTURACION_DELETE
AFTER DELETE ON items
FOR EACH ROW 
BEGIN
    CALL sp_triggers();
END //
DELIMITER ;

-- =====================================================
-- TRIGGER: TG_FACTURACION_UPDATE
-- =====================================================
-- Descripción: Se ejecuta después de actualizar un ítem
-- Acción: Llama a sp_triggers para recalcular facturación
-- =====================================================

DELIMITER //
CREATE TRIGGER TG_FACTURACION_UPDATE
AFTER UPDATE ON items
FOR EACH ROW 
BEGIN
    CALL sp_triggers();
END //
DELIMITER ;

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Ver los triggers creados
-- SHOW TRIGGERS LIKE 'items';

-- Listar todos los triggers
-- SELECT 
--     TRIGGER_NAME, 
--     EVENT_MANIPULATION, 
--     EVENT_OBJECT_TABLE, 
--     ACTION_TIMING
-- FROM information_schema.TRIGGERS
-- WHERE TRIGGER_SCHEMA = DATABASE();
