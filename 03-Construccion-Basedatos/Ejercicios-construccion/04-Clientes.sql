USE master;
GO

IF DB_ID('ventas') IS NOT NULL
BEGIN
    ALTER DATABASE ventas SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE ventas;
END
GO

CREATE DATABASE ventas;
GO

USE ventas;
GO


/*=============================
        TABLA CLIENTES
=============================*/
CREATE TABLE clientes(

    NumCliente INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(100) NOT NULL,

    RFC VARCHAR(20) NOT NULL

);
GO


/*=============================
        TABLA PEDIDO
=============================*/
CREATE TABLE pedido(

    NumPedido INT IDENTITY(1,1) PRIMARY KEY,

    Fecha DATE NOT NULL,

    NumCliente INT NOT NULL,

    CONSTRAINT FK_pedido_cliente
    FOREIGN KEY(NumCliente)
    REFERENCES clientes(NumCliente)

);
GO


/*=============================
        TABLA PRODUCTO
=============================*/
CREATE TABLE producto(

    NumProducto INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(100) NOT NULL,

    Precio DECIMAL(10,2) NOT NULL
    CHECK(Precio > 0)

);
GO


/*=============================
    TABLA PEDIDO_PRODUCTO
=============================*/
CREATE TABLE pedido_producto(

    NumPedido INT NOT NULL,

    NumProducto INT NOT NULL,

    Cantidad INT NOT NULL
    CHECK(Cantidad > 0),

    PrecioUnitario DECIMAL(10,2) NOT NULL
    CHECK(PrecioUnitario > 0),

    CONSTRAINT PK_pedido_producto
    PRIMARY KEY(NumPedido,NumProducto),

    CONSTRAINT FK_pp_pedido
    FOREIGN KEY(NumPedido)
    REFERENCES pedido(NumPedido),

    CONSTRAINT FK_pp_producto
    FOREIGN KEY(NumProducto)
    REFERENCES producto(NumProducto)

);
GO


/*=============================
      DATOS DE EJEMPLO
=============================*/

INSERT INTO clientes(Nombre,RFC)
VALUES
('Juan Perez','PEPJ010101AA1'),
('Maria Lopez','LOPM020202BB2'),
('Carlos Garcia','GARC030303CC3');
GO

INSERT INTO producto(Nombre,Precio)
VALUES
('Laptop',15000.00),
('Mouse',350.00),
('Teclado',800.00);
GO

INSERT INTO pedido(Fecha,NumCliente)
VALUES
('2026-08-01',1),
('2026-08-02',2),
('2026-08-03',3);
GO

INSERT INTO pedido_producto(NumPedido,NumProducto,Cantidad,PrecioUnitario)
VALUES
(1,1,1,15000.00),
(1,2,2,350.00),
(2,3,1,800.00),
(3,2,3,350.00);
GO


/*=============================
        CONSULTAS
=============================*/

SELECT * FROM clientes;
GO

SELECT * FROM pedido;
GO

SELECT * FROM producto;
GO

SELECT * FROM pedido_producto;
GO


/*=============================
   CONSULTA GENERAL
=============================*/

SELECT
    C.Nombre AS Cliente,
    P.NumPedido,
    P.Fecha,
    PR.Nombre AS Producto,
    PP.Cantidad,
    PP.PrecioUnitario
FROM pedido_producto PP
INNER JOIN pedido P
ON PP.NumPedido = P.NumPedido
INNER JOIN clientes C
ON P.NumCliente = C.NumCliente
INNER JOIN producto PR
ON PP.NumProducto = PR.NumProducto;
GO