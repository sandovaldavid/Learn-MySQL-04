# Learn MySQL 04 - Proyecto Final

Este repositorio fue creado como **proyecto educativo** que concentra y organiza todo el conocimiento adquirido en el curso **SQL con MySQL: Proyecto final** de Alura Latam. Implementa un sistema completo de gestión de ventas utilizando funciones, procedimientos almacenados y triggers en MySQL.

## 📚 Sobre este proyecto

Este repositorio es material educativo desarrollado siguiendo el [syllabus oficial](docs/syllabus.md) del curso de Alura Latam. He extraído, organizado y documentado el conocimiento proporcionado durante el curso para crear una referencia estructurada y fácil de seguir.

### Contenido del curso

El proyecto está organizado siguiendo las 5 secciones del syllabus:

1. **Proyectando la base de datos** - Creación de tablas y carga de datos
2. **Función aleatorio** - Uso de `RAND()` y funciones personalizadas
3. **Función cliente aleatorio** - Selección aleatoria de entidades
4. **Generando ventas y problema con PK** - Stored procedures y manejo de claves primarias
5. **Stored Procedures y TRIGGERS** - Automatización y mantenimiento de datos

## 🗂️ Estructura del repositorio

```
Learn-MySQL-04/
├── modulos/
│   ├── 01-proyecto-base/          # Creación de base de datos y tablas
│   │   ├── 01_create_database_and_tables.sql
│   │   ├── 02_seed_clientes.sql
│   │   ├── 03_seed_vendedores.sql
│   │   └── 04_import_dumps.sql
│   ├── 02-funciones/               # Funciones aleatorias
│   │   ├── 01_f_aleatorio.sql
│   │   └── 02_f_cliente_producto_vendedor_aleatorio.sql
│   ├── 03-procedimientos/          # Stored procedures
│   │   ├── 01_sp_venta.sql
│   │   └── 02_sp_triggers.sql
│   ├── 04-triggers/                # Triggers de facturación
│   │   ├── 01_tabla_facturacion.sql
│   │   └── 02_triggers_facturacion.sql
│   ├── 05-examples/                # Ejemplos de uso
│   │   └── 01_ejemplos_uso.sql
│   └── 06-utils/                   # Configuraciones
│       └── 01_configuracion.sql
├── data/
│   ├── jugos_ventas/              # Dumps SQL de datos de ejemplo
│   └── csv/                       # Archivos CSV (vendedores)
├── docs/
│   ├── syllabus.md                # Temario del curso
│   ├── guia_de_uso.md             # Guía detallada de uso
│   ├── indice_archivos.md         # Índice de todos los scripts
│   └── reorganizacion.md          # Historial de cambios
└── recuperacion-ambiente/         # Archivos originales del curso (ver README dentro)
```

## 🚀 Inicio rápido

### Prerrequisitos

- MySQL 5.7+ o MySQL 8.0+ (recomendado)
- Cliente MySQL (mysql, MySQL Workbench, DBeaver, etc.)
- Privilegios para crear bases de datos, tablas, funciones y procedimientos

### Instalación paso a paso

1. **Clonar el repositorio**
```bash
git clone https://github.com/sandovaldavid/Learn-MySQL-04.git
cd Learn-MySQL-04
```

2. **Ejecutar los scripts en orden** (ver [docs/guia_de_uso.md](docs/guia_de_uso.md) para detalles)

```bash
# 1. Configuración inicial
mysql -u root -p < modulos/06-utils/01_configuracion.sql

# 2. Crear tablas
mysql -u root -p < modulos/01-proyecto-base/01_create_database_and_tables.sql

# 3. Cargar datos iniciales
mysql -u root -p < modulos/01-proyecto-base/02_seed_clientes.sql

# 4. Importar dumps (requiere pasos adicionales - ver guía)
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_productos.sql
mysql -u root -p jugos_ventas < data/jugos_ventas/jugos_ventas_tabla_de_vendedores.sql
# ... (ver guia_de_uso.md para más detalles)

# 5. Crear funciones
mysql -u root -p < modulos/02-funciones/01_f_aleatorio.sql
mysql -u root -p < modulos/02-funciones/02_f_cliente_producto_vendedor_aleatorio.sql

# 6. Crear procedimientos y triggers
mysql -u root -p < modulos/03-procedimientos/01_sp_venta.sql
mysql -u root -p < modulos/04-triggers/01_tabla_facturacion.sql
mysql -u root -p < modulos/03-procedimientos/02_sp_triggers.sql
mysql -u root -p < modulos/04-triggers/02_triggers_facturacion.sql

# 7. Probar el sistema
mysql -u root -p < modulos/05-examples/01_ejemplos_uso.sql
```

### Uso básico

Una vez configurado el sistema, puedes generar ventas aleatorias:

```sql
-- Generar una venta con fecha, máximo de items y cantidad máxima
CALL sp_venta('2021-06-22', 15, 100);

-- Ver el resumen de facturación
SELECT * FROM facturacion ORDER BY FECHA;

-- Ver detalle de facturas
SELECT * FROM facturas f
INNER JOIN items i ON f.NUMERO = i.NUMERO
ORDER BY f.NUMERO;
```

## 📖 Características principales

- **Generación aleatoria de datos**: Funciones para seleccionar clientes, productos y vendedores aleatorios
- **Automatización de ventas**: Procedimiento `sp_venta` que genera facturas completas automáticamente
- **Actualización automática**: Triggers que mantienen la tabla de facturación sincronizada
- **Validación de datos**: Prevención de duplicados y manejo de casos extremos
- **Optimización de PK**: Uso de `INT` en lugar de `VARCHAR` para claves primarias numéricas

## 🛠️ Tecnologías

- MySQL 8.0
- SQL Standard
- Stored Procedures
- Triggers
- Functions

## 📝 Notas importantes

- **Privilegios**: La creación de funciones puede requerir configurar `log_bin_trust_function_creators`
- **Orden de ejecución**: Es crucial ejecutar los scripts en el orden indicado
- **Dumps externos**: Los archivos en `data/jugos_ventas/` deben importarse a una base de datos auxiliar
- **CSV de vendedores**: Ver `modulos/01-proyecto-base/03_seed_vendedores.sql` para opciones de carga
- **Archivos originales**: La carpeta `recuperacion-ambiente/` contiene todos los archivos originales del curso (ver su README)

## 📚 Documentación adicional

- [Guía de uso detallada](docs/guia_de_uso.md) - Instalación, configuración y solución de problemas
- [Índice de archivos SQL](docs/indice_archivos.md) - Referencia rápida de todos los scripts
- [Historial de reorganización](docs/reorganizacion.md) - Cambios y mejoras implementadas
- [Syllabus del curso](docs/syllabus.md) - Temario oficial
- [Archivos originales](recuperacion-ambiente/README.md) - Material de referencia histórica

## 📄 Licencia

Este repositorio es **contenido educativo** creado con fines de aprendizaje, basado en el curso de Alura Latam. El material está organizado y documentado para facilitar el estudio y la referencia.

## 🎓 Créditos del curso

**Instructor:** Álvaro Hernando Camacho Diaz  
Ingeniero de Machine Learning, consultor, especialista en Data Analytics y Ciencia de Datos.

**Curso original:** [SQL con MySQL: Proyecto final - Alura Latam](https://app.aluracursos.com/course/sql-mysql-proyecto-final)

## 👨‍💻 Contacto

Soy **Juan David Sandoval**, Ingeniero Informático con especialización en Data Science y Desarrollador Web. Me enfoco en construir aplicaciones **que combinen la ciencia de datos, inteligencia artificial y el desarrollo web moderno**.

Si estás buscando talento que combine el dominio técnico de backend, frontend y bases de datos:

- **Perfil Profesional:** [LinkedIn - Juan David Sandoval](https://linkedin.com/in/devsandoval)
- **Código:** [GitHub - sandovaldavid](https://github.com/sandovaldavid)
- **Portafolio:** [DevSandoval](https://devsandoval.me)

---

**¿Dudas o problemas?** Consulta la [guía de uso detallada](docs/guia_de_uso.md) o revisa los archivos de ejemplo en `modulos/05-examples/`.
