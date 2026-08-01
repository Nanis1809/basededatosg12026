/*=================================================
    CREAR BASE DE DATOS
=================================================*/
USE master;
GO

IF DB_ID('Company') IS NOT NULL
BEGIN
    ALTER DATABASE Company
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE Company;
END
GO

CREATE DATABASE Company;
GO

USE Company;
GO

/*=================================================
    DEPARTMENT
=================================================*/
CREATE TABLE Department(
    NumberDep INT PRIMARY KEY,
    NameDep VARCHAR(100) UNIQUE NOT NULL,
    Manager INT NULL,
    StartDate DATE
);
GO

/*=================================================
    EMPLOYEE
=================================================*/
CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY,
    SSN CHAR(13) UNIQUE NOT NULL,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Address VARCHAR(150),
    Salary DECIMAL(10,2),
    Sex CHAR(1),
    BirthDate DATE,
    NumberDep INT NOT NULL,
    Jef INT NULL,

    CONSTRAINT FK_Employee_Department
        FOREIGN KEY(NumberDep)
        REFERENCES Department(NumberDep),

    CONSTRAINT FK_Employee_Jefe
        FOREIGN KEY(Jef)
        REFERENCES Employee(EmployeeID)
);
GO

/*=================================================
    AGREGAR FK DEL GERENTE
=================================================*/
ALTER TABLE Department
ADD CONSTRAINT FK_Department_Manager
FOREIGN KEY(Manager)
REFERENCES Employee(EmployeeID);
GO

/*=================================================
    LOCATIONS
=================================================*/
CREATE TABLE Locations(
    NumLocation INT PRIMARY KEY,
    NameLocation VARCHAR(100),
    NumberDep INT NOT NULL,

    CONSTRAINT FK_Location_Department
        FOREIGN KEY(NumberDep)
        REFERENCES Department(NumberDep)
);
GO

/*=================================================
    PROJECT
=================================================*/
CREATE TABLE Project(
    NumberProj INT PRIMARY KEY,
    NameProj VARCHAR(100) UNIQUE,
    Location VARCHAR(100),
    NumberDep INT NOT NULL,

    CONSTRAINT FK_Project_Department
        FOREIGN KEY(NumberDep)
        REFERENCES Department(NumberDep)
);
GO

/*=================================================
    DEPENDENT
=================================================*/
CREATE TABLE Dependent(
    SSN CHAR(13),
    Name VARCHAR(100),
    Sex CHAR(1),
    BirthDate DATE,
    Relationship VARCHAR(50),

    PRIMARY KEY(SSN,Name),

    CONSTRAINT FK_Dependent_Employee
        FOREIGN KEY(SSN)
        REFERENCES Employee(SSN)
);
GO

/*=================================================
    WORKS_ON
=================================================*/
CREATE TABLE Works_On(
    EmployeeID INT,
    NumberProj INT,
    Hours DECIMAL(5,2),

    PRIMARY KEY(EmployeeID,NumberProj),

    CONSTRAINT FK_WorksOn_Employee
        FOREIGN KEY(EmployeeID)
        REFERENCES Employee(EmployeeID),

    CONSTRAINT FK_WorksOn_Project
        FOREIGN KEY(NumberProj)
        REFERENCES Project(NumberProj)
);
GO
/*==========================
DEPARTAMENTOS
==========================*/
INSERT INTO Department VALUES
(1,'Sistemas',NULL,'2025-01-10'),
(2,'Recursos Humanos',NULL,'2025-02-15');

/*==========================
EMPLEADOS
==========================*/
INSERT INTO Employee VALUES
(1,'ABC1234567890','Juan','Perez','Tula',25000,'M','1995-05-10',1,NULL),
(2,'DEF1234567890','Maria','Lopez','Pachuca',22000,'F','1998-07-18',1,1),
(3,'GHI1234567890','Carlos','Ruiz','Actopan',21000,'M','1997-09-20',2,NULL);

/*==========================
ASIGNAR GERENTES
==========================*/
UPDATE Department
SET Manager=1
WHERE NumberDep=1;

UPDATE Department
SET Manager=3
WHERE NumberDep=2;

/*==========================
UBICACIONES
==========================*/
INSERT INTO Locations VALUES
(1,'Tula',1),
(2,'Pachuca',2);

/*==========================
PROYECTOS
==========================*/
INSERT INTO Project VALUES
(1,'SistemaVentas','Tula',1),
(2,'SistemaRH','Pachuca',2);

/*==========================
DEPENDIENTES
==========================*/
INSERT INTO Dependent VALUES
('ABC1234567890','Ana','F','2015-04-12','Hija'),
('DEF1234567890','Luis','M','2018-08-22','Hijo');

/*==========================
TRABAJA EN
==========================*/
INSERT INTO Works_On VALUES
(1,1,40),
(2,1,35),
(3,2,40);
-- Todos los empleados
SELECT * FROM Employee;

-- Empleados con su departamento
SELECT
E.FirstName,
E.LastName,
D.NameDep
FROM Employee E
INNER JOIN Department D
ON E.NumberDep=D.NumberDep;

-- Gerentes
SELECT
D.NameDep,
E.FirstName,
E.LastName
FROM Department D
INNER JOIN Employee E
ON D.Manager=E.EmployeeID;

-- Proyectos por departamento
SELECT
P.NameProj,
D.NameDep
FROM Project P
INNER JOIN Department D
ON P.NumberDep=D.NumberDep;

-- Empleados trabajando en proyectos
SELECT
E.FirstName,
P.NameProj,
W.Hours
FROM Works_On W
INNER JOIN Employee E
ON W.EmployeeID=E.EmployeeID
INNER JOIN Project P
ON W.NumberProj=P.NumberProj;

-- Dependientes
SELECT
E.FirstName,
D.Name,
D.Relationship
FROM Employee E
INNER JOIN Dependent D
ON E.SSN=D.SSN;