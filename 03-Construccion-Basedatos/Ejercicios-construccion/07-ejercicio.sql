/*=================================================
        CREAR BASE DE DATOS
=================================================*/
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

/*=================================================
                SUCURSAL
=================================================*/
CREATE TABLE Sucursal(

    Clave INT PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    Ciudad VARCHAR(50),

    Estado VARCHAR(50),

    Telefono VARCHAR(20)

);
GO

/*=================================================
                  PUESTO
=================================================*/
CREATE TABLE Puesto(

    Clave INT PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    NivelJerarquico VARCHAR(50),

    Salario DECIMAL(10,2),

    SalarioNeto DECIMAL(10,2),

    ClaveSucursal INT NOT NULL,

    CONSTRAINT FK_Puesto_Sucursal
    FOREIGN KEY(ClaveSucursal)
    REFERENCES Sucursal(Clave)

);
GO

/*=================================================
              CAPACITACION
=================================================*/
CREATE TABLE Capacitacion(

    ClaveCapacitacion INT PRIMARY KEY,

    NombreCapacitacion VARCHAR(100) NOT NULL

);
GO

/*=================================================
             DEPARTAMENTO
=================================================*/
CREATE TABLE Departamento(

    ClaveDepto INT PRIMARY KEY,

    Nombre VARCHAR(50),

    Descripcion VARCHAR(100),

    Ubicacion VARCHAR(100),

    NumEmpJefe INT NULL

);
GO

/*=================================================
                PROYECTO
=================================================*/
CREATE TABLE Proyecto(

    Clave INT PRIMARY KEY,

    Nombre VARCHAR(100),

    Presupuesto DECIMAL(12,2),

    FechaInicio DATE,

    FechaTermino DATE

);
GO

/*=================================================
                 EMPLEADO
=================================================*/
CREATE TABLE Empleado(

    NumEmp INT PRIMARY KEY,

    CURP VARCHAR(18) UNIQUE,

    FechaNac DATE,

    Nombre VARCHAR(50),

    Ap1 VARCHAR(50),

    Ap2 VARCHAR(50),

    NumDomic VARCHAR(50),

    RFC VARCHAR(13),

    ClavePuesto INT NOT NULL,

    ClaveDepto INT NOT NULL,

    NumEmpJefe INT NULL,

    CONSTRAINT FK_Empleado_Puesto
    FOREIGN KEY(ClavePuesto)
    REFERENCES Puesto(Clave),

    CONSTRAINT FK_Empleado_Departamento
    FOREIGN KEY(ClaveDepto)
    REFERENCES Departamento(ClaveDepto),

    CONSTRAINT FK_Empleado_Jefe
    FOREIGN KEY(NumEmpJefe)
    REFERENCES Empleado(NumEmp)

);
GO

/*=================================================
      AGREGAR FK DEL JEFE DE DEPARTAMENTO
=================================================*/
ALTER TABLE Departamento
ADD CONSTRAINT FK_Departamento_Jefe
FOREIGN KEY(NumEmpJefe)
REFERENCES Empleado(NumEmp);
GO

/*=================================================
                ASISTIR
=================================================*/
CREATE TABLE Asistir(

    NumEmp INT,

    ClaveCapacitacion INT,

    FechaIni DATE,

    Calificacion DECIMAL(4,2),

    Status VARCHAR(20),

    CONSTRAINT PK_Asistir
    PRIMARY KEY(NumEmp,ClaveCapacitacion),

    CONSTRAINT FK_Asistir_Empleado
    FOREIGN KEY(NumEmp)
    REFERENCES Empleado(NumEmp),

    CONSTRAINT FK_Asistir_Capacitacion
    FOREIGN KEY(ClaveCapacitacion)
    REFERENCES Capacitacion(ClaveCapacitacion)

);
GO

/*=================================================
                PARTICIPA
=================================================*/
CREATE TABLE Participa(

    NumEmp INT,

    ClaveProyecto INT,

    Rol VARCHAR(50),

    FechaAsignacion DATE,

    CONSTRAINT PK_Participa
    PRIMARY KEY(NumEmp,ClaveProyecto),

    CONSTRAINT FK_Participa_Empleado
    FOREIGN KEY(NumEmp)
    REFERENCES Empleado(NumEmp),

    CONSTRAINT FK_Participa_Proyecto
    FOREIGN KEY(ClaveProyecto)
    REFERENCES Proyecto(Clave)

);
GO
/*=========================================
    INSERTAR DATOS EN SUCURSAL
=========================================*/
INSERT INTO Sucursal VALUES
(1,'Sucursal Centro','Tula','Hidalgo','7731112233'),
(2,'Sucursal Norte','Pachuca','Hidalgo','7712233445');
GO

/*=========================================
    INSERTAR DATOS EN PUESTO
=========================================*/
INSERT INTO Puesto VALUES
(1,'Gerente','Alto',35000,32000,1),
(2,'Analista','Medio',22000,20000,1),
(3,'Programador','Operativo',18000,16500,2);
GO

/*=========================================
    INSERTAR DATOS EN CAPACITACION
=========================================*/
INSERT INTO Capacitacion VALUES
(1,'SQL Server'),
(2,'Java'),
(3,'Power BI');
GO

/*=========================================
    INSERTAR DATOS EN DEPARTAMENTO
=========================================*/
INSERT INTO Departamento
(ClaveDepto,Nombre,Descripcion,Ubicacion,NumEmpJefe)
VALUES
(1,'Sistemas','Área de TI','Edificio A',NULL),
(2,'Recursos Humanos','Área de Personal','Edificio B',NULL);
GO

/*=========================================
    INSERTAR DATOS EN EMPLEADO
=========================================*/
INSERT INTO Empleado VALUES
(1,'PEPJ980101HDFRRN01','1998-01-01','Juan','Perez','Lopez',
'101','PEPJ980101AB1',1,1,NULL),

(2,'LOMA990202MDFRRN02','1999-02-02','Maria','Lopez','Alvarez',
'102','LOMA990202AB2',2,1,1),

(3,'RUGC000303HDFRRN03','2000-03-03','Carlos','Ruiz','Garcia',
'103','RUGC000303AB3',3,2,1);
GO

/*=========================================
    ACTUALIZAR JEFE DEPARTAMENTO
=========================================*/
UPDATE Departamento
SET NumEmpJefe=1
WHERE ClaveDepto=1;

UPDATE Departamento
SET NumEmpJefe=3
WHERE ClaveDepto=2;
GO

/*=========================================
    INSERTAR DATOS EN PROYECTO
=========================================*/
INSERT INTO Proyecto VALUES
(1,'Sistema Escolar',300000,'2026-01-10','2026-06-30'),
(2,'Control Inventarios',250000,'2026-03-15','2026-10-15');
GO

/*=========================================
    INSERTAR DATOS EN ASISTIR
=========================================*/
INSERT INTO Asistir VALUES
(2,1,'2026-02-01',95,'Aprobado'),
(2,2,'2026-03-15',90,'Aprobado'),
(3,3,'2026-04-10',88,'Aprobado');
GO

/*=========================================
    INSERTAR DATOS EN PARTICIPA
=========================================*/
INSERT INTO Participa VALUES
(1,1,'Líder','2026-01-15'),
(2,1,'Programador','2026-01-20'),
(3,2,'Analista','2026-03-20');
GO

/*=========================================
    CONSULTAS
=========================================*/

-- Sucursales
SELECT * FROM Sucursal;

-- Puestos
SELECT * FROM Puesto;

-- Empleados
SELECT * FROM Empleado;

-- Departamentos
SELECT * FROM Departamento;

-- Capacitaciones
SELECT * FROM Capacitacion;

-- Proyectos
SELECT * FROM Proyecto;

-- Asistencias
SELECT * FROM Asistir;

-- Participaciones
SELECT * FROM Participa;

-- Empleado y puesto
SELECT
E.Nombre,
E.Ap1,
P.Nombre AS Puesto
FROM Empleado E
INNER JOIN Puesto P
ON E.ClavePuesto=P.Clave;

-- Empleado y departamento
SELECT
E.Nombre,
D.Nombre AS Departamento
FROM Empleado E
INNER JOIN Departamento D
ON E.ClaveDepto=D.ClaveDepto;

-- Puestos por sucursal
SELECT
P.Nombre AS Puesto,
S.Nombre AS Sucursal
FROM Puesto P
INNER JOIN Sucursal S
ON P.ClaveSucursal=S.Clave;

-- Empleados con capacitaciones
SELECT
E.Nombre,
C.NombreCapacitacion,
A.Calificacion,
A.Status
FROM Asistir A
INNER JOIN Empleado E
ON A.NumEmp=E.NumEmp
INNER JOIN Capacitacion C
ON A.ClaveCapacitacion=C.ClaveCapacitacion;

-- Empleados en proyectos
SELECT
E.Nombre,
PR.Nombre AS Proyecto,
PA.Rol
FROM Participa PA
INNER JOIN Empleado E
ON PA.NumEmp=E.NumEmp
INNER JOIN Proyecto PR
ON PA.ClaveProyecto=PR.Clave;