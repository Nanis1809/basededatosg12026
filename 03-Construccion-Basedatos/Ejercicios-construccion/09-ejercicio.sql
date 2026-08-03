/*=========================================
    CREAR BASE DE DATOS
=========================================*/
USE master;
GO

IF DB_ID('Empresa') IS NOT NULL
BEGIN
    ALTER DATABASE Empresa
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Empresa;
END
GO

CREATE DATABASE Empresa;
GO

USE Empresa;
GO

/*=========================================
    TABLA PUESTO
=========================================*/
CREATE TABLE Puesto(
    Clave INT PRIMARY KEY,
    Nombre VARCHAR(100),
    NivelJerarquico VARCHAR(50),
    Salario DECIMAL(10,2),
    SalarioNeto DECIMAL(10,2)
);
GO

/*=========================================
    TABLA DEPARTAMENTO
=========================================*/
CREATE TABLE Departamento(
    ClaveDepto INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Descripcion VARCHAR(200),
    Ubicacion VARCHAR(100)
);
GO

/*=========================================
    TABLA SUCURSAL
=========================================*/
CREATE TABLE Sucursal(
    Clave INT PRIMARY KEY,
    Nombre VARCHAR(100),
    Estado VARCHAR(100),
    Ciudad VARCHAR(100)
);
GO

/*=========================================
    TABLA CAPACITACION
=========================================*/
CREATE TABLE Capacitacion(
    Clave INT PRIMARY KEY,
    Nombre VARCHAR(100)
);
GO

/*=========================================
    TABLA PROYECTO
=========================================*/
CREATE TABLE Proyecto(
    Clave INT PRIMARY KEY,
    FechaInicio DATE,
    FechaTermino DATE,
    Presupuesto DECIMAL(12,2),
    ClaveSucursal INT,

    CONSTRAINT FK_Proyecto_Sucursal
    FOREIGN KEY (ClaveSucursal)
    REFERENCES Sucursal(Clave)
);
GO

/*=========================================
    TABLA EMPLEADO
=========================================*/
CREATE TABLE Empleado(
    Clave INT PRIMARY KEY,
    NumeroEmp INT,
    Nombre VARCHAR(100),
    NumDomic VARCHAR(100),
    CURP VARCHAR(18),
    RFC VARCHAR(13),
    Jefe INT NULL,
    ClavePuesto INT,
    ClaveDepto INT,

    CONSTRAINT FK_Empleado_Jefe
    FOREIGN KEY(Jefe)
    REFERENCES Empleado(Clave),

    CONSTRAINT FK_Empleado_Puesto
    FOREIGN KEY(ClavePuesto)
    REFERENCES Puesto(Clave),

    CONSTRAINT FK_Empleado_Departamento
    FOREIGN KEY(ClaveDepto)
    REFERENCES Departamento(ClaveDepto)
);
GO

/*=========================================
    PARTICIPA
=========================================*/
CREATE TABLE Participa(
    ClaveEmpleado INT,
    ClaveProyecto INT,
    Rol VARCHAR(100),
    FechaAsignacion DATE,

    PRIMARY KEY(ClaveEmpleado,ClaveProyecto),

    CONSTRAINT FK_Participa_Empleado
    FOREIGN KEY(ClaveEmpleado)
    REFERENCES Empleado(Clave),

    CONSTRAINT FK_Participa_Proyecto
    FOREIGN KEY(ClaveProyecto)
    REFERENCES Proyecto(Clave)
);
GO

/*=========================================
    ASISTE
=========================================*/
CREATE TABLE Asiste(
    ClaveEmpleado INT,
    ClaveCapacitacion INT,
    Calificacion DECIMAL(5,2),
    Status VARCHAR(50),

    PRIMARY KEY(ClaveEmpleado,ClaveCapacitacion),

    CONSTRAINT FK_Asiste_Empleado
    FOREIGN KEY(ClaveEmpleado)
    REFERENCES Empleado(Clave),

    CONSTRAINT FK_Asiste_Capacitacion
    FOREIGN KEY(ClaveCapacitacion)
    REFERENCES Capacitacion(Clave)
);
GO
/* PUESTOS */
INSERT INTO Puesto VALUES
(1,'Gerente','Alto',50000,45000),
(2,'Analista','Medio',25000,22000),
(3,'Programador','Operativo',20000,18000);

/* DEPARTAMENTOS */
INSERT INTO Departamento VALUES
(1,'Sistemas','Área de TI','Edificio A'),
(2,'Recursos Humanos','Personal','Edificio B');

/* SUCURSALES */
INSERT INTO Sucursal VALUES
(1,'Sucursal Centro','Hidalgo','Tula'),
(2,'Sucursal Norte','Querétaro','Querétaro');

/* CAPACITACIONES */
INSERT INTO Capacitacion VALUES
(1,'SQL Server'),
(2,'Java');

/* PROYECTOS */
INSERT INTO Proyecto VALUES
(1,'2026-01-10','2026-06-30',150000,1),
(2,'2026-03-01','2026-09-30',250000,2);

/* EMPLEADOS */
INSERT INTO Empleado VALUES
(1,1001,'Juan Pérez','Calle 1','PEPJ900101HDFRRN01','PEPJ900101AB1',NULL,1,1),
(2,1002,'Ana López','Calle 2','LOPA920202MDFRRN02','LOPA920202AB2',1,2,1),
(3,1003,'Carlos Ruiz','Calle 3','RUIC930303HDFRRN03','RUIC930303AB3',1,3,2);

/* PARTICIPA */
INSERT INTO Participa VALUES
(2,1,'Desarrollador','2026-01-15'),
(3,2,'Tester','2026-03-05');

/* ASISTE */
INSERT INTO Asiste VALUES
(2,1,95,'Aprobado'),
(3,2,90,'Aprobado');
-- Empleados
SELECT * FROM Empleado;

-- Departamentos
SELECT * FROM Departamento;

-- Empleados con su puesto
SELECT
E.Nombre,
P.Nombre AS Puesto
FROM Empleado E
INNER JOIN Puesto P
ON E.ClavePuesto = P.Clave;

-- Empleados con departamento
SELECT
E.Nombre,
D.Nombre AS Departamento
FROM Empleado E
INNER JOIN Departamento D
ON E.ClaveDepto = D.ClaveDepto;

-- Participación en proyectos
SELECT
E.Nombre,
PR.Clave AS Proyecto,
PA.Rol
FROM Participa PA
INNER JOIN Empleado E
ON PA.ClaveEmpleado=E.Clave
INNER JOIN Proyecto PR
ON PA.ClaveProyecto=PR.Clave;

-- Capacitaciones
SELECT
E.Nombre,
C.Nombre,
A.Calificacion,
A.Status
FROM Asiste A
INNER JOIN Empleado E
ON A.ClaveEmpleado=E.Clave
INNER JOIN Capacitacion C
ON A.ClaveCapacitacion=C.Clave;