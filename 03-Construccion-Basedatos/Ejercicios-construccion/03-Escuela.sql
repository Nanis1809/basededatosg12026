USE master;
GO

IF DB_ID('escuela') IS NOT NULL
BEGIN
    ALTER DATABASE escuela SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE escuela;
END
GO

CREATE DATABASE escuela;
GO

USE escuela;
GO


/*=============================
        TABLA ALUMNO
=============================*/
CREATE TABLE alumno(

    idAlumno INT IDENTITY(1,1) PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    fecha_nac VARCHAR(10) NOT NULL,

    apellido_p VARCHAR(50) NOT NULL,

    apellido_m VARCHAR(50) NOT NULL,

    direccion VARCHAR(100) NOT NULL

);
GO


/*=============================
        TABLA MATERIA
=============================*/
CREATE TABLE materia(

    idMateria INT IDENTITY(1,1) PRIMARY KEY,

    nombre VARCHAR(50) NOT NULL,

    creditos INT NOT NULL
    CHECK(creditos > 0),

    periodo INT NOT NULL
    CHECK(periodo > 0)

);
GO


/*=============================
        TABLA INSCRIBE
=============================*/
CREATE TABLE inscribe(

    idInscribe INT IDENTITY(1,1) PRIMARY KEY,

    idAlumno INT NOT NULL,

    idMateria INT NOT NULL,

    fecha_inscripcion DATE NOT NULL,

    calificacion DECIMAL(5,2) NOT NULL
    CHECK(calificacion BETWEEN 0 AND 10),

    EX INT,

    FX INT,

    CONSTRAINT FK_inscribe_alumno
    FOREIGN KEY(idAlumno)
    REFERENCES alumno(idAlumno),

    CONSTRAINT FK_inscribe_materia
    FOREIGN KEY(idMateria)
    REFERENCES materia(idMateria)

);
GO


/*=============================
      DATOS DE EJEMPLO
=============================*/

INSERT INTO alumno(nombre,fecha_nac,apellido_p,apellido_m,direccion)
VALUES
('Juan','2005-02-10','Perez','Lopez','Av. Hidalgo 120'),
('Maria','2004-08-15','Garcia','Hernandez','Calle Juarez 45'),
('Luis','2005-11-20','Martinez','Sanchez','Av. Reforma 89');
GO

INSERT INTO materia(nombre,creditos,periodo)
VALUES
('Matematicas',8,1),
('Programacion',10,2),
('Base de Datos',9,3);
GO

INSERT INTO inscribe(idAlumno,idMateria,fecha_inscripcion,calificacion,EX,FX)
VALUES
(1,1,'2026-08-01',9.5,0,0),
(1,2,'2026-08-01',8.8,0,0),
(2,2,'2026-08-01',9.2,0,0),
(3,3,'2026-08-01',8.5,0,0);
GO


/*=============================
        CONSULTAS
=============================*/

SELECT * FROM alumno;
GO

SELECT * FROM materia;
GO

SELECT * FROM inscribe;
GO


/*=============================
 ALUMNO - MATERIA - INSCRIBE
=============================*/

SELECT
    A.idAlumno,
    A.nombre AS Alumno,
    M.idMateria,
    M.nombre AS Materia,
    I.fecha_inscripcion,
    I.calificacion,
    I.EX,
    I.FX
FROM inscribe I
INNER JOIN alumno A
ON I.idAlumno = A.idAlumno
INNER JOIN materia M
ON I.idMateria = M.idMateria;
GO