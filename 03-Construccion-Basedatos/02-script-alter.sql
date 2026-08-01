-- Alter Table

-- Agregar una columna 
use pruebaatributos;
Go

SELECT *
FROM alumno;

TRUNCATE TABLE alumno;

-- Agregar una columna 
ALTER TABLE alumno
ADD telefono VARCHAR(20) NOT NULL

-- Muestra los datos de una tabla 
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARATER_MAXIMUM_LENGTH,
    IS_NULLABLE

FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Alumno';

-- Agrega columna
ALTER TABLE alumno 
ADD telefono VARCHAR(20) NOT NULL;
GO

-- Agregar mas de una columna
ALTER TABLE alumno
ADD
curp VARCHAR (18);
matricula VARCHAR (13) NOT NULL;

-- Modificar un tipo de dato 
ALTER TABLE alumno 
ALTER COLUMN telefono VARCHAR (30);
GO

-- Modifcar y agregar restricciones 
-- PRIMARY KEY 

-- Este codigo crear una tabla con 0 registros apartir de otra 

SELECT TOP 0 *
INTO alumno2
FROM alumno;

SELECT
    o.name AS nombre_restriccion,
    o.type_desc AS tipo_restriccion
FROM sys.objects AS o 
WHERE o.parent_object_id = OBJECT_ID('Alumno2')
AND o.type IN ('PK','F','UQ','C','D')
ORDER BY o.type_desc;

-- Muestra los datos de una tabla 
SELECT 
    COLUMN_NAME,
    DATA_TYPE,
    CHARATER_MAXIMUM_LENGTH,
    IS_NULLABLE


FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME = 'Alumno2';

-- Primary key
ALTER TABLE alumno2
ADD CONSTRAINT pk_alumno2
PRIMARY KEY (num_alumno)

-- Crear tabla para la foreign key 
CREATE TABLE carrera (
    carrera_id INT NOT NULL IDENTITY (1,1)
    CONSTRAINT pk_carrera
    PRIMARY KEY,
    nombre VARCHAR(25)NOT NULL
);

ALTER TABLE alumno2
ADD carrera_id INT;

ALTER TABLE alumno2
ADD CONSTRAINT fk_alumno2_carrera
FOREIGN KEY (carrera_id)
REFERENCES carrera (carrera_id)
ON DELETE CASCADE
ON UPDATE NO ACTION;

-- Agregar un check 
ALTER TABLE alumno2
ADD CONSTRAINT ck_alumno2_telefono 
CHECK (telefono LIKE

-- Agrega default 
ALTER TABLE alumno2 
ADD activo BIT NOT NULL;

ALTER TABLE alumno2
ADD CONSTRAINT df_alumno2_activo
DEFAULT 1
FOR activo;

-- UNIQUE 
ALTER TABLE alumno2
ADD CONSTRAINT uq_alumno2_matricula
UNIQUE (matricula);

--Eliminar restricciones
SELECT
    o.name AS nombre_restriccion,
    o.type_desc AS tipo_restriccion
FROM sys.objects AS o 
WHERE o.parent_object_id = OBJECT_ID('Alumno2')
AND o.type IN ('PK','F','UQ','C','D')
ORDER BY o.type_desc;
-- Eliminar foregn key
ALTER TABLE alumno2
DROP CONSTRAINT fk_alumno2_carrera;

-- Eliminar primary key 
ALTER TABLE alumno2
DROP CONSTRAINT pk_alumno2;

ALTER TABLE carrera
DROP CONSTRAINT pk_carrera;

-- Eliminar los UNIQUE
ALTER TABLE alumno2
DROP CONSTRAINT uq_alumno2_matricula;

--Eliminar checks
ALTER TABLE alumno2 
DROP CONSTRAINT ck_alumno2_telefono;

-- Eliminar columna 
Alter table alumno2
Drop column matricula;

