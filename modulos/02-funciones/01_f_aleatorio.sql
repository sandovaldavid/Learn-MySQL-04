-- =====================================================
-- SECCIÓN 2: FUNCIÓN ALEATORIO
-- Archivo: 01_f_aleatorio.sql
-- =====================================================
-- Descripción: Creación de función para generar números aleatorios
-- Orden de ejecución: 5 de 12
-- Requisitos: Privilegios CREATE FUNCTION
-- Advertencia: Puede requerir SET GLOBAL log_bin_trust_function_creators = 1
-- =====================================================

-- =====================================================
-- CONFIGURACIÓN INICIAL
-- =====================================================
-- OPCIÓN 1: Configuración de sesión (preferida si funciona)
-- SET SESSION log_bin_trust_function_creators = 1;

-- OPCIÓN 2: Configuración global (requiere privilegios SUPER)
-- Solo ejecutar si la opción 1 falla
-- SET GLOBAL log_bin_trust_function_creators = 1;

-- =====================================================
-- EJEMPLOS DE FUNCIÓN RAND()
-- =====================================================
-- Generar un número aleatorio entre MIN = 20 y MAX = 250
-- Fórmula: (RAND() * (MAX-MIN+1))+MIN

SELECT (RAND() * (250-20+1))+20 AS ALEATORIO;

-- Generar un número entero aleatorio
SELECT FLOOR((RAND() * (250-20+1))+20) AS ALEATORIO;

-- =====================================================
-- FUNCIÓN: f_aleatorio
-- =====================================================
-- Descripción: Genera un número entero aleatorio entre min y max (inclusivo)
-- Parámetros:
--   - min: Valor mínimo (INT)
--   - max: Valor máximo (INT)
-- Retorna: Número entero aleatorio (INT)
-- =====================================================

DROP FUNCTION IF EXISTS f_aleatorio;

DELIMITER $$
CREATE FUNCTION `f_aleatorio`(min INT, max INT) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE vresultado INT;
    SELECT FLOOR((RAND() * (max-min+1))+min) INTO vresultado;
    RETURN vresultado;
END$$
DELIMITER ;

-- =====================================================
-- PRUEBAS
-- =====================================================
-- Generar un número aleatorio entre 1 y 10
SELECT f_aleatorio(1, 10) AS RESULTADO;

-- Generar varios números aleatorios para verificar la distribución
SELECT 
    f_aleatorio(1, 10) AS num1,
    f_aleatorio(1, 10) AS num2,
    f_aleatorio(1, 10) AS num3,
    f_aleatorio(1, 10) AS num4,
    f_aleatorio(1, 10) AS num5;

-- Generar números en un rango específico (20-250)
SELECT f_aleatorio(20, 250) AS RESULTADO;
