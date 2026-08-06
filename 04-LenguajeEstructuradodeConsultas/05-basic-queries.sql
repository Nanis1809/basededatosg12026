/*==============================================================================
 DQL (DATA QUERY LANGUAGE)
 Archivo: 05-basic-queries.sql
 Descripcion: Se realizan consultas basicas con select
===============================================================================*/

USE comercial_db;
-- Uso de SELECT *

/*===========================================
Sintaxis 
SELECT *
FROM nombre_tabla;
NOTA: EL * significa todas las columnas de la tabla
no se recomienda utilizarla siempre:
1)reduce la claridad de la consulta
2)puede aumentar el consumo de recursos 
3)puede afectar aplicaciones futuras 
============================================*/

SELECT *
FROM productos;
GO

-- proyeccion de la tabla de productos 
SELECT 
    codigo,
    nombre,
    precio
FROM  productos;

SELECT 
    nombre,
    codigo,
    precio
FROM  productos;
GO

-- Alias de columna (sobrenombre que se la pone el campo)

SELECT 
    codigo AS [codigo_producto],
    nombre AS [nombre_producto],
    precio AS [precio_unitario],
FROM productos;

-- Alias de espacios 
SELECT 
    nombre AS [nombre_producto],
    codigo AS [codigo_producto],
    precio AS [precio_unitario],
FROM productos;

-- Alias sin la  instruccion AS (no recomendado)
SELECT 
    codigo AS [codigo_producto],
    nombre AS [nombre_producto],
    precio AS [precio_unitario],
FROM productos;

SELECT 
    codigo AS [codigo_producto],
    nombre AS [nombre_producto],
    precio AS [precio_unitario],
FROM productos;

-- alias tabla (es util en los join y en nombres ambiguos)
SELECT 
    p.nombre,
    p.codigo,
    p.precio
FROM  productos AS p;

SELECT 
categorias.id_categoria,
categorias.nombre,
categorias.id_categoria,
categorias.nombre,precio
FROM categorias
INNER JOIN
productos
ON categorias.id_categoria=productos.id_categoria;


-- columnas calculadas,
-- campos calculados  y E-R Atributo derivado

-- Seleccionar el codigo,nombre,precio,existencia
-- y el valor del  inventario 

SELECT 
    p.codigo AS codigo_producto,
    p.nombre AS nombre_producto,
    p.precio AS precio_unitario,
    p.existencia,
    (p.existencia * p.precio) AS precio_inventario
FROM productos AS p;

-- TODO: operadores aritmeticos
-- ejercicios de campos calculados
/* ============================================================
   + suma
   - resta
   * multiplicacion 
   / division
   % modulo  o residuo de la division
   ==========================================================*/
   -- Seleccionar los empleados y calcular su salario anual 
   SELECT
    e.nombre,
    e.apellido_paterno,
    e.salario AS salario_anual,
    (salario * 12) AS salario_anual

   FROM empleados AS e;
   GO
   
   -- Seleccionar el detalle de las ventas,mostrando 
   -- numero de venta,cantidad,precio,descuento
   -- calcular el importe bruto(cantidad por el precio)
   -- calcular el importe con descuento(importe_bruto * descuento / 100)
   -- calcula el importe neto,(importe_bruto por 1 menos el descuento entre 100)

   SELECT 
   dv.id_venta AS #venta,
   dv.cantidad AS cantidad_vendida,
   dv.precio AS [precio de venta],
   dv.descuento AS 'descuento de venta',
   dv.cantidad * dv.precio AS importe_bruto,
   (dv.cantidad * dv.precio / 100.0) AS importe_descuento,
   dv.cantidad * dv.precio * (1.0 - descuento/100.0) AS importe_neto

   FROM detalle_ventas AS dv
   GO