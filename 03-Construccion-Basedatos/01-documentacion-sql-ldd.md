# Construccion de Base de datos con SQL-LDD

SQL (Structured Query Languaje) se divide en 5 grandes categorias:

1. **DDL(Data Definition Languaje)**
2. **DML (Data Manipulation Languaje)**
3. **DQL(Data control languaje)**
4. DCL(Data control languaje)
5. TCL(Transaction control languaje)

# SQL-DDL
**Lenguaje de definicion de datos**
se utiliza para **Crear y modificar la estructura** de una base de datos

Con DDL trabajamos sobre los objetos de la base de datos:
- Base de datos 
- Tablas 
- Vistas 
- Indices 
- Restricciones 
- Esquemas 
- Store procedures 
- trigger 
- Fuctions 

**Comandos Principales**
| Comando | funcion |
| :--- | :--- |
| CREATE |Crear Objetos |
| ALTER | Modificar objetos |
| DROP | Eliminar objetos |
| TRUNCATE | Vaciar una tabla |

# SQL-DML
**Leguaje de manipulacion de datos**
sirve para **trabajar con la informacion almacenada**
aqui no cambia la estructura,sino los registros

**Comandos principales**
| Comando | funcion |
| :--- | :--- |
| INSERT |Insertar registros |
| UPDATE | Actualizar registros |
| DELETE | Eliminar registros|

# SQL-DQL
**Lenguaje de consulta de datos**

su funcion es **consultar informacion**

**Comandos principales**

| Comando | funcion |
| :--- | :--- |
| SELECT | Consultar informacion |

general se combina con:
- WHERE
- ORDER BY
- GROUP BY 
- HAVING 
- JOIN (LEFT,RIGHT,INNER,CROSS Y FULL)
- DISTINCT 
- TOP/LIMIT 
- Funciones de agregado (SUM,AVG,MAX,MIN,COUNT)
- Funciones de ventana(window,fuction) 

## Nomenclatura snake_case
**snake_case** es la convencion mas recomendada de ahora si se busca una nomenclatura moderna,
portable y alinada con buenas practicas en distintos motores de base de datos.

la razon es que funciona de forma consistente en **SQLServer , Mysql** y especialmente en **postgreSQL**.
Con snake_case se evitan problemas en mayusculas y se hacen las consultas sean legibles.

**Estandar de construccion**

| Objeto | Convencion | Ejemplo |
| :--- | :--- | :--- |
| Base de datos |snake_case| control_escolar |
| Esquema |snake_case |ventas,rh,seguridad |
| Tabla| Singular en snake_case | cliente,pedido,detalle_pedido |
| Columna| snake_case |cliente_id, fecha_registro, nombre, correo_electronico|
| PK | <tabla>_id | cliente_id, categoria_id |
| FK | Igual que la PK referencia | cliente_id, producto_id |
| Tabla puente | <tabla1>_<tabla2> | alumno_curso, proovedor_id |

**Nombrar restricciones**
 - pk_cliente
 - fk_pedido_cliente -> pk_tablaorigen_tablareferenciada
 - uq_cliente_correo_electronico
 - ck_producto_precio
 - df_cliente_activo
 
 ## Alter Table 

 Permite modificar una tabla  existente 

 - Agregar columnas 
 - Eliminar columnas 
 - Modificar columnas 
 - Agregar restricciones 
 - Eliminar restricciones 

 



