USE master;
GO

IF DB_ID('universidad') IS NOT NULL
BEGIN
    ALTER DATABASE universidad SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE universidad;
END
GO

CREATE DATABASE universidad;
GO

USE universidad;
GO


/*=============================
        TABLA ALUMNO
=============================*/
CREATE TABLE alumno(

    Matricula INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    AP1 VARCHAR(50) NOT NULL,

    AP2 VARCHAR(50) NOT NULL,

    Correo VARCHAR(100),

    Telefono VARCHAR(15)

);
GO


/*=============================
      TABLA CREDENCIAL
=============================*/
CREATE TABLE credencial(

    Numeracion INT IDENTITY(1,1) PRIMARY KEY,

    FechaSuscripcion DATE NOT NULL,

    Vigencia DATE NOT NULL,

    Matricula INT NOT NULL UNIQUE,

    CONSTRAINT FK_credencial_alumno
    FOREIGN KEY(Matricula)
    REFERENCES alumno(Matricula)

);
GO


/*=============================
      TABLA PROFESOR
=============================*/
CREATE TABLE profesor(

    IdProfesor INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    AP1 VARCHAR(50) NOT NULL,

    AP2 VARCHAR(50) NOT NULL

);
GO


/*=============================
       TABLA MATERIA
=============================*/
CREATE TABLE materia(

    ClaveMateria INT IDENTITY(1,1) PRIMARY KEY,

    NombreMateria VARCHAR(60) NOT NULL,

    Creditos INT NOT NULL
    CHECK(Creditos>0),

    IdProfesor INT NOT NULL,

    CONSTRAINT FK_materia_profesor
    FOREIGN KEY(IdProfesor)
    REFERENCES profesor(IdProfesor)

);
GO


/*=============================
        TABLA CURSA
=============================*/
CREATE TABLE cursa(

    Matricula INT NOT NULL,

    ClaveMateria INT NOT NULL,

    FechaInscripcion DATE NOT NULL,

    Calificacion DECIMAL(5,2),

    CONSTRAINT PK_cursa
    PRIMARY KEY(Matricula,ClaveMateria),

    CONSTRAINT FK_cursa_alumno
    FOREIGN KEY(Matricula)
    REFERENCES alumno(Matricula),

    CONSTRAINT FK_cursa_materia
    FOREIGN KEY(ClaveMateria)
    REFERENCES materia(ClaveMateria)

);
GO
/*=============================
     TABLA DEPARTAMENTO
=============================*/
CREATE TABLE departamento(

    NumeroDepto INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    Genero VARCHAR(30),

    IdProfesor INT NOT NULL,

    CONSTRAINT FK_departamento_profesor
    FOREIGN KEY(IdProfesor)
    REFERENCES profesor(IdProfesor)

);
GO


/*=============================
      TABLA DEPENDIENTE
=============================*/
CREATE TABLE dependiente(

    IdDependiente INT IDENTITY(1,1) PRIMARY KEY,

    Nombre VARCHAR(50) NOT NULL,

    Parentesco VARCHAR(30) NOT NULL,

    FechaNac DATE NOT NULL,

    IdProfesor INT NOT NULL,

    CONSTRAINT FK_dependiente_profesor
    FOREIGN KEY(IdProfesor)
    REFERENCES profesor(IdProfesor)

);
GO


/*=============================
       TABLA PROYECTO
=============================*/
CREATE TABLE proyecto(

    NumProy INT IDENTITY(1,1) PRIMARY KEY,

    NombreProy VARCHAR(60) NOT NULL,

    Presupuesto DECIMAL(12,2) NOT NULL
    CHECK(Presupuesto > 0)

);
GO


/*=============================
      TABLA PARTICIPA
=============================*/
CREATE TABLE participa(

    IdProfesor INT NOT NULL,

    NumProy INT NOT NULL,

    Rol VARCHAR(40) NOT NULL,

    FechaInicio DATE NOT NULL,

    CONSTRAINT PK_participa
    PRIMARY KEY(IdProfesor,NumProy),

    CONSTRAINT FK_participa_profesor
    FOREIGN KEY(IdProfesor)
    REFERENCES profesor(IdProfesor),

    CONSTRAINT FK_participa_proyecto
    FOREIGN KEY(NumProy)
    REFERENCES proyecto(NumProy)

);
GO


/*=============================
      DATOS DE EJEMPLO
=============================*/

INSERT INTO alumno(Nombre,AP1,AP2,Correo,Telefono)
VALUES
('Juan','Perez','Lopez','juan@gmail.com','7711111111'),
('Maria','Garcia','Hernandez','maria@gmail.com','7722222222');
GO

INSERT INTO profesor(Nombre,AP1,AP2)
VALUES
('Carlos','Ramirez','Lopez'),
('Ana','Martinez','Perez');
GO

INSERT INTO credencial(FechaSuscripcion,Vigencia,Matricula)
VALUES
('2026-01-10','2027-01-10',1),
('2026-01-10','2027-01-10',2);
GO

INSERT INTO materia(NombreMateria,Creditos,IdProfesor)
VALUES
('Base de Datos',8,1),
('Programacion',10,2);
GO

INSERT INTO cursa(Matricula,ClaveMateria,FechaInscripcion,Calificacion)
VALUES
(1,1,'2026-08-01',9.5),
(2,2,'2026-08-01',8.8);
GO

INSERT INTO departamento(Nombre,Genero,IdProfesor)
VALUES
('Sistemas','Tecnologia',1),
('Matematicas','Ciencias',2);
GO

INSERT INTO dependiente(Nombre,Parentesco,FechaNac,IdProfesor)
VALUES
('Luis Ramirez','Hijo','2015-06-12',1),
('Sofia Martinez','Hija','2018-03-20',2);
GO

INSERT INTO proyecto(NombreProy,Presupuesto)
VALUES
('Sistema Escolar',250000),
('Control Academico',180000);
GO

INSERT INTO participa(IdProfesor,NumProy,Rol,FechaInicio)
VALUES
(1,1,'Lider','2026-02-01'),
(2,2,'Desarrollador','2026-03-15');
GO


/*=============================
        CONSULTAS
=============================*/

SELECT * FROM alumno;
GO

SELECT * FROM profesor;
GO

SELECT * FROM credencial;
GO

SELECT * FROM materia;
GO

SELECT * FROM cursa;
GO

SELECT * FROM departamento;
GO

SELECT * FROM dependiente;
GO

SELECT * FROM proyecto;
GO

SELECT * FROM participa;
GO


/*=============================
      CONSULTA GENERAL
=============================*/

SELECT
    A.Nombre AS Alumno,
    M.NombreMateria,
    C.Calificacion,
    P.Nombre AS Profesor,
    PR.NombreProy,
    PA.Rol
FROM cursa C
INNER JOIN alumno A
ON C.Matricula = A.Matricula
INNER JOIN materia M
ON C.ClaveMateria = M.ClaveMateria
INNER JOIN profesor P
ON M.IdProfesor = P.IdProfesor
LEFT JOIN participa PA
ON P.IdProfesor = PA.IdProfesor
LEFT JOIN proyecto PR
ON PA.NumProy = PR.NumProy;
GO