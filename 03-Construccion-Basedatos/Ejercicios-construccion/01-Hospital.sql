/*=========================================
  CREAR BASE DE DATOS
=========================================*/
CREATE DATABASE Hospital;
GO

USE Hospital;
GO

/*=========================================
  CREAR TABLA PACIENTE
=========================================*/
CREATE TABLE Paciente(
    IdPaciente INT IDENTITY(1,1) PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50) NOT NULL,
    Apellido2 VARCHAR(50) NOT NULL,
    FechaNaci DATE NOT NULL
);
GO

/*=========================================
  CREAR TABLA EXPEDIENTE
=========================================*/
CREATE TABLE Expediente(
    IdExp INT IDENTITY(1,1) PRIMARY KEY,
    FechadeApertura DATE NOT NULL,
    TipodeSangre VARCHAR(5) NOT NULL,
    IdPaciente INT NOT NULL UNIQUE,

    CONSTRAINT FK_Expediente_Paciente
    FOREIGN KEY (IdPaciente)
    REFERENCES Paciente(IdPaciente)
);
GO

/*=========================================
  INSERTAR PACIENTES
=========================================*/
INSERT INTO Paciente (Nombre, Apellido1, Apellido2, FechaNaci)
VALUES
('Juan','Perez','Lopez','2000-05-10'),
('Maria','Garcia','Hernandez','1998-11-25'),
('Luis','Martinez','Sanchez','2003-08-15'),
('Ana','Ramirez','Torres','2001-12-02');
GO

/*=========================================
  INSERTAR EXPEDIENTES
=========================================*/
INSERT INTO Expediente (FechadeApertura, TipodeSangre, IdPaciente)
VALUES
('2026-07-30','O+',1),
('2026-07-30','A-',2),
('2026-07-31','B+',3),
('2026-08-01','AB+',4);
GO

/*=========================================
  MOSTRAR TABLA PACIENTE
=========================================*/
SELECT * FROM Paciente;
GO

/*=========================================
  MOSTRAR TABLA EXPEDIENTE
=========================================*/
SELECT * FROM Expediente;
GO

/*=========================================
  CONSULTA CON JOIN
=========================================*/
SELECT
    P.IdPaciente,
    P.Nombre,
    P.Apellido1,
    P.Apellido2,
    P.FechaNaci,
    E.IdExp,
    E.FechadeApertura,
    E.TipodeSangre
FROM Paciente AS P
INNER JOIN Expediente AS E
ON P.IdPaciente = E.IdPaciente;
GO