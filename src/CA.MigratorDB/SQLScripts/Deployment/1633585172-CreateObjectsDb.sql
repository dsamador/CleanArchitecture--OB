-- 1633585172-CreateObjectsDb.sql

-- Autor: Olimpo Bonilla Ramírez.
-- Objetivo: Creación de las tablas de Base de Datos.
-- Fecha: 2021-10-07.
-- Comentarios: Aquí se crean los objetos de Base de Datos (Tablas, vistas, SP, etc) asignados a un esquema de Base de Datos o bien asignados al esquema por default de Base de Datos.

-- 1. Catálogo de cuentas de usuario.
-------------------------------------
IF OBJECT_ID('dbo.mtUsers') IS NOT NULL
BEGIN
  DROP TABLE IF EXISTS dbo.mtArticles; DROP TABLE IF EXISTS dbo.mtProductTypes; DROP TABLE IF EXISTS dbo.mtStores; DROP TABLE IF EXISTS dbo.mtUsers; 

  IF OBJECT_ID('dbo.mtUsers') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.mtUsers''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.mtUsers'' se ha eliminado correctamente. >>>';
END;

CREATE TABLE dbo.mtUsers
(
  [account_id]     [int]                        IDENTITY(1, 1) NOT NULL,
  [first_name]     [varchar]       (255)        NOT NULL,
  [last_name]      [varchar]       (255)        NOT NULL,
  [username]       [varchar]       (255)        NOT NULL,
  [passwordhash]   [varchar]       (255)        NOT NULL,
  [creationdate]   [datetime]                   NOT NULL DEFAULT GETUTCDATE(),
  [updatedate]     [datetime]                   NULL,
  CONSTRAINT       [pk_IdUser]                  PRIMARY KEY (account_id),
  CONSTRAINT       [uq_IdUser]                  UNIQUE (account_id)
);
GO

IF OBJECT_ID('dbo.mtUsers') IS NOT NULL
  PRINT '<<< El objeto ''dbo.mtUsers'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.mtUsers''. >>>';

-- 2. Catálogo de tipos de productos.
-------------------------------------
IF OBJECT_ID('dbo.mtProductTypes') IS NOT NULL
BEGIN
  DROP TABLE IF EXISTS dbo.mtArticles; DROP TABLE IF EXISTS dbo.mtProductTypes;

  IF OBJECT_ID('dbo.mtProductTypes') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.mtProductTypes''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.mtProductTypes'' se ha eliminado correctamente. >>>';
END;

CREATE TABLE dbo.mtProductTypes
(
  [producttype_id] [int]                        IDENTITY(1, 1) NOT NULL,
  [description]    [varchar]       (255)        NOT NULL,
  [account_id]     [int]                        NOT NULL,
  [creationdate]   [datetime]                   NOT NULL DEFAULT GETUTCDATE(),
  [updatedate]     [datetime]                   NULL,
  CONSTRAINT       [pk_IdProductType]           PRIMARY KEY (producttype_id),
  CONSTRAINT       [uq_IdProductType]           UNIQUE(producttype_id, account_id),
  CONSTRAINT       [fk_IdProductType]           FOREIGN KEY(account_id) REFERENCES mtUsers(account_id)
);
GO

IF OBJECT_ID('dbo.mtProductTypes') IS NOT NULL
  PRINT '<<< El objeto ''dbo.mtProductTypes'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.mtProductTypes''. >>>';

-- 3. Catálogo de tiendas o sucursales.
---------------------------------------
IF OBJECT_ID('dbo.mtStores') IS NOT NULL
BEGIN
  DROP TABLE IF EXISTS dbo.mtArticles; DROP TABLE IF EXISTS dbo.mtStores;

  IF OBJECT_ID('dbo.mtStores') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.mtStores''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.mtStores'' se ha eliminado correctamente. >>>';
END;

CREATE TABLE dbo.mtStores
(
  [store_id]       [int]                        IDENTITY(1, 1) NOT NULL,
  [name]           [varchar]       (255)        NOT NULL,
  [address]        [varchar]       (255)        NOT NULL DEFAULT 0,
  [account_id]     [int]                        NOT NULL,
  [creationdate]   [datetime]                   NOT NULL DEFAULT GETUTCDATE(),
  [updatedate]     [datetime]                   NULL,
  CONSTRAINT       [pk_IdStore]                 PRIMARY KEY (store_id),
  CONSTRAINT       [uq_IdStore]                 UNIQUE(store_id, account_id),
  CONSTRAINT       [fk_IdStore]                 FOREIGN KEY(account_id) REFERENCES mtUsers(account_id)
);
GO

IF OBJECT_ID('dbo.mtStores') IS NOT NULL
  PRINT '<<< El objeto ''dbo.mtStores'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.mtStores''. >>>';

-- 4. Catálogo de artículos.
----------------------------
IF OBJECT_ID('dbo.mtArticles') IS NOT NULL
BEGIN
  DROP TABLE dbo.mtArticles;

  IF OBJECT_ID('dbo.mtArticles') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.mtArticles''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.mtArticles'' se ha eliminado correctamente. >>>';
END;

CREATE TABLE dbo.mtArticles
(
  [sku_id]         [int]                        IDENTITY(1, 1) NOT NULL,
  [name]           [varchar]       (255)        NOT NULL,
  [description]    [varchar]       (255)        NOT NULL DEFAULT 0,
  [price]          [money]                      NOT NULL,
  [total_in_shelf] [int]                        NOT NULL DEFAULT 0,
  [total_in_vault] [int]                        NOT NULL DEFAULT 0,
	[producttype_id] [int]                        NOT NULL,
  [store_id]       [int]                        NOT NULL,
  [account_id]     [int]                        NOT NULL,
  [creationdate]   [datetime]                   NOT NULL DEFAULT GETUTCDATE(),
  [updatedate]     [datetime]                   NULL,
  CONSTRAINT       [pk_Idarticle]               PRIMARY KEY (sku_id),
  CONSTRAINT       [uq_Idarticle]               UNIQUE (sku_id, store_id),
  CONSTRAINT       [fk_Idarticle1]              FOREIGN KEY(account_id) REFERENCES mtUsers(account_id),
	CONSTRAINT       [fk_Idarticle2]              FOREIGN KEY(store_id) REFERENCES mtStores(store_id),
	CONSTRAINT       [fk_Idarticle3]              FOREIGN KEY(producttype_id) REFERENCES mtProductTypes(producttype_id)
);
GO

IF OBJECT_ID('dbo.mtArticles') IS NOT NULL
  PRINT '<<< El objeto ''dbo.mtArticles'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.mtArticles''. >>>';

-- 3. Inventario de artículos.
------------------------------
IF OBJECT_ID('dbo.vw_articles') IS NOT NULL
BEGIN
  DROP VIEW dbo.vw_articles;

  IF OBJECT_ID('dbo.vw_articles') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.vw_articles''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.vw_articles'' se ha eliminado correctamente. >>>';
END;
GO

CREATE VIEW dbo.vw_articles AS
  SELECT t1.sku_id, t1.[description], t1.[name],
         t1.price, t1.total_in_shelf, t1.total_in_vault,
         t2.[name] [store_name], t3.[description] [product_type_name]
    FROM dbo.mtArticles t1
   INNER JOIN dbo.mtStores t2 ON (t2.store_id = t1.store_id)
	 INNER JOIN dbo.mtProductTypes t3 ON (t3.producttype_id = t1.producttype_id);
GO

IF OBJECT_ID('dbo.vw_articles') IS NOT NULL
  PRINT '<<< El objeto ''dbo.vw_articles'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.vw_articles''. >>>';

-- 4. Store Procedure de artículos por sucursal.
------------------------------------------------
IF OBJECT_ID('dbo.procArticlesGet') IS NOT NULL
BEGIN
  DROP PROCEDURE dbo.procArticlesGet;

  IF OBJECT_ID('dbo.procArticlesGet') IS NOT NULL
    PRINT '<<< Ocurrió un error al eliminar el objeto ''dbo.procArticlesGet''. >>>';
  ELSE
    PRINT '<<< El objeto ''dbo.procArticlesGet'' se ha eliminado correctamente. >>>';
END;
GO

CREATE PROCEDURE dbo.procArticlesGet (@StoreId INT) AS
  SELECT t1.sku_id, t1.[description], t1.[name],
         t1.price, t1.total_in_shelf, t1.total_in_vault,
         t2.[name] [store_name], t3.[description] [product_type_name]
    FROM dbo.mtArticles t1
   INNER JOIN dbo.mtStores t2 ON (t2.store_id = t1.store_id)
	 INNER JOIN dbo.mtProductTypes t3 ON (t3.producttype_id = t1.producttype_id)
   WHERE (t1.store_id = @StoreId);
GO

IF OBJECT_ID('dbo.procArticlesGet') IS NOT NULL
  PRINT '<<< El objeto ''dbo.procArticlesGet'' se ha creado correctamente. >>>';
ELSE
  PRINT '<<< Ocurrió un error al crear el objeto ''dbo.procArticlesGet''. >>>';

-- 1633585172-CreateObjectsDb.sql