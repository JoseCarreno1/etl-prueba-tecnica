/*
Enunciado: PostgreSQL, dada la tabla empleados_postgres
Tareas: 
- Convertir la columna salario a tipo NUMERIC(10,2) 
- Reemplazar valores nulos con el promedio de los salarios 
- Formatear la columna fecha_contratacion al formato YYYY-MM-DD  

Requisito extra: 
Crear un índice en la columna departamento para mejorar el rendimiento de consultas. 
*/

-- Primero, crear una nueva columna de tipo NUMERIC
ALTER TABLE empleados_postgres ADD COLUMN salario_numerico NUMERIC(10,2);

-- Copiar los valores de la columna 'salario' a la nueva columna 'salario_numerico'
UPDATE empleados_postgres
SET salario_numerico = CAST(NULLIF(salario, '') AS NUMERIC(10,2));

-- Elimina la columna original 'salario'
ALTER TABLE empleados_postgres DROP COLUMN salario;

-- Renombra la columna 'salario_numerico' a 'salario'
ALTER TABLE empleados_postgres RENAME COLUMN salario_numerico TO salario;

-- REQUISITO EXTRA: Crear un índice en la columna departamento
CREATE INDEX idx_departamento ON empleados_postgres(departamento);