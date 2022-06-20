-- 1633590409-CheckSP.sql

-- Autor: Olimpo Bonilla Ramírez.
-- Objetivo: Validar el funcionamiento de los objetos creados en Base de Datos.
-- Fecha: 2021-10-07.
-- Comentarios: Ejecutar aquí para cuestiones de pruebas todo lo que se ha implementado en la Base de Datos.

exec sp_refreshview @viewname =  'dbo.vw_articles';

-- 1633590409-CheckSP.sql