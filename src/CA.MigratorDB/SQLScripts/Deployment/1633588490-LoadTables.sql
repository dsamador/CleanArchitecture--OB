-- 1633588490-LoadTables.sql

-- Autor: Olimpo Bonilla Ramírez.
-- Objetivo: Carga de datos en tablas existentes de Base de Datos.
-- Fecha: 2021-10-07.
-- Comentarios: Aquí se crean los objetos de Base de Datos (Tablas, vistas, SP, etc) asignados a un esquema de Base de Datos o bien asignados al esquema por default de Base de Datos.

-- 1. Catálogo de cuentas de usuario.
-------------------------------------
INSERT INTO [dbo].[mtUsers] ([first_name], [last_name], [username], [passwordhash], [creationdate], [updatedate])
VALUES ('ADMINISTRADOR', 'DEL SISTEMA', 'root', 'root', getutcdate(), null),
       ('INVITADO', 'DEL SISTEMA', 'userguest', 'userguest', getutcdate(), null);

-- 2. Catálogo de tipos de productos.
-------------------------------------
INSERT INTO [dbo].[mtProductTypes] ([description], [account_id], [creationdate], [updatedate])
VALUES ('BOTANAS', 1, getutcdate(), null),
       ('BEBIDAS NO ALCOHOLICAS', 1, getutcdate(), null),
       ('BEBIDAS ALCOHOLICAS', 1, getutcdate(), null);

-- 3. Catálogo de tiendas.
--------------------------
INSERT INTO [dbo].[mtStores] ([name], [address], [account_id], [creationdate], [updatedate])
VALUES ('Sucursal CDMX', 'Av. Siempreviva 101.', 1, getutcdate(), null),
       ('Sucursal Guadalajara', 'Av. Siempreviva 102.', 1, getutcdate(), null),
       ('Sucursal Monterrey', 'Av. Siempreviva 103.', 1, getutcdate(), null);

-- 2. Catálogo de artículos.
----------------------------
INSERT INTO [dbo].[mtArticles] ([name], [description], [price], [total_in_shelf], [total_in_vault], [producttype_id], [store_id],  [account_id], [creationdate], [updatedate])
VALUES ('Bolsa de churros Neto', 'Bolsa de churros 100 grs', 25.50, 1000, 5000, 1, 1, 1, getutcdate(), null),
       ('Paquetaxo Morado Grande', 'Paquetaxo picoso ultrahot', 45.50, 1000, 5000, 1, 1, 1, getutcdate(), null),
       ('Paquetaxo Azul Grande', 'Paquetaxo sabor queso', 45.50, 1000, 5000, 1, 2, 1, getutcdate(), null),
       ('Paquetaxo Amarillo Grande', 'Paquetaxo botanero normal.', 45.50, 1000, 5000, 1, 3, 1, getutcdate(), null),
       ('Paquetaxo Verde Grande', 'Paquetaxo botanero extremo', 45.50, 1000, 5000, 1, 1, 1, getutcdate(), null),
       ('Cerveza Corona Chica', 'Cerveza 350 ml', 22.50, 1000, 5000, 3, 1, 1, getutcdate(), null),
       ('Cerveza Indio Chica', 'Cerveza 350 ml', 22.50, 1000, 5000, 3, 1, 1, getutcdate(), null),
       ('Cerveza Victoria Chica', 'Cerveza 350 ml', 22.50, 1000, 5000, 3, 2, 1, getutcdate(), null),
       ('Cerveza Victoria Chica', 'Cerveza 350 ml', 22.50, 1000, 5000, 3, 3, 1, getutcdate(), null),
       ('Cerveza Corona Grande', 'Cerveza Cahuama 850 ml', 22.50, 1000, 5000, 3, 1, 1, getutcdate(), null),
       ('Coca Cola Grande', 'Coca Cola Sabor Original 3 L', 45.50, 1000, 5000, 2, 1, 1, getutcdate(), null);


-- 1633588490-LoadTables.sql