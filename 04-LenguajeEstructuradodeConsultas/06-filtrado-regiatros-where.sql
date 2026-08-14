/*==============================================================================
 DQL (DATA QUERY LANGUAGE)
 Archivo: 06-filtrado-registros-where.sql
 Descripcion: se recupera UNICAMENTE las filas que cumplen determinadas condiciones,
 mediante la clausula WHERE 
 ORDEN EJECUCION
 FROM/JOINS (INNER,LEFT,RIGH,CROSS,FULL,SELF)
 WHERE
 GROUP BY
 HAVING
 SELECT
 DISTINT
 ORDER BY
 TOP

 ORDEN SINTATICO
 SELECT/TOP
 FROM
 JOIN/ON
 WHERE
 GROUP BY
 HAVING
 ORDER BY

OPERADORES RELACIONALES
= igual que 
< menor que 
> mayor que 
<= menor o igual que
>= mayor o igual que
<> diferente que
!= diferente que

OPERADORES LOGICOS
NOT
AND 
OR
BINARIOS
 -- AND
 T T = T
    T F = F
    F T = F
    F F = F
-- OR
    T T = T
    T F = T
    F T = T
    F F = F
UNARIOS
-- NOT
    T = F
    F = T
===============================================================================*/

/*==============================================================================
sintaxis 
SELECT 
   columna_1,
   columna_2,
   columna_n
FROM nombre_tabla
WHERE condicion;

NOTA:condicion puede ser relacional  y la continuacion de esta con logica 
NOTA: el SELECT no filtra registros 

==============================================================================*/

--Seleccionar el producto cuyo precio es $200
SELECT 
 p.codigo AS [Codigo]
 p.nombre AS [Producto]
 p.precio AS [Precio]
FROM productos AS p;
WHERE precio = 200;

--Seleccionar el cliente cuyo identificador es 25
SELECT
 c.id_cliente,
 CONCAT (c.nombre, '', c.apellido_paterno, '', c.apellido_materno) AS nombre_completo,
c.correo
FROM clientes AS c 
WHERE c.id_cliente = 25;


-- Comparacion de cadenas de texto 
-- Los valores de texto deben escribirse entre comillas simples 

-- Seleccionar las categorias  
SELECT
 c.nombre AS [Categoria]
FROM categorias AS c
WHERE c.nombre = 'Computo';

-- Seleccionar los datos del cliente con nombre Cliente1
SELECT
c.id_cliente,
 CONCAT (c.nombre, '',
 c.apellido_paterno, '',
 c.apellido_materno) AS nombre_completo,
c.correo
FROM cliente AS c;
WHERE nombre = 'Cliente1';

-- Seleccionar los datos del empleado que no pertenezcan al departamento 1
SELECT
e.nombre,
e.id_departamento,
e.salario
FROM empleados AS e;
WHERE id_departamento =1;
GO

-- Seleccionar los datos de los productos deonde el precio sea superior a $490
SELECT
 p.id_producto,
 p.nombre,
 p.id_categoria,
 p.precio
 FROM producto AS p
 WHERE p.precio 
FROM productos
WHERE existencia<10;

-- Seleccionar los datos de los productos con existencia critica inferior a 10 unidades

-- Seleccionar los datos de los empleados donde su salario sea de $30,000 en adelante
SELECT 
 e.id_empleado,
 e.nombre,
 e.id_departamento,
 e.salario
FROM emlpleado AS e
WHERE salario >= 30000

-- Seleccionar los datos de los productos donde sus precios sean de $10 o menos 
SELECT 
 p.id_producto,
 p.nombre,
 p.id_categoria,
 p.precio
FROM productos AS p
WHERE p.precio <=10
-- Comparacion de fechas
-- Las fechas deben escribirse ebtre comillas simples 

-- Se recomienda el formato AAAA-MM-DD

-- Seleccionar los datos de las ventas realizadas el 24 de diciembre de 2025

SELECT
 v.id_venta,
 v.fecha,
 v.id_cliente,
 v.id_empleado
FROM ventas as v 
WHERE fecha = '2025-12-24'

-- Seleccionar los datos de las ventas realizadas en 2025

SELECT
 v.id_venta,
 v.fecha,
 YEAR(v.fecha) AS [A�O], 
 FORMAT(v.fecha, 'MMMM') AS [mes_ingles],
 FORMAT(v.fecha, 'MMMM', 'es-ES') AS [mes_espa�ol],
 DAY(v.fecha) AS [dia],
 FORMAT(v.fecha, 'dddd') AS [mes_ingles],
 UPPER(FORMAT (v.fecha, 'dddd', 'es-ES')) AS [dia_espa�ol],
 UPPER(FORMAT (v.fecha, 'ddd', 'es-ES')) AS [mes_abreviatura],
 v.id_cliente,
 v.id_empleado
FROM ventas as v 
WHERE MONTH (fecha) = 4;

-- MOSTRAR LOS PRODUCTOS CON PRECIO ENTRE $200 Y $300 QUE ADEMAS TENGAN MENOS DE cincuenta unidades

SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p,existencia
FROM productos AS p
WHERE p.precio >=200;
 AND
 p.precio<=300
 AND
 p.existencia <50
ORDER BY precio DESC

--Mostrar productos con existencia inferior a 10 o superior a 190
SELECT 
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p 
WHERE p.existencia<10
 OR
 p.existencia>190

 --OPERADOR NOT

 --Mostrar los productos que su precio no sea mayor a 400
 SELECT 
 p.codigo,
 p.nombre,
 p.precio,
 p.existencia
FROM productos AS p 
WHERE NOT p.precio <= 400;


-- Mostrar los empleados de los departamentos 1 y 2 que tengan salario mayor a 25,000
SELECT
 e.id_empleado
 e.nombre,
 e.salario,
 e.id_departamento
FROM empleados AS e
WHERE (e.id_departamento=1
 OR
 e.id_departamento = 2)
 AND e.salario >25000;
;

--Mostrar los empleados que no tienen jefe 
SELECT
 p.id_empleado,
 p.id_departamento,
 p.nombre,
 p.id_jefe 
FROM empleados AS p
WHERE p.id_jefe IS NOT NULL;

-- OPERADOR BETWEEN 
-- permite comprar una columna con una lista de valores 

/*==================================================================================
WHERE columna BETWEEN limite_inferior AND limite_superior
====================================================================================*/

--Mostrar empleados con salario entre $15,000 y $20,000, incluyendo ambos limites 

SELECT 
 e.id_empleado,
 e.nombre,
 e.salario
FROM empleados AS e;
WHERE salario BETWEEN 15000 AND 20000
ORDER BY 3 DESC;

SELECT 
 e.id_empleado,
 e.nombre,
 e.salario
FROM empleados AS e;
WHERE e.salario >= 15000
 AND
 e.salario<=20000

-- Mostrar los productos que los precios esten en el rango de 100 y 200
SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p.existencia
FROM productos AS p
WHERE p.precio BETWEEN 100 AND 200;
--Mostrar las ventas del 1 de enero de 2025 al 10 de enero de 2025
SELECT 
 v.id_venta [numero_venta],
 v.id_cliente [cliente],
 v.id_empleado [empleado],
 v.fecha [fecha_venta]
 UPPER FORMAT(v.fecha, 'MMMM', 'es-ES') AS [mes_venta],
 UPPER (FORMAT(v.fecha, 'dddd', 'es-ES')) AS [dia_venta],
 DATEPART(YEAR, v.fecha) AS [a�o_venta]
FROM ventas AS v;
WHERE v.fecha BETWEEN '2025-01-01' AND '2025-01-10';
ORDER BY [cliente] ASC;
--Mostrar los productos que su rango de precios no este entre 100 y 400 
SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p.existencia
FROM productos AS p
WHERE p.precio NOT BETWEEN 100 AND 400;

--OPERADOR IN 
--permite comparar una columna con una lista de valores 

/*===============================================================================================
WHERE columna IN (valor_1, valor_2, valor_3)
===============================================================================================*/

-- Mostrar productos pretenecientes a las categorias 1,7 o 12
SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p.existencia,
  p.idcategoria
FROM productos AS p
WHERE p.categoria = (1,7,12);
ORDER BY p.id_categoria;

SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p.existencia,
  p.idcategoria
FROM productos AS p
WHERE p.categoria = 1
 OR p.id_categoria = 7
 OR p.idcategoria = 12
ORDER BY p.id_categoria;

--Mostrar todos los productos que no pertenecen a la categoria 1,7 y 12

SELECT
  p.codigo,
  p.nombre,
  p.precio,
  p.existencia,
  p.idcategoria
FROM productos AS p
WHERE p.categoria NOT IN (1,7,12);
ORDER BY p.id_categoria;