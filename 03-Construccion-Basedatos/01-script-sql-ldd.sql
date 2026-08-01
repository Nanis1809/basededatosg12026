--=========================================
-- CREAR BASE DE DATOS
--=========================================

CREATE DATABASE empresa_yoda;
GO

USE empresa_yoda;
GO

--=========================================
-- TABLA CATEGORIA
--=========================================

CREATE TABLE categoria(
    categoria_id INT IDENTITY(1,1),
    nombre VARCHAR(20) NOT NULL,
    activo BIT NOT NULL DEFAULT 1,

    CONSTRAINT PK_CATEGORIA
    PRIMARY KEY(categoria_id),

    CONSTRAINT UQ_CATEGORIA_NOMBRE
    UNIQUE(nombre)
);
GO

--=========================================
-- TABLA PRODUCTO
--=========================================

CREATE TABLE producto(
    producto_id INT NOT NULL,
    fabricante_id CHAR(3) NOT NULL,
    nombre VARCHAR(25) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    existencia INT NOT NULL,
    activo BIT NOT NULL DEFAULT 1,
    categoria_id INT NOT NULL,

    CONSTRAINT PK_PRODUCTO
    PRIMARY KEY(producto_id,fabricante_id),

    CONSTRAINT UQ_PRODUCTO_NOMBRE
    UNIQUE(nombre),

    CONSTRAINT CK_PRODUCTO_PRECIO
    CHECK(precio BETWEEN 1 AND 10000),

    CONSTRAINT CK_PRODUCTO_EXISTENCIA
    CHECK(existencia>0),

    CONSTRAINT FK_PRODUCTO_CATEGORIA
    FOREIGN KEY(categoria_id)
    REFERENCES categoria(categoria_id)
);
GO

--=========================================
-- TABLA PROVEEDOR
--=========================================

CREATE TABLE proveedor(
    proveedor_id INT NOT NULL,

    empresa VARCHAR(30) NOT NULL,

    direccion VARCHAR(60),

    limite_credito DECIMAL(10,2) NOT NULL,

    CONSTRAINT PK_PROVEEDOR
    PRIMARY KEY(proveedor_id)
);
GO

--=========================================
-- TABLA CONTACTO_PROVEEDOR
--=========================================

CREATE TABLE contacto_proveedor(

    contacto_id INT NOT NULL,

    nombre VARCHAR(20) NOT NULL,

    apellido_paterno VARCHAR(15) NOT NULL,

    apellido_materno VARCHAR(15),

    telefono VARCHAR(15) NOT NULL,

    proveedor_id INT NOT NULL,

    CONSTRAINT PK_CONTACTO
    PRIMARY KEY(contacto_id),

    CONSTRAINT FK_CONTACTO_PROVEEDOR
    FOREIGN KEY(proveedor_id)
    REFERENCES proveedor(proveedor_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);
GO

--=========================================
-- INSERTS CATEGORIA
--=========================================

INSERT INTO categoria(nombre)
VALUES
('Front End'),
('Back End'),
('Cloud');

SELECT * FROM categoria;
GO

--=========================================
-- INSERTS PRODUCTO
--=========================================

INSERT INTO producto
VALUES
(1,'FF1','Tailwind',987.34,45,DEFAULT,1);

INSERT INTO producto
VALUES
(2,'FF1','Bootstrap',567.80,24,0,1);

INSERT INTO producto
VALUES
(1,'FF2','AWS',34.50,12,DEFAULT,3);

SELECT * FROM producto;
GO

--=========================================
-- INSERTS PROVEEDOR
--=========================================

INSERT INTO proveedor
VALUES
(1,'Patito de Hule',NULL,67888.01),
(2,'Bimbo',NULL,5678.01),
(3,'Dulces Domingo',NULL,6785.01),
(4,'Drugs Kevin',NULL,6789.01);

SELECT * FROM proveedor;
GO

--=========================================
-- INSERTS CONTACTO
--=========================================

INSERT INTO contacto_proveedor
VALUES
(1,'Juan','Perez','Lopez','7711111111',1),
(2,'Maria','Santos','Diaz','7712222222',2),
(3,'Carlos','Garcia','Ruiz','7713333333',3);

SELECT * FROM contacto_proveedor;
GO

--=========================================
-- DELETE
--=========================================

DELETE FROM proveedor
WHERE proveedor_id=2;

DROP TABLE contacto_proveedor 
DROP TABLE producto;

SELECT *
FROM proveedor AS p
INNER JOIN contacto_proveedor AS cp
ON p.proveedor_id = cp.proveedor_id;

DELETE FROM proveedor
WHERE proveedor_id =2;

SELECT * FROM proveedor;
SELECT * FROM contacto_proveedor;

SET proveedor_id = 6
WHERE proveedor_id = 3;

