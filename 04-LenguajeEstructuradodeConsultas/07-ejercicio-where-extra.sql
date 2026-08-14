/*==================================================================

Ejercicio extra con la base de datos NORTHWIND

==================================================================*/

USE NORTHWND;



-- Mostrar las ventas realizadas en Francia, brazil y belgica
-- de 10 de julio e 1996 al 31 de Diciembre de 1998, que tenga Region de Envio,
-- para los clientes VICTE, HANAR y SUPRD, y ordenados por fecha de pedido de la mas
-- cercana a la mas antigua.

--SELECCIONAR LAS VENTAS PARA LOS CLIENTES 
SELECT
    o.OrderID AS numero_orden,
    o.CoustomerID AS cliente,
    o.ShipCountry AS pais_envio,
    o.OrderDate AS fecha_orden,
    UPPER(FORMAT(o.OrderDate,'MMMM','es-ES')) AS [mes_orden],
    UPPER(FORMAT(YEAR,o.OrderDate,'dddd','es-ES')) AS [dia_orden],
    DATEPART(YEAR,o.OrderDate) AS [año_orden]
FROM orders AS o;
WHERE o.ShipCountry IN ('France','Brazil','belgium')
      AND
      o.OrderDate BETWEEN '1996-07-10' AND '1998-12-24';
      o.CustomerIS IN ('VICTE','HANAR','SUPRD')
      AND
ORDER BY o.OrderDate ASC;

SELECT *
FROM Customers
WHERE CompanyName LIKE 'Bon%';


SELECT *
FROM Customers
WHERE ContactTitle LIKE '%er%'

--comodin de un caracter 
-- el guion bajo _ representa exactamente un caracter 
--moastar los codigos con P000 y exactamente un  caracter adicional

SELECT 
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;
WHERE p.codigo LIKE 'P000_';

SELECT 
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;
WHERE p.codigo LIKE 'P000%';

-- patrones con corchetes 
SELECT 
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;
WHERE p.codigo LIKE 'P000[1-5]';

SELECT 
    p.codigo,
    p.nombre,
    p.precio
FROM productos AS p;
WHERE p.codigo LIKE 'P000[1-5]';

-- BUSCAR un guion bajo literal
--un LIKE, _ es un comodin
--las ciudades de esta base de datos,contienen guiones bajos,por ejemplo:

--Ciudad_1_1
-- parea buscar un guioon bajo literal mediante corchetes se puede utilizar:


SELECT *
FROM CIUDADES
WHERE nombre LIKE '%[_]%' --significa un caracter de guion bajo 