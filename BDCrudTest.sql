-- Crear BD
CREATE DATABASE BDCrudTest;
GO

-- Utilizar la BD
USE BDCrudTest;
GO

-- Crear la tabla de categorias
CREATE TABLE dbo.coCategoria (
    nIdCategori INT NOT NULL PRIMARY KEY,
    cNombCateg NVARCHAR(100) NOT NULL,
    cEsActiva BIT NOT NULL
);
GO

-- Crear la tabla de productos
CREATE TABLE dbo.coProducto (
    nIdProduct INT NOT NULL PRIMARY KEY,
    cNombProdu NVARCHAR(100) NOT NULL,
    nPrecioProd DECIMAL(10, 2) NOT NULL,
    nIdCategori INT NULL,
    FOREIGN KEY (nIdCategori) REFERENCES dbo.coCategoria(nIdCategori)
);
GO

-- Insertar datos en la tabla de categorias
INSERT INTO dbo.coCategoria (nIdCategori, cNombCateg, cEsActiva) VALUES
(1, N'Electronica', 1),
(2, N'Ropa', 1),
(1001, N'Zapatos', 0);
GO

-- Insertar datos en la tabla de productos
INSERT INTO dbo.coProducto (nIdProduct, cNombProdu, nPrecioProd, nIdCategori) VALUES
(1, N'Smartphone Samsung Galaxy S20', 799.99, 1),
(2, N'Laptop Dell XPS 15', 1599.99, 1),
(3, N'Smartwatch Garmin Forerunner 945', 549.00, 1),
(4, N'Camisa Polo Ralph Lauren', 89.99, 2),
(5, N'Pantalón Levi''s 501 Original Fit', 59.50, 2),
(6, N'Zapatos Nike Air Force 1', 109.95, 2);
GO

-- Procedimiento almacenado para eliminar una categoría por su ID
CREATE PROCEDURE dbo.Usp_Del_Co_Categoria
    @nIdCategori INT
AS
BEGIN
    DELETE FROM dbo.coCategoria
    WHERE nIdCategori = @nIdCategori;
END;
GO

-- Procedimiento almacenado para insertar una nueva categoría
CREATE PROCEDURE dbo.Usp_Ins_Co_Categoria
    @nIdCategori INT,
    @cNombCateg NVARCHAR(100),
    @cEsActiva BIT
AS
BEGIN
    INSERT INTO dbo.coCategoria (nIdCategori, cNombCateg, cEsActiva)
    VALUES (@nIdCategori, @cNombCateg, @cEsActiva);
END;
GO

-- Procedimiento almacenado para seleccionar todas las categorías activas
CREATE PROCEDURE dbo.Usp_Sel_Co_Categorias
AS
BEGIN
    SELECT nIdCategori, cNombCateg
    FROM dbo.coCategoria
    WHERE cEsActiva = 1;
END;
GO

-- Procedimiento almacenado para seleccionar todas las categorías
CREATE PROCEDURE dbo.Usp_Sel_Co_All_Categorias
AS
BEGIN
    SELECT nIdCategori, cNombCateg, cEsActiva
    FROM dbo.coCategoria;
END;
GO

-- Procedimiento almacenado para seleccionar una categoría por su ID
CREATE PROCEDURE dbo.Usp_Sel_Co_Id_Categoria
    @nIdCategori INT
AS
BEGIN
    SELECT nIdCategori, cNombCateg, cEsActiva
    FROM dbo.coCategoria
    WHERE nIdCategori = @nIdCategori;
END;
GO

-- Procedimiento almacenado para seleccionar productos de una categoría específica
CREATE PROCEDURE dbo.Usp_Sel_Co_Productos
    @IdCategoria INT
AS
BEGIN
    SELECT 
        p.nIdProduct,
        p.cNombProdu,
        p.nPrecioProd,
        p.nIdCategori,
        c.cNombCateg
    FROM dbo.coProducto p
    INNER JOIN dbo.coCategoria c ON p.nIdCategori = c.nIdCategori
    WHERE p.nIdCategori = @IdCategoria;
END;
GO

-- Procedimiento almacenado para actualizar una categoría por su ID
CREATE PROCEDURE dbo.Usp_Upd_Co_Categoria
    @nIdCategori INT,
    @cNombCateg NVARCHAR(100),
    @cEsActiva BIT
AS
BEGIN
    UPDATE dbo.coCategoria
    SET cNombCateg = @cNombCateg,
        cEsActiva = @cEsActiva
    WHERE nIdCategori = @nIdCategori;
END;
GO
