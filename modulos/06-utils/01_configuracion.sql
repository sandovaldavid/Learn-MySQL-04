-- =====================================================
-- CONFIGURACIÓN INICIAL DEL SISTEMA
-- Archivo: 01_configuracion.sql
-- =====================================================
-- Descripción: Configuraciones necesarias para ejecutar el proyecto
-- Orden de ejecución: Ejecutar ANTES de crear funciones y procedimientos
-- =====================================================

-- =====================================================
-- OPCIÓN 1: Configuración de sesión (RECOMENDADA)
-- =====================================================
-- Esta configuración solo afecta a la sesión actual
-- Es más segura y no requiere privilegios SUPER

SET SESSION log_bin_trust_function_creators = 1;

-- =====================================================
-- OPCIÓN 2: Configuración global (SI LA OPCIÓN 1 FALLA)
-- =====================================================
-- Esta configuración es permanente y afecta a todas las conexiones
-- Requiere privilegios SUPER o ser administrador del servidor
-- Solo usar si la opción 1 no funciona

-- SET GLOBAL log_bin_trust_function_creators = 1;

-- =====================================================
-- VERIFICAR CONFIGURACIÓN
-- =====================================================
-- Ver el valor actual de la variable
SHOW VARIABLES LIKE 'log_bin_trust_function_creators';

-- =====================================================
-- INFORMACIÓN ADICIONAL
-- =====================================================
-- Esta configuración es necesaria cuando:
-- - El servidor MySQL tiene el binary logging (binlog) activado
-- - Se quieren crear funciones o procedimientos almacenados
-- - El usuario no tiene privilegios SUPER
--
-- Alternativas si no puedes cambiar esta configuración:
-- 1. Pedir al DBA que active log_bin_trust_function_creators=1 en my.cnf
-- 2. Usar DETERMINISTIC o NO SQL en la definición de funciones
-- 3. Pedir privilegios SUPER al usuario
--
-- Más información:
-- https://dev.mysql.com/doc/refman/8.0/en/stored-programs-logging.html
