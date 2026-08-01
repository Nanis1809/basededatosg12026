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
        TABLA PROFESOR
=============================*/
CREATE TABLE profesor(

    idProfesor INT IDENTITY(1,1) PRIMARY KEY,

    Nombre NVARCHAR(40) NOT NULL,

    Ap1 NVARCHAR(20) NOT NULL,

    Ap2 NVARCHAR(20) NOT NULL

);
GO


/*=============================
        TABLA CURSO
=============================*/
CREATE TABLE curso(

    NumCurso INT IDENTITY(1,1) PRIMARY KEY,

    Nombre NVARCHAR(20) NOT NULL,

    Credito INT NOT NULL
    CHECK (Credito > 0),

    idProfesor INT NOT NULL,

    CONSTRAINT FK_curso_profesor
    FOREIGN KEY(idProfesor)
    REFERENCES profesor(idProfesor)

);
GO


/*=============================
      TABLA ESPECIALIDAD
=============================*/
CREATE TABLE especialidad(

    idEspecialidad INT IDENTITY(1,1) PRIMARY KEY,

    idProfesor INT NOT NULL,

    Nombre NVARCHAR(40) NOT NULL,

    CONSTRAINT FK_especialidad_profesor
    FOREIGN KEY(idProfesor)
    REFERENCES profesor(idProfesor)

);
GO


/*=============================
      DATOS DE EJEMPLO
=============================*/

INSERT INTO profesor (Nombre, Ap1, Ap2)
VALUES
('Juan','Perez','Lopez'),
('Maria','Garcia','Hernandez'),
('Luis','Martinez','Sanchez');
GO

INSERT INTO curso (Nombre, Credito, idProfesor)
VALUES
('Matematicas',8,1),
('Programacion',10,2),
('Base de Datos',9,2),
('Fisica',7,3);
GO

INSERT INTO especialidad (idProfesor, Nombre)
VALUES
(1,'Algebra'),
(1,'Calculo'),
(2,'Desarrollo de Software'),
(3,'Fisica Aplicada');
GO


/*=============================
        CONSULTAS
=============================*/

SELECT * FROM profesor;
GO

SELECT * FROM curso;
GO

SELECT * FROM especialidad;
GO

/*=============================
  PROFESOR - CURSO
=============================*/

SELECT
    P.idProfesor,
    P.Nombre,
    P.Ap1,
    P.Ap2,
    C.NumCurso,
    C.Nombre AS Curso,
    C.Credito
FROM profesor P
INNER JOIN curso C
ON P.idProfesor = C.idProfesor;
GO

/*=============================
 PROFESOR - ESPECIALIDAD
=============================*/

SELECT
    P.idProfesor,
    P.Nombre,
    E.idEspecialidad,
    E.Nombre AS Especialidad
FROM profesor P
INNER JOIN especialidad E
ON P.idProfesor = E.idProfesor;