"""
Enunciado Python:
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

from sqlalchemy import create_engine

# Definición función reutilizable para obtener información desde sql server
# Parámetros:
#  database_url: define cadena de conexión a la bd
#  query: define la consulta sql a extraer desde la bd
def extraer_sql_server(database_url, query):
    try:
        # Crear motor de conexión usando SQLAlchemy
        engine = create_engine(database_url)
        
        # Conectarse y ejecutar la consulta
        with engine.connect() as connection:
            df = pd.read_sql(query, connection)
        
        return df
    except Exception as e:
        print("Error al ejecutar la consulta:", e)
        return None

# Definición de función reutilizable para exportar dataframe a parquet
# Parámetros:
#  df: define el dataframe pandas a exportar
#  file_name: define archivo destino donde se exportará
def guardar_parquet(df, file_name):
    try:
        df.to_parquet(file_name)
        print(f"Archivo guardado en {file_name}")
    except Exception as e:
        print("Error al guardar el archivo Parquet:", e)

# Parametrización y Ejecución
# URL de conexión a la base de datos
database_url = 'mssql+pyodbc://username:password@server_name/database_name?driver=ODBC+Driver+17+for+SQL+Server'

# Consulta SQL para extraer ventas del último año
query = """
SELECT id, producto, cantidad, precio, fecha_venta
FROM ventas_sqlserver
WHERE fecha_venta >= DATEADD(year, -1, GETDATE());
"""

#Ruta y archivo destino del export
file_name_export = "../ventas_ultimos_anios.parquet"

# Extraer datos y guardar en archivo Parquet
df_ventas = extraer_sql_server(database_url, query)
if df_ventas is not None:
    guardar_parquet(df_ventas, file_name_export)