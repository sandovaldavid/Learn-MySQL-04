# Guía de Uso - Proyecto MySQL

Esta guía detalla paso a paso cómo configurar y usar el sistema de gestión de ventas con MySQL.

## 📋 Tabla de contenidos

1. [Requisitos previos](#requisitos-previos)
2. [Orden de ejecución de scripts](#orden-de-ejecución-de-scripts)
3. [Configuración inicial](#configuración-inicial)
4. [Carga de datos](#carga-de-datos)
5. [Creación de funciones y procedimientos](#creación-de-funciones-y-procedimientos)
6. [Uso del sistema](#uso-del-sistema)
7. [Solución de problemas](#solución-de-problemas)

---

## Requisitos previos

### Software necesario

- **MySQL Server 8.0+** (o MySQL 5.7+)
- **Cliente MySQL** (mysql CLI, MySQL Workbench, DBeaver, etc.)
- Acceso con privilegios para:
  - Crear bases de datos (`CREATE DATABASE`)
  - Crear tablas (`CREATE TABLE`)
  - Crear funciones (`CREATE FUNCTION`)
  - Crear procedimientos (`CREATE PROCEDURE`)
  - Crear triggers (`CREATE TRIGGER`)

### Verificar instalación de MySQL

```bash
mysql --version
```

Deberías ver algo como: `mysql  Ver 8.0.x for Linux on x86_64`

---

## Orden de ejecución de scripts

Los scripts **DEBEN** ejecutarse en este orden específico:

| #   | Archivo                                                             | Descripción                               |
| --- | ------------------------------------------------------------------- | ----------------------------------------- |
| 1   | `modulos/06-utils/01_configuracion.sql`                             | Configuración de variables del sistema    |
| 2   | `modulos/01-proyecto-base/01_create_database_and_tables.sql`        | Creación de tablas principales            |
| 3   | `modulos/01-proyecto-base/02_seed_clientes.sql`                     | Carga de datos de clientes                |
| 4   | `modulos/01-proyecto-base/03_seed_vendedores.sql`                   | Carga de datos de vendedores              |
| 5   | Importar dumps (ver sección especial)                               | Datos externos de jugos_ventas            |
| 6   | `modulos/02-funciones/01_f_aleatorio.sql`                           | Función de números aleatorios             |
| 7   | `modulos/02-funciones/02_f_cliente_producto_vendedor_aleatorio.sql` | Funciones de selección aleatoria          |
| 8   | `modulos/03-procedimientos/01_sp_venta.sql`                         | Procedimiento de generación de ventas     |
| 9   | `modulos/04-triggers/01_tabla_facturacion.sql`                      | Tabla de resumen de facturación           |
| 10  | `modulos/03-procedimientos/02_sp_triggers.sql`                      | Procedimiento para actualizar facturación |
| 11  | `modulos/04-triggers/02_triggers_facturacion.sql`                   | Triggers de actualización automática      |
| 12  | `modulos/05-examples/01_ejemplos_uso.sql`                           | Ejemplos y pruebas                        |

---

## Configuración inicial

### Paso 1: Configurar variables de MySQL

Esta configuración es necesaria para crear funciones y procedimientos.

```bash
mysql -u root -p < modulos/06-utils/01_configuracion.sql
```

O dentro del cliente MySQL:

```sql
SET SESSION log_bin_trust_function_creators = 1;
```

**⚠️ Advertencia sobre privilegios:**

- `SET SESSION` solo afecta la sesión actual (recomendado)
- `SET GLOBAL` requiere privilegios `SUPER` y afecta a todas las conexiones
- Si ninguna opción funciona, contacta al administrador del servidor

### Paso 2: Crear la base de datos y tablas

```bash
# Opción 1: Especificar base de datos en cada comando
mysql -u root -p nombre_base_datos < modulos/01-proyecto-base/01_create_database_and_tables.sql

# Opción 2: Conectarse a la base de datos primero
mysql -u root -p
```

Dentro del cliente MySQL:

```sql
CREATE DATABASE IF NOT EXISTS jugos_ventas_local;
USE jugos_ventas_local;
SOURCE /ruta/completa/modulos/01-proyecto-base/01_create_database_and_tables.sql;
```

**Nota:** Ajusta el nombre de la base de datos según tus necesidades.

---

## Carga de datos

### Paso 3: Cargar datos de clientes

```bash
mysql -u root -p nombre_base_datos < modulos/01-proyecto-base/02_seed_clientes.sql
```

Verifica la carga:

```sql
SELECT COUNT(*) FROM clientes;  -- Debería retornar 15
```

### Paso 4: Cargar datos de vendedores

Tienes **3 opciones** para cargar vendedores:

#### Opción A: Desde CSV (recomendado)

1. Verifica que existe el archivo: `data/csv/vendedores.csv`

2. Dentro de MySQL:

```sql
LOAD DATA INFILE '/ruta/completa/data/csv/vendedores.csv'
INTO TABLE vendedores
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(MATRICULA, NOMBRE, PORCENTAJE_COMISION);
```

**⚠️ Importante:**
- Usa la ruta **absoluta** al archivo CSV
- En Linux: `/home/usuario/workspaces/.../data/csv/vendedores.csv`
- En Windows: `C:/Users/usuario/.../data/csv/vendedores.csv`
- Puede requerir configurar `secure_file_priv` en `my.cnf`

#### Opción B: Desde dumps de jugos_ventas

```sql
-- Primero importar el dump (ver siguiente sección)
INSERT INTO vendedores (MATRICULA, NOMBRE, PORCENTAJE_COMISION)
SELECT MATRICULA, NOMBRE, PORCENTAJE_COMISION 
FROM jugos_ventas.tabla_de_vendedores;
```

#### Opción C: Manualmente

Edita `modulos/01-proyecto-base/03_seed_vendedores.sql` y descomenta los INSERT.

### Paso 5: Importar dumps de jugos_ventas

Los dumps contienen datos históricos de productos, vendedores y facturas.

```bash
# 1. Crear base de datos auxiliar
mysql -u root -p -e "CREATE DATABASE IF NOT EXISTS jugos_ventas;"

# 2. Importar dumps
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_clientes.sql
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_productos.sql
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_vendedores.sql
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_facturas.sql
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_items_facturas.sql
```

**Verificar importación:**

```sql
USE jugos_ventas;
SHOW TABLES;
SELECT COUNT(*) FROM facturas;
SELECT COUNT(*) FROM items_facturas;
```

### Paso 6: Migrar datos a tablas locales

Una vez importados los dumps, ejecuta:

```bash
mysql -u root -p nombre_base_datos < modulos/01-proyecto-base/04_import_dumps.sql
```

O manualmente:

```sql
USE nombre_base_datos;

-- Importar productos (si tu tabla está vacía)
INSERT INTO productos (CODIGO, DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO)
SELECT CODIGO_DEL_PRODUCTO, DESCRIPCION, SABOR, TAMANO, ENVASE, PRECIO_DE_LISTA
FROM jugos_ventas.tabla_de_productos;

-- Importar facturas históricas
INSERT INTO facturas (NUMERO, FECHA, DNI, MATRICULA, IMPUESTO)
SELECT NUMERO, FECHA_VENTA, DNI, MATRICULA, IMPUESTO
FROM jugos_ventas.facturas;

-- Importar items históricos
INSERT INTO items (NUMERO, CODIGO, CANTIDAD, PRECIO)
SELECT NUMERO, CODIGO_DEL_PRODUCTO, CANTIDAD, PRECIO
FROM jugos_ventas.items_facturas;
```

---

## Creación de funciones y procedimientos

### Paso 7: Crear función de números aleatorios

```bash
mysql -u root -p nombre_base_datos < modulos/02-funciones/01_f_aleatorio.sql
```

**Probar:**

```sql
SELECT f_aleatorio(1, 10) AS numero_aleatorio;
```

### Paso 8: Crear funciones de selección aleatoria

```bash
mysql -u root -p nombre_base_datos < modulos/02-funciones/02_f_cliente_producto_vendedor_aleatorio.sql
```

**Probar:**

```sql
SELECT 
    f_cliente_aleatorio() AS cliente,
    f_producto_aleatorio() AS producto,
    f_vendedor_aleatorio() AS vendedor;
```

### Paso 9: Crear procedimiento de ventas

```bash
mysql -u root -p nombre_base_datos < modulos/03-procedimientos/01_sp_venta.sql
```

### Paso 10-12: Crear tabla de facturación, triggers y procedimientos

```bash
mysql -u root -p nombre_base_datos < modulos/04-triggers/01_tabla_facturacion.sql
mysql -u root -p nombre_base_datos < modulos/03-procedimientos/02_sp_triggers.sql
mysql -u root -p nombre_base_datos < modulos/04-triggers/02_triggers_facturacion.sql
```

---

## Uso del sistema

### Generar una venta

```sql
-- Sintaxis: CALL sp_venta(fecha, max_items, max_cantidad);
CALL sp_venta('2021-06-22', 15, 100);
```

Parámetros:
- `fecha`: Fecha de la venta (formato 'YYYY-MM-DD')
- `max_items`: Número máximo de productos diferentes en la factura
- `max_cantidad`: Cantidad máxima de cada producto

### Consultar facturación

```sql
-- Ver resumen por fecha
SELECT * FROM facturacion ORDER BY FECHA;

-- Ver facturación de una fecha específica
SELECT * FROM facturacion WHERE FECHA = '2021-06-22';
```

### Consultar detalle de facturas

```sql
-- Ver última factura generada
SELECT 
    f.*,
    i.CODIGO,
    i.CANTIDAD,
    i.PRECIO,
    (i.CANTIDAD * i.PRECIO) AS SUBTOTAL
FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
WHERE f.NUMERO = (SELECT MAX(NUMERO) FROM facturas);
```

### Generar múltiples ventas (simulación)

```sql
-- Generar 10 ventas para simular varios días
CALL sp_venta('2021-06-23', 10, 50);
CALL sp_venta('2021-06-23', 8, 75);
CALL sp_venta('2021-06-24', 12, 100);
CALL sp_venta('2021-06-24', 5, 30);
CALL sp_venta('2021-06-25', 15, 80);
CALL sp_venta('2021-06-25', 7, 40);
CALL sp_venta('2021-06-26', 20, 100);
CALL sp_venta('2021-06-26', 3, 20);
CALL sp_venta('2021-06-27', 9, 60);
CALL sp_venta('2021-06-27', 11, 90);
```

### Estadísticas y reportes

Ver más ejemplos en `modulos/05-examples/01_ejemplos_uso.sql`:

- Productos más vendidos
- Clientes con más compras
- Vendedores con más ventas
- Total de ventas por fecha

---

## Solución de problemas

### Error: "The MySQL server is running with the --secure-file-priv option"

**Causa:** MySQL restringe la ubicación desde donde puede leer archivos CSV.

**Solución:**

1. Averigua la carpeta permitida:
```sql
SHOW VARIABLES LIKE 'secure_file_priv';
```

2. Mueve tu CSV a esa carpeta o desactiva la restricción en `my.cnf`:
```ini
[mysqld]
secure_file_priv = ""
```

3. Reinicia MySQL.

### Error: "This function has none of DETERMINISTIC, NO SQL, or READS SQL DATA"

**Causa:** No tienes `log_bin_trust_function_creators` activado.

**Solución:**

```sql
SET SESSION log_bin_trust_function_creators = 1;
```

O solicita al DBA que lo active globalmente.

### Error: "Access denied; you need the SUPER privilege"

**Causa:** Intentas ejecutar `SET GLOBAL` sin privilegios.

**Soluciones:**

1. Usa `SET SESSION` en lugar de `SET GLOBAL`
2. Solicita al administrador que ejecute:
```sql
SET GLOBAL log_bin_trust_function_creators = 1;
```
3. Pide privilegios SUPER a tu usuario

### Error: "Table 'jugos_ventas.facturas' doesn't exist"

**Causa:** No importaste los dumps de jugos_ventas.

**Solución:**

Ejecuta todos los comandos de importación de dumps (Paso 5).

### Error: "Duplicate entry for key 'PRIMARY'"

**Causa:** Ya existen facturas o items con ese número.

**Solución:**

1. Elimina datos anteriores:
```sql
DELETE FROM items;
DELETE FROM facturas;
```

2. O usa `TRUNCATE` para reiniciar:
```sql
SET FOREIGN_KEY_CHECKS = 0;
TRUNCATE TABLE items;
TRUNCATE TABLE facturas;
SET FOREIGN_KEY_CHECKS = 1;
```

### Los triggers no actualizan la tabla facturacion

**Verificar que existen:**

```sql
SHOW TRIGGERS LIKE 'items';
```

**Recrear triggers:**

```bash
mysql -u root -p nombre_base_datos < modulos/04-triggers/02_triggers_facturacion.sql
```

---

## Comandos útiles

### Ver todas las funciones creadas

```sql
SHOW FUNCTION STATUS WHERE Db = 'nombre_base_datos';
```

### Ver todos los procedimientos

```sql
SHOW PROCEDURE STATUS WHERE Db = 'nombre_base_datos';
```

### Ver todos los triggers

```sql
SHOW TRIGGERS;
```

### Eliminar funciones/procedimientos/triggers

```sql
DROP FUNCTION IF EXISTS f_aleatorio;
DROP PROCEDURE IF EXISTS sp_venta;
DROP TRIGGER IF EXISTS TG_FACTURACION_INSERT;
```

### Backup de la base de datos

```bash
mysqldump -u root -p nombre_base_datos > backup.sql
```

### Restaurar desde backup

```bash
mysql -u root -p nombre_base_datos < backup.sql
```

---

## Recursos adicionales

- [Documentación oficial de MySQL](https://dev.mysql.com/doc/)
- [Curso en Alura Latam](https://app.aluracursos.com/course/sql-mysql-proyecto-final)
- [Archivo de comandos original](../comandos.sql)

---

**¿Necesitas más ayuda?** Revisa los ejemplos en `modulos/05-examples/01_ejemplos_uso.sql`
