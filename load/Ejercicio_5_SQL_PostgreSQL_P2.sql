/*
Enunciado:
Base de datos destino: PostgreSQL 
Fuente: Archivo ventas_transformadas.csv 
Tareas: 
- Escribe un script SQL para cargar los datos en la tabla ventas_postgres
- Asegurar que no haya duplicados al insertar los datos
*/

--Parte 2, Partiendo del cargue anterior desde el SH, se carga la información sin duplicados en la tabla final.

INSERT INTO ventas_postgres (producto, cantidad, precio, fecha_venta, total)
SELECT DISTINCT producto, cantidad, precio, fecha_venta, total
FROM raw_data_ventas_transformadas;

TRUNCATE TABLE raw_data_ventas_transformadas;
