#!/bin/bash

: << 'EOF'
Escribe un script en Bash para automatizar la carga de ventas_transformadas.csv en 
PostgreSQL.

Requisitos: 
- Validar que el archivo ventas_transformadas.csv existe  
- Usar psql para cargar los datos 
- Registrar los errores en log_carga.txt  

Ejemplo de ejecución: 
./cargar_ventas.sh ventas_transformadas.csv
EOF


# Verificar si el archivo CSV existe, dado por el parámetro de entrada $1 desde el llamado del sh
if [ ! -f "$1" ]; then
  echo "El archivo $1 no existe."
  exit 1
fi

# Variables
FILE=$1
LOG_FILE="log_carga.txt"

# Cargar el archivo CSV en PostgreSQL
psql -U usuario -d basededatos -c "\copy nombre_tabla FROM '$FILE' WITH CSV HEADER" 2>> $LOG_FILE

# Verificar si hay errores durante la carga
if [ $? -ne 0 ]; then
  echo "Hay errores durante la carga. Revisa $LOG_FILE para detalles."
else
  echo "Carga ok."
fi