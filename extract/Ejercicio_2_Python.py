"""
Enunciado:
Debes conectar a SQL Server y extraer datos de la tabla ventas_sqlserver usando Python y SQLAlchemy.

Tarea: 
Extraer ventas del último año 
Convertir los datos en un DataFrame de Pandas 
Guardar el resultado en un archivo ventas_ultimos_anios.parquet en formato Parquet 
Requisitos: 
Usa pyodbc o SQLAlchemy para conectarte. 
Usa pandas para manipular los datos.
"""

#instala las libs necesarias para solucionar el enunciado.
#pip install pyodbc pandas pyarrow

import pyodbc
import pandas as pd

# Conexión a SQL Server
conn = pyodbc.connect(
    "DRIVER={ODBC Driver 17 for SQL Server};"
    "SERVER=server_name;"
    "DATABASE=database_name;"
    "UID=username;"
    "PWD=password"
)

# Consulta SQL para extraer ventas del último año
query = """
SELECT id, producto, cantidad, precio, fecha_venta
FROM ventas_sqlserver
WHERE fecha_venta >= DATEADD(year, -1, GETDATE());
"""

# Ejecutar la consulta y cargar los datos en un DataFrame de Pandas
df = pd.read_sql(query, conn)

# Cerrar la conexión
conn.close()

# Guardar el DataFrame en un archivo Parquet
df.to_parquet("ventas_ultimos_anios.parquet")