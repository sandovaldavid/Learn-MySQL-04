-- =====================================================
-- SECCIÓN 5: STORED PROCEDURES Y TRIGGERS
-- Archivo: 01_tabla_facturacion.sql
-- =====================================================
-- Descripción: Creación de tabla para almacenar resumen de facturación
-- Orden de ejecución: 9 de 12
-- Requisitos: Tablas facturas e items creadas
-- =====================================================

-- =====================================================
-- TABLA: facturacion
-- =====================================================
-- Descripción: Tabla de resumen que almacena las ventas totales por fecha
-- Esta tabla es actualizada automáticamente por triggers
-- =====================================================

CREATE TABLE IF NOT EXISTS facturacion (
    FECHA DATE NULL,
    VENTA_TOTAL FLOAT
);

-- =====================================================
-- VERIFICACIÓN
-- =====================================================
-- Ver estructura de la tabla
-- DESCRIBE facturacion;

-- Ver contenido (inicialmente vacío)
-- SELECT * FROM facturacion;
