-- 1633584323-CreateSchema.sql

-- Autor: Olimpo Bonilla Ramírez.
-- Objetivo: Creación de un esquema de Base de Datos para objetos de Base de Datos, si no existen previamente.
-- Fecha: 2021-10-07.
-- Comentarios: Aquí se pueden crear en esta fase, los esquemas de Base de Datos con permisos sobre los objetos de Base de Datos.

IF NOT EXISTS ( SELECT * FROM sys.schemas t1 WHERE (t1.name = N'Sample') )
  EXEC('CREATE SCHEMA [Sample] AUTHORIZATION [dbo];');
GO

-- 1633584323-CreateSchema.sql