# Carpeta de Recuperación de Ambiente

Esta carpeta contiene los **archivos originales del curso** tal como fueron proporcionados. Son materiales de referencia histórica y backup.

## 📁 Propósito de esta carpeta

- ✅ **Preservar** el contenido original del curso
- ✅ **Referencia** para comparar con la versión reorganizada
- ✅ **Backup** de todos los archivos originales
- ⚠️ **No ejecutar** directamente estos archivos (usar la estructura reorganizada en `modulos/`)

---

## 📄 Archivos SQL por tema

### 1️⃣ Creación de esquemas y tablas

| Archivo                | Descripción                                                 | Versión reorganizada                                           |
| ---------------------- | ----------------------------------------------------------- | -------------------------------------------------------------- |
| `Creacion_Esquema.sql` | Esquema completo de `jugos_ventas` con tablas en mayúsculas | `data/jugos_ventas/*.sql` (dumps)                              |
| `Comandos_Aula_1.sql`  | Creación de tablas versión inicial (VARCHAR para NUMERO)    | `modulos/01-proyecto-base/01_create_database_and_tables.sql` ✨ |

**Notas:**
- `Comandos_Aula_1.sql`: Versión inicial con `NUMERO VARCHAR(5)` (problema histórico)
- `Creacion_Esquema.sql`: Define el esquema de `jugos_ventas` (base de datos auxiliar)

---

### 2️⃣ Funciones aleatorias

| Archivo            | Descripción                              | Versión reorganizada                                                  |
| ------------------ | ---------------------------------------- | --------------------------------------------------------------------- |
| `funcion_RAND.sql` | Ejemplos básicos de `RAND()` y `FLOOR()` | `modulos/02-funciones/01_f_aleatorio.sql` ✨                           |
| `LIMIT.sql`        | Ejemplos de uso de `LIMIT` con offset    | `modulos/02-funciones/02_f_cliente_producto_vendedor_aleatorio.sql` ✨ |

**Conceptos cubiertos:**
- Generación de números aleatorios
- Uso de `LIMIT` para selección aleatoria

---

### 3️⃣ Procedimientos almacenados

| Archivo                    | Descripción                                         | Versión reorganizada                          |
| -------------------------- | --------------------------------------------------- | --------------------------------------------- |
| `venta.sql`                | Procedimiento `sp_venta` y solución al problema PK  | `modulos/03-procedimientos/01_sp_venta.sql` ✨ |
| `Problema_Primary_Key.sql` | Consultas que demuestran problema con VARCHAR en PK | Documentado en `docs/reorganizacion.md`       |

**Problema histórico:**
- `Problema_Primary_Key.sql` muestra por qué `VARCHAR` en `NUMERO` causa problemas de ordenamiento

---

### 4️⃣ Triggers y facturación

| Archivo                            | Descripción                                      | Versión reorganizada                                                                                 |
| ---------------------------------- | ------------------------------------------------ | ---------------------------------------------------------------------------------------------------- |
| `Triggers.sql`                     | Triggers básicos (versión con lógica directa)    | `modulos/04-triggers/02_triggers_facturacion.sql` ✨                                                  |
| `Stored_Procedures_y_Triggers.sql` | Triggers mejorados + procedimiento `sp_triggers` | `modulos/03-procedimientos/02_sp_triggers.sql` + `modulos/04-triggers/02_triggers_facturacion.sql` ✨ |

**Evolución:**
1. `Triggers.sql`: Triggers con lógica completa duplicada (DELETE + INSERT)
2. `Stored_Procedures_y_Triggers.sql`: Triggers modulares llamando a `sp_triggers()`

---

### 5️⃣ Datos de carga

| Archivo                      | Descripción                           | Versión reorganizada                                     |
| ---------------------------- | ------------------------------------- | -------------------------------------------------------- |
| `inclusion_productos.sql`    | Inserción de productos "Sabor Alpino" | Integrable en `modulos/01-proyecto-base/` si se necesita |
| `Carga_Tablas_Registros.sql` | *(no analizado aún)*                  | -                                                        |

---

### 📊 Archivos CSV

| Archivo                 | Descripción                | Uso                                 |
| ----------------------- | -------------------------- | ----------------------------------- |
| `vendedores.csv`        | Datos de vendedores        | Copiado a `data/csv/vendedores.csv` |
| `Carga_Facturas_01.csv` | Datos de facturas (lote 1) | Opcional para carga masiva          |
| `Carga_Facturas_02.csv` | Datos de facturas (lote 2) | Opcional para carga masiva          |
| `Carga_Facturas_03.csv` | Datos de facturas (lote 3) | Opcional para carga masiva          |

**Uso de CSVs de facturas:**
Los archivos `Carga_Facturas_*.csv` pueden usarse para cargar datos históricos masivos si se desea simular un sistema con muchas transacciones previas.

---

### 🗄️ Dumps SQL

Carpeta: `dump-jugos-ventas/`

| Archivo                                | Descripción                 | Copiado a              |
| -------------------------------------- | --------------------------- | ---------------------- |
| `jugos_ventas_tabla_de_clientes.sql`   | Dump de clientes            | `data/jugos_ventas/` ✅ |
| `jugos_ventas_tabla_de_productos.sql`  | Dump de productos           | `data/jugos_ventas/` ✅ |
| `jugos_ventas_tabla_de_vendedores.sql` | Dump de vendedores          | `data/jugos_ventas/` ✅ |
| `jugos_ventas_facturas.sql`            | Dump de facturas históricas | `data/jugos_ventas/` ✅ |
| `jugos_ventas_items_facturas.sql`      | Dump de items de facturas   | `data/jugos_ventas/` ✅ |

**Nota:** Estos archivos ya fueron copiados a `data/jugos_ventas/` para facilitar su uso.

---

### 📜 Archivo consolidado

| Archivo        | Descripción                                     | Estado                                 |
| -------------- | ----------------------------------------------- | -------------------------------------- |
| `comandos.sql` | Todos los comandos del curso en un solo archivo | Preservado también en la raíz del repo |

Este archivo contiene todos los comandos mezclados. **Usar la estructura reorganizada en `modulos/` en su lugar.**

---

## 🔄 Mapeo a la estructura reorganizada

### Correspondencia de archivos

```
recuperacion-ambiente/          →  Estructura reorganizada
├── Comandos_Aula_1.sql         →  modulos/01-proyecto-base/01_*.sql
├── Creacion_Esquema.sql        →  (esquema de jugos_ventas)
├── funcion_RAND.sql            →  modulos/02-funciones/01_f_aleatorio.sql
├── LIMIT.sql                   →  modulos/02-funciones/02_*.sql
├── venta.sql                   →  modulos/03-procedimientos/01_sp_venta.sql
├── Problema_Primary_Key.sql    →  (documentado en docs/)
├── Triggers.sql                →  modulos/04-triggers/02_triggers_facturacion.sql
├── Stored_Procedures_y_Triggers.sql → modulos/03-procedimientos/02_sp_triggers.sql
├── inclusion_productos.sql     →  (opcional)
├── vendedores.csv              →  data/csv/vendedores.csv
├── Carga_Facturas_*.csv        →  (opcional para carga masiva)
└── dump-jugos-ventas/          →  data/jugos_ventas/
    └── *.sql                   →  (5 archivos copiados)
```

---

## ⚠️ Diferencias importantes

### Archivos originales vs. reorganizados

1. **Tipo de PK en facturas/items**
   - Original: `NUMERO VARCHAR(5)`
   - Reorganizado: `NUMERO INT` ✨ (problema resuelto)

2. **Generación de número de factura**
   - Original: `SELECT MAX(NUMERO) + 1`
   - Reorganizado: `SELECT IFNULL(MAX(NUMERO), 0) + 1` ✨ (evita NULL)

3. **Organización**
   - Original: Archivos sueltos por tema
   - Reorganizado: Numeración y carpetas por sección del syllabus ✨

4. **Documentación**
   - Original: Sin comentarios explicativos
   - Reorganizado: Cabeceras, comentarios y guías completas ✨

---

## 📖 ¿Cuándo usar estos archivos?

### ✅ Usar para:
- Comparar con la versión reorganizada
- Entender la evolución del código
- Referencia histórica
- Backup si necesitas restaurar el original

### ❌ NO usar para:
- Aprender o seguir el curso (usar `modulos/` en su lugar)
- Ejecutar directamente (puede tener inconsistencias)
- Como versión principal del código

---

## 🚀 ¿Cómo empezar?

En lugar de usar estos archivos, ve a la **estructura reorganizada**:

1. Lee el [README.md](../README.md) principal
2. Sigue la [guía de uso](../docs/guia_de_uso.md)
3. Ejecuta los scripts en orden desde `modulos/`
4. Consulta el [índice de archivos](../docs/indice_archivos.md)

---

## 📝 Notas adicionales

### Archivo `comandos.sql`

Este archivo aparece tanto aquí como en la raíz del repositorio. Contiene todos los comandos del curso consolidados y comentados. Es útil para:
- Ver todo el código en un solo lugar
- Buscar comandos específicos con Ctrl+F
- Entender el flujo completo del curso

**Recomendación:** Usa la versión en la raíz del repo (más accesible).

### Archivos de carga masiva

Los CSV `Carga_Facturas_*.csv` pueden usarse para:
- Simular un sistema con miles de transacciones
- Pruebas de rendimiento
- Validar el funcionamiento de triggers con grandes volúmenes

**Cómo usar:**
```sql
LOAD DATA INFILE '/ruta/completa/Carga_Facturas_01.csv'
INTO TABLE facturas
FIELDS TERMINATED BY ',' 
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

---

**Última actualización:** Noviembre 6, 2025  
**Propósito:** Material de referencia histórica y backup
