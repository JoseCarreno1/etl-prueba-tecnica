"""
Tienes la siguiente colección en MongoDB llamada productos: 

Tareas: 
- Conectarse a MongoDB con pymongo 
- Extraer productos con stock menor a 20 
- Incrementar el stock en 5 unidades 
"""

#pip install pymongo

from pymongo import MongoClient

# Paso 1: Conectarse a la base de datos MongoDB
client = MongoClient('mongodb://localhost:27017/')
db = client['database_name']
coleccion = db['productos']

# Paso 2: Extraer productos con stock menor a 20
productos_con_bajo_stock = coleccion.find({'stock': {'$lt': 20}})

# Imprimir los productos encontrados
for producto in productos_con_bajo_stock:
    print(producto)

# Paso 3: Incrementar el stock en 5 unidades
# resultado = coleccion.update_many(criterio, actualizacion)
resultado = coleccion.update_many(
    {'stock': {'$lt': 20}},
    {'$inc': {'stock': 5}}
)

print(f'Se actualizaron {resultado.modified_count} documentos.')