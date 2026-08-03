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
(1,'Gerente','Alto',30000,50000,1),
(2,'Analista','Medio',18000,25000,1),
(3,'Programador','Operativo',15000,22000,2);
GO

/*=========================================
    INSERTAR DATOS EN DEPARTAMENTO
=========================================*/
INSERT INTO Departamento
(ClaveDepto,Nombre,Presupuesto,Ubicacion,NumEmpJefe)
VALUES
(1,'Sistemas',250000,'Edificio A',NULL),
(2,'Recursos Humanos',180000,'Edificio B',NULL);
GO

/*=========================================
    INSERTAR DATOS EN EMPLEADO
=========================================*/
INSERT INTO Empleado VALUES
(1,'HEPJ980101HDFRRN01','1998-01-01','Juan','Perez','Lopez',1,1,NULL),
(2,'LOMA990202MDFRRN02','1999-02-02','Maria','Lopez','Alvarez',2,1,1),
(3,'RUGC000303HDFRRN03','2000-03-03','Carlos','Ruiz','Garcia',3,2,1);
GO

/*=========================================
    ASIGNAR JEFES A DEPARTAMENTO
=========================================*/
UPDATE Departamento
SET NumEmpJefe=1
WHERE ClaveDepto=1;

UPDATE Departamento
SET NumEmpJefe=3
WHERE ClaveDepto=2;
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
    INSERTAR DATOS EN ASISTIR
=========================================*/
INSERT INTO Asistir VALUES
(2,1,'2026-08-01',95,'Aprobado'),
(2,2,'2026-08-10',90,'Aprobado'),
(3,3,'2026-08-15',88,'Aprobado');
GO

/*=========================================
    INSERTAR DATOS EN PROYECTO
=========================================*/
INSERT INTO Proyecto VALUES
(1,'Sistema Escolar',300000,'2026-01-10','2026-06-30'),
(2,'Control Inventarios',200000,'2026-03-01','2026-09-30');
GO

/*=========================================
    INSERTAR DATOS EN PARTICIPA
=========================================*/
INSERT INTO Participa VALUES
(1,1,'Lider',40,'2026-01-15'),
(2,1,'Programador',35,'2026-01-20'),
(3,2,'Analista',40,'2026-03-10');
GO

/*=========================================
    CONSULTAS
=========================================*/

-- Sucursales
SELECT * FROM Sucursal;

-- Puestos
SELECT * FROM Puesto;

-- Departamentos
SELECT * FROM Departamento;

-- Empleados
SELECT * FROM Empleado;

-- Capacitaciones
SELECT * FROM Capacitacion;

-- Asistencias
SELECT * FROM Asistir;

-- Proyectos
SELECT * FROM Proyecto;

-- Participaciones
SELECT * FROM Participa;

-- Empleados con su puesto
SELECT
E.Nombre,
P.Nombre AS Puesto
FROM Empleado E
INNER JOIN Puesto P
ON E.ClavePuesto=P.Clave;

-- Empleados con departamento
SELECT
E.Nombre,
D.Nombre AS Departamento
FROM Empleado E
INNER JOIN Departamento D
ON E.ClaveDepto=D.ClaveDepto;

-- Puestos por sucursal
SELECT
P.Nombre,
S.Nombre AS Sucursal
FROM Puesto P
INNER JOIN Sucursal S
ON P.ClaveSucursal=S.Clave;

-- Empleados en capacitación
SELECT
E.Nombre,
C.NombreCapacitacion,
A.Calificacion
FROM Asistir A
INNER JOIN Empleado E
ON A.NumEmp=E.NumEmp
INNER JOIN Capacitacion C
ON A.ClaveCapacitacion=C.ClaveCapacitacion;

-- Empleados participando en proyectos
SELECT
E.Nombre,
PR.Nombre,
PA.Rol,
PA.Horas
FROM Participa PA
INNER JOIN Empleado E
ON PA.NumEmp=E.NumEmp
INNER JOIN Proyecto PR
ON PA.ClaveProyecto=PR.Clave;