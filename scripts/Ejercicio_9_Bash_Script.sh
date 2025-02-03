#!/bin/bash
# Enunciado Bash-Automation: 
# Crear un cron job que ejecute el script de carga cada 12 horas 
# Registrar logs de ejecución
# Abrir el crontab del usuario en linuX
# crontab -e
# Adicionar la siguiente línea

0 */12 * * * /home/etl/cargar_ventas.sh /home/etl/ventas_transformadas.csv >> /home/etl/etl.log 2>&1

# Verificar la actualización en crontab "crontab -l"