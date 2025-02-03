"""
Enunciado Python:
Debes procesar el archivo ventas_ultimos_anios.parquet generado en la Sección 1.
Tareas: 
- Detectar valores nulos en cantidad y reemplazarlos con 0 
- Calcular la columna total = cantidad * precio 
- Convertir fecha_venta al formato YYYY-MM-DD 
- Guardar el resultado en un archivo CSV (ventas_transformadas.csv) 
"""

import pandas as pd

# Cargar el archivo Parquet en un DataFrame
df = pd.read_parquet('ventas_ultimos_anios.parquet')

# Paso 1: Detectar valores nulos en 'cantidad' y reemplazarlos con 0
df['cantidad'].fillna(0, inplace=True)

# Paso 2: Calcular la columna 'total' = cantidad * precio
df['total'] = df['cantidad'] * df['precio']

# Paso 3: Convertir 'fecha_venta' al formato 'YYYY-MM-DD'
df['fecha_venta'] = pd.to_datetime(df['fecha_venta']).dt.strftime('%Y-%m-%d')

# Paso 4: Guardar el resultado en un archivo CSV
df.to_csv('ventas_transformadas.csv', index=False)