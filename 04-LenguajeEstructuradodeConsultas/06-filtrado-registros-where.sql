/*------------------------------------------------------------------------
==========================================================================


DQL (Data Query Lenguaje en SQLSERVER)

Archivo 06-Filtrados-reguistros_where.sql

Descripcion: Se recuperan unicamente las filas que cumplen determinadas condiciones 
mediante la clausula where 
Orden sintactico
SELECT/TOP/DISTINCT     
FROM
JOINS/ON
WHERE
GRUP BY
HAVING
ORDER BY


ORDEN DE EJECUCION 
FROM / JOINS (EXISTE LINER , LEFT,RIGH, CROSS, FULL, SELF)
WHERE
GROUP BY
HAVING
SELECT
DISTINCT
ORDER BY
TOP

OPERADORES RELACIONALES
(= igual que )
(< menos que)
(> mayor que )
(<= menor o igual)
(>= mayor o igual)
(<> diferenrte que)
(! diferente que)




--------------------------------------------------------------------------
==========================================================================
*/

/*============================================================================
Sintaxis 

SELECT 
columna1
columna2
columna_n
FROM nombre_tabla
WHERE condicion;

Nota: condicion se puede relacionar y con la combinacion de esta logica 

Nota : EL SELECT , No filtra resguistros 

*/============================================================================


--Seleccionar el producto cuyo precio es de $200
SELECT 
p.codigo AS [Codigo],
p.nombre AS [Producto],
p.precio AS [Precio]
FROM productos AS p
WHERE precio=200;
-- Seleccionar el cliente cuyo Identificador es 25

-- Comparacion de cadenas de texto
-- Los valores de texto deben escicribirse entre coomillas similares

--Seleccionar las categorias donde el nombre se Computo
SELECT

d.id_cliente,
CONCAT (c.nombre,'',
c.apellido_paterno,'',
c.apellido_materno) AS nombre_completo,
c.correo
FROM cliente AS c
WHERE c.id_cliente=25;

SELECT
      c.nombre AS [Categoria]
FROM categorias AS c
WHERE c.nombre = 'Cómputo';


--SELECCIONAR LOS DATOS DEL CLIENTE CON NOMBRE CLIENTE 1 
SELECT
d.id_cliente,
CONCAT (c.nombre,'',
c.apellido_paterno,'',
c.apellido_materno) AS nombre_completo,
c.correo
FROM clientes AS
WHERE nombre = 'CLIENTE1'
-- Seleccionar los datos del empleado que no pertenezcan al departamento 
SELECT 
 e.id_empleado,
 e.nombre,
 e.id_departamento,
 e.salario
FROM empleados AS e
WHERE id_departamento=1;
GO
--Seleccionar los datos de los productos donde el precio sea superior $190

--Seleccionar los datos de los productos con es existencia critica inferior a 10 unidades
SELECT 
p.id_producto,
p.nombre,
p.id_categoria,
p.precio
FROM productos AS p
WHERE p.precio>490;

--seleccionar los datos de los empleados donde el salario sea de $30,000 en adelante 


--Seleccionar los datos de los productos donde sus precios sean de 10 o menos 
SELECT 
    p.id_producto,
    p.nombre,
    p.id_categoria,
    p.precio
FROM productos AS p
WHERE p.precio<=10;


--comparacion de fechs
-- Las fechas deben inscribirse entre comillas simples 
--Se recomiendan el formato AAAA-MM-DD
--Seleccionar los datos de las ventas realizadas el 24 de diciembre de 2025

SELECT 
v.id_venta,
v.fecha,
v.id_ciente,
v.id_empleado
FROM ventas AS v
WHERE fecha '2025-12-24';
-- Funciones de fechas 

SELECT 
v.id_venta,
v.fecha,
YEAR(v.fecha) AS [año],

FORMAT (v.fecha, 'MMMM') AS [mes_ingles],
FORMAT (v.fecha, 'MMM', 'es-ES') AS [mes_Español],
MONTH(v.fecha) AS mes,
DAY(v.fecha) AS dia,
FORMAT (v.fecha, 'ddd', 'es-ES') AS [dia_Ingles],
UPPER ()
UPPER ()

v.id_cliente,
v.id_empleado
FROM ventas AS v
WHERE MONTH (fecha)=4;


-- Seleccionar las ventas anterores a 2025
SELECT 
v.id_venta,
v.fecha,
YEAR(v.fecha) AS [año],
MONTH (v.fecha) AS [Mes],
DAY(v.fecha) AS [Dia],
FORMAT (v.fecha, 'MMMM') AS [Mes en ingles],
UPPER (FORMAT (v.fecha,'MMMM','es-ES')) AS [Mes en Español],
FORMAT (v.fecha,'MMM') AS [Mes Abreviado],
FORMAT (v.fecha,'MMM','es-ES') AS [Mes Abreviado],
FORMAT (v.fecha,'dddd') AS [Dia en ingles],
FORMAT (v.fecha,'dddd','es-ES') AS [Dia en ingles],
v.id_cliente,
v.id_empleado
FROM ventas AS v;

--distint
--Quita los elementos repetidos de una o la combinacion de columnas ¿

-- Muestra los sexos de los clientes

SELECT DISTINCT
sexo
FROM CLIENTES AS c;

SELECT DISTINCT 
id_ciudad
FROM clientes;

--CONUT CONTAR EL NUMERO DE FILAS DE UNA TABLA 
SELECT DISTINCT
cu.nombre
FROM ciudades AS c
INNER JOIN ciudades AS cu
ON c.id_ciudad=cu.id_ciudad;

--SELECCIONAR LOS DESCUENTOS UNICOS DE LAS VENTAS 

SELECT 
dv.descuento
FROM detalle_ventas AS dv
ORDER BY dv.descuento DESC;

SELECT DISTINCT
p.id_categoria,
p.id_producto
FROM productos AS p
GO

--Top
--Limita la cantiadad de filas devueltas por una consulta 

SELECT TOP (10) PERCENT
dv.id_venta,
dv.descuento,
dv.precio,
dv.cantidad
FROM detalle_ventas AS dv

--SELECCIONAR las ventas nteriores del 1 de febrero de 2025

SELECT 
v.id_venta,
v.fecha,
YEAR(v.fecha) AS [año],
MONTH (v.fecha) AS [Mes],
DAY(v.fecha) AS [Dia],
FORMAT (v.fecha, 'MMMM') AS [Mes en ingles],
UPPER (FORMAT (v.fecha,'MMMM','es-ES')) AS [Mes en Español],
FORMAT (v.fecha,'MMM') AS [Mes Abreviado],
FORMAT (v.fecha,'MMM','es-ES') AS [Mes Abreviado],
FORMAT (v.fecha,'dddd') AS [Dia en ingles],
FORMAT (v.fecha,'dddd','es-ES') AS [Dia en ingles],
v.id_cliente,
v.id_empleado
FROM ventas AS v
WHERE v.fecha< '2025-02-01';

--Seleccionar los datos de los productos Mostrando el codif¿go y el valor del inventario 
--done el alor del inventario deve de ser mayor a 50 mill

SELECT 
p.codigo AS codigo_producto,
p.existencia AS existencia,
p.precio AS precio,
(p.precio*p.existencia) AS valor_inventario
FROM productos AS p
WHERE (p.precio*p.existencia) > 50000;

--Mostrar los productos con precio que este entre $200 y $300  
SELECT 
p.codigo AS codigo_producto,
p.existencia AS existencia,
p.precio AS precio,
(p.precio*p.existencia) AS valor_inventario
FROM productos AS p
WHERE precio>=200 AND precio<=300;

--Instruccion between 
SELECT 
p.codigo AS codigo_producto,
p.existencia AS existencia,
p.precio AS precio,
(p.precio*p.existencia) AS valor_inventario
FROM productos AS p
WHERE precio BETWEEN 200 AND 300;


-- los purdcutos entre 200 y 300 ademas que tengan 300 unidades
SELECT
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p
WHERE p.precio>=200
AND 
p.precio<=300
AND 
p.existencia<50
ORDER BY precio DESC;

--Mostrar los prodcutos conn existencia inferori a 10 o superorir a 190
SELECT
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p
WHERE p.existencia<=10
OR
p.existencia>=190

ORDER BY precio DESC;

--Operardor Not 
SELECT
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p
WHERE p.existencia < 10
OR p.existencia>190;

--OPERADOR NOT 
--Mostrar los productos que su precio no sea mayor a 400no sean mayores a 400 
SELECT
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p
WHERE p.precio <= 400;

--Mostrar los empleados de los departamentos 1 y 2 que tengan salario mayor 
-- a 25000 pesos

SELECT 
e.id_empleado,
e.nombre,
e.salario,
e.id_departamento
FROM empleados AS e
WHERE (e.id_departamento =1
OR
e.id_departamento=2)
AND e.salario>250000:
-- OPERADOR BETWEEN
-- Permite comprobar si un valor se encuentra dentro de un rango inclusivo

/*==================================================================
WHERE columna BETWEEN limite_inferior AND limite_superior
====================================================================*/

-- Mostrar empleados con salario entre $15,000 y $20,000, incluyendo ambos limites

SELECT
    e.id_empleado,
    e.nombre,
    e.salario
FROM empleados AS e
WHERE salario BETWEEN 15000 AND 20000
ORDER BY 3 DESC;

SELECT
    e.id_empleado,
    e.nombre,
    e.salario
FROM empleados AS e
WHERE e.salario>=15000
      AND
      e.salario<=20000;

-- Mostrar los productos que los precios esten en el rango de 100 y 200
SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia
FROM productos AS p
WHERE p.precio BETWEEN 100 AND 200;
-- Mostrar las ventas del 1 de enero de 2025 al 10 de enero de 2025
SELECT
    v.id_venta AS [numero_venta],
    v.id_cliente AS [cliente],
    v.id_empleado AS [vendedor],
    v.fecha AS [fecha_venta],
    UPPER(FORMAT(v.fecha, 'MMMM', 'es-ES')) AS [mes_venta],
    UPPER(FORMAT(v.fecha, 'dddd', 'es-ES')) AS [dia_venta],
    DATEPART(YEAR, v.fecha) AS [año_venta]
FROM ventas AS v
WHERE v.fecha BETWEEN '2025-01-01' AND '2025-01-10'
ORDER BY [cliente] ASC;

-- Mostrar los productos que su rango de precios no este entre 100 y 400

SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia
FROM productos AS p
WHERE p.precio NOT BETWEEN 100 AND 400;

-- OPERADOR IN
-- permite comparar una columna con una lista de valores

/*==================================================================
WHERE columna IN (valor_1, valor_2, valor_3)
====================================================================*/

-- Mostrar productos pertenecientes a las categorias 1,7 o 12

SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria IN (1,7,12)
ORDER BY p.id_categoria;


SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria  = 1
      OR p.id_categoria = 7
      OR p.id_categoria = 12
ORDER BY p.id_categoria;

-- Mostrar todos los productos que no pertenecen a la categoria 1, 7 o 12

SELECT
    p.codigo,
    p.nombre,
    p.precio,
    p.existencia,
    p.id_categoria
FROM productos AS p
WHERE p.id_categoria NOT IN (1,7,12)
ORDER BY p.id_categoria;
--
/*
==============================================================================
--Todo :Operador LIKE 

--Permite Buscar patrones dentro de valores de texto 
--Sintaxis 
--Columna WHERE  Like 'Patron;'
--Los Patrones pueden conteer comodines


--Comodin significado
--   %        Cero . ou o varios Valores
--            Exactamente un caracter
--   [ABC]    Un caracter Incluido en la lista 
--   [a-F]    Un caracter incluido en el rango
--   [^abc]   Un caracter no incluido en la lista
============================================================================

*/
-- Comodin %
--El simbolo % :Representa Cualquier cantidad de caractteres , incluyendo cero caracteres

--Comienza 

--Where nombre LIKE 'Cliente%'
--Valores que comienzan con cliente 

--Termina
--Where Correo '%Mail.com'
--Valores que terminan con mail.com

--Contiene 
--WHERE nombre like  '%a%'
--Valores que contiene el caracter a en cualquier pocicion 

--Buscar codigos de productos que comiencen con el P001

SELECT 
p.codigo,
p.nombre,
p.precio
FROM Productos AS p

WHERE p.codigo LIKE 'P001%';


SELECT *
FROM Customers
WHERE CompanyName LIKE 'Bo%'
;
--Buscar los correos de los clientes que termienen exactamente con 10@mail.com


SELECT 
 c.id_cliente,
 c.nombre,
 c.correo
FROM clientes AS c
WHERE c.correo LIKE '%@mail.com'
;

-- Mostrar los Nombres de los productos  que contienen el caracter 1 
--Mostrar los codigos con p000 y exactamente un caracter adicional
SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos AS p
WHERE p.nombre LIKE '%1%'
;

SELECT *
FROM Customers
WHERE contactTitle LIKE '%er%'
;

SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P0_00';
SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000&';

--Patrones con corchetes 
SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000[1-5]';

SELECT 
p.codigo,
p.nombre,
p.precio
FROM productos AS p
WHERE p.codigo LIKE 'P000[^1-5]';

--BUuscar un Gion bajo lateral
--En linea - es un comodin 

-- Las ciudades en esta base de datos , contienen los guones bajos , por ejemplo ;
--Ciudad_1_1
-- Para buscar un guin bajo literal mediante corchetes se puede utlizar

SELECT *
FROM ciudades
WHERE nombre LIKE '%[_]%'-- Significa un caracter de guion bajo Lateral
;