/*==============================================================================

DQL (DATA QUERY LANGUAGE) es un subconjunto de SQL que se utiliza para consultar y recuperar datos de una base de datos.
 de DML (DATA MANIPULATION LANGUAGE), que se centra en la manipulación de datos, DQL se enfoca en la recuperación de información.
 Archivo: 01-create-database.sql 
 Descripcion: Crear la base de datos para la practica de las consultas
===============================================================================*/

USE master;
GO 

IF DB_ID('comercial_db') IS NOT NULL
BEGIN
    ALTER DATABASE comercial_db
    SET SINGLE_USER
    WITH ROLLBACK IMMEDIATE;

    DROP DATABASE comercial_db;
END;
GO

CREATE DATABASE comercial_db;
GO 

USE comercial_db;
GO

PRINT 'La base de datos comercial_db se creo correctamente'

-- SELECT DB_ID('comercial_db')