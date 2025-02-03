/*
Dada la siguiente consulta en Oracle, que es lenta: 

SELECT * FROM pedidos_oracle WHERE fecha_pedido BETWEEN '2023-01-01' AND '2023-12-31';

Tareas: 
- Identificar por qué es lenta 
- Aplicar tres mejoras para optimizar su rendimiento 
Pistas: Considera índices, particiones y estadísticas de consulta
*/

--1. Crear índice por periodo, Esto acelerará las consultas que filtran por esta columna.
CREATE INDEX idx_fecha_pedido ON pedidos_oracle(fecha_pedido);

--2. Implementar particiones por rango de fechas. para mejorar rendimiento al reducir el número de filas que deben ser escaneadas
CREATE TABLE pedidos_oracle (
    id_pedido NUMBER,
    fecha_pedido DATE
    CONSTRAINT pk_pedidos_oracle PRIMARY KEY (id_pedido, fecha_pedido)
) PARTITION BY RANGE (fecha_pedido) (
    PARTITION p2023q1 VALUES LESS THAN (TO_DATE('2023-04-01', 'YYYY-MM-DD')),
    PARTITION p2023q2 VALUES LESS THAN (TO_DATE('2023-07-01', 'YYYY-MM-DD')),
    PARTITION p2023q3 VALUES LESS THAN (TO_DATE('2023-10-01', 'YYYY-MM-DD')),
    PARTITION p2023q4 VALUES LESS THAN (TO_DATE('2024-01-01', 'YYYY-MM-DD'))
);

--3. Acutlizar estadísticas de la tabla, ayuda al optimizador a elegir el mejor plan de ejecución para la consulta.
BEGIN
    DBMS_STATS.GATHER_TABLE_STATS('schema_name', 'pedidos_oracle');
END;

