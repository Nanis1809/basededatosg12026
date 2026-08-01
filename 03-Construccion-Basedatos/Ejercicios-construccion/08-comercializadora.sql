/*=========================================
    CREAR BASE DE DATOS
=========================================*/
USE master;
GO

IF DB_ID('Comercializadora') IS NOT NULL
BEGIN
    ALTER DATABASE Comercializadora
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Comercializadora;
END
GO

CREATE DATABASE Comercializadora;
GO

USE Comercializadora;
GO

/*=========================================
    TABLA OFICINA
=========================================*/
CREATE TABLE Oficina(
    NumOfi INT PRIMARY KEY,
    Region VARCHAR(50),
    Ciudad VARCHAR(50),
    Objetivos DECIMAL(12,2),
    Ventas DECIMAL(12,2)
);
GO

/*=========================================
    TABLA REPRESENTANTE
=========================================*/
CREATE TABLE Representante(
    NumRep INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Edad INT,
    Cargo VARCHAR(50),
    Cuota DECIMAL(12,2),
    FechaCont DATE,
    AreaVentas VARCHAR(100),
    Jefe INT NULL,
    NumOfi INT,

    CONSTRAINT FK_Representante_Jefe
        FOREIGN KEY(Jefe)
        REFERENCES Representante(NumRep),

    CONSTRAINT FK_Representante_Oficina
        FOREIGN KEY(NumOfi)
        REFERENCES Oficina(NumOfi)
);
GO

/*=========================================
    TABLA CLIENTE
=========================================*/
CREATE TABLE Cliente(
    NumCli INT PRIMARY KEY,
    NombreEmp VARCHAR(100),
    LimiteCredito DECIMAL(12,2),
    NumRep INT,

    CONSTRAINT FK_Cliente_Representante
        FOREIGN KEY(NumRep)
        REFERENCES Representante(NumRep)
);
GO

/*=========================================
    TABLA PEDIDO
=========================================*/
CREATE TABLE Pedido(
    NumPed INT PRIMARY KEY,
    FechaPedido DATE,
    NumCli INT,

    CONSTRAINT FK_Pedido_Cliente
        FOREIGN KEY(NumCli)
        REFERENCES Cliente(NumCli)
);
GO

/*=========================================
    TABLA PRODUCTO
=========================================*/
CREATE TABLE Producto(
    NumProd INT PRIMARY KEY,
    Descripcion VARCHAR(200),
    Existencia INT,
    Precio DECIMAL(10,2),
    Fabricante VARCHAR(100)
);
GO

/*=========================================
    TABLA INCLUYE
    (Relación N:M entre Pedido y Producto)
=========================================*/
CREATE TABLE Incluye(
    NumPed INT,
    NumProd INT,
    Cantidad INT,
    Precio DECIMAL(10,2),

    PRIMARY KEY(NumPed, NumProd),

    CONSTRAINT FK_Incluye_Pedido
        FOREIGN KEY(NumPed)
        REFERENCES Pedido(NumPed),

    CONSTRAINT FK_Incluye_Producto
        FOREIGN KEY(NumProd)
        REFERENCES Producto(NumProd)
);
GO
/*=========================================
    INSERTAR DATOS EN OFICINA
=========================================*/
INSERT INTO Oficina VALUES
(101,'Norte','Monterrey',500000,450000),
(102,'Centro','Ciudad de México',700000,680000),
(103,'Sur','Mérida',300000,250000);
GO

/*=========================================
    INSERTAR DATOS EN REPRESENTANTE
=========================================*/
INSERT INTO Representante
(NumRep,Nombre,Edad,Cargo,Cuota,FechaCont,AreaVentas,Jefe,NumOfi)
VALUES
(1,'Juan Pérez',45,'Gerente',100000,'2020-01-15','Electrónicos',NULL,101),
(2,'Ana López',30,'Vendedor',50000,'2022-03-10','Electrónicos',1,101),
(3,'Carlos Ruiz',35,'Vendedor',60000,'2021-07-20','Hogar',1,102),
(4,'María Torres',28,'Vendedor',45000,'2023-01-12','Oficina',1,103);
GO

/*=========================================
    INSERTAR DATOS EN CLIENTE
=========================================*/
INSERT INTO Cliente VALUES
(1001,'Papelería López',30000,2),
(1002,'Abarrotes García',50000,3),
(1003,'Ferretería El Tornillo',40000,4);
GO

/*=========================================
    INSERTAR DATOS EN PRODUCTO
=========================================*/
INSERT INTO Producto VALUES
(501,'Laptop Lenovo',15,18000,'Lenovo'),
(502,'Impresora HP',10,4500,'HP'),
(503,'Mouse Inalámbrico',40,350,'Logitech'),
(504,'Monitor Samsung 24"',20,3800,'Samsung');
GO

/*=========================================
    INSERTAR DATOS EN PEDIDO
=========================================*/
INSERT INTO Pedido VALUES
(9001,'2026-07-25',1001),
(9002,'2026-07-26',1002),
(9003,'2026-07-27',1003);
GO

/*=========================================
    INSERTAR DATOS EN INCLUYE
=========================================*/
INSERT INTO Incluye VALUES
(9001,501,2,18000),
(9001,503,5,350),
(9002,502,1,4500),
(9002,504,2,3800),
(9003,503,10,350);
GO

/*=========================================
    CONSULTAS DE EJEMPLO
=========================================*/

-- Ver todas las oficinas
SELECT * FROM Oficina;

-- Ver representantes
SELECT * FROM Representante;

-- Ver clientes
SELECT * FROM Cliente;

-- Ver productos
SELECT * FROM Producto;

-- Ver pedidos
SELECT * FROM Pedido;

-- Ver detalle de los pedidos
SELECT * FROM Incluye;

-- Mostrar qué cliente hizo cada pedido
SELECT
P.NumPed,
C.NombreEmp,
P.FechaPedido
FROM Pedido P
INNER JOIN Cliente C
ON P.NumCli = C.NumCli;

-- Mostrar productos de cada pedido
SELECT
I.NumPed,
PR.Descripcion,
I.Cantidad,
I.Precio
FROM Incluye I
INNER JOIN Producto PR
ON I.NumProd = PR.NumProd;