#!/bin/bash

# La estrategia de carga sin duplicados se divide en 2 parte, esta es la priemra parte cargando un csv en una tabla previa en postgressql.

# Nombre del archivo CSV original
input_file="ventas_transformadas.csv"

# Parámetros de conexión a PostgreSQL
dbname="database_name"
user="username"
password="password"
host="localhost"
port="5432"

# Cargar datos brutos en la tabla raw_data
psql "host=$host dbname=$dbname user=$user password=$password port=$port" -c "\copy raw_data_ventas_transformadas(producto, cantidad, precio, fecha_venta, total) FROM '$input_file' DELIMITER ',' CSV HEADER"