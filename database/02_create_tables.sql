/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 02_create_tables.sql
    Descripción:
    Creación de las tablas principales del modelo de datos.
*/

USE NovaMarketDB;
GO

/* =========================================================
   1. TABLA: clientes
   ========================================================= */

IF OBJECT_ID('dbo.clientes', 'U') IS NULL
BEGIN
    CREATE TABLE clientes (
        cliente_id INT IDENTITY(1,1) PRIMARY KEY,
        nombre VARCHAR(50) NOT NULL,
        apellido VARCHAR(50) NOT NULL,
        genero VARCHAR(20) NULL,
        fecha_nacimiento DATE NULL,
        ciudad VARCHAR(50) NOT NULL,
        segmento VARCHAR(20) NOT NULL,
        fecha_registro DATE NOT NULL,

        CONSTRAINT CK_clientes_segmento
            CHECK (segmento IN ('Premium', 'Regular', 'Basico'))
    );
END;
GO


/* =========================================================
   2. TABLA: categorias
   ========================================================= */

IF OBJECT_ID('dbo.categorias', 'U') IS NULL
BEGIN
    CREATE TABLE categorias (
        categoria_id INT IDENTITY(1,1) PRIMARY KEY,
        categoria VARCHAR(50) NOT NULL UNIQUE,
        descripcion VARCHAR(200) NULL
    );
END;
GO


/* =========================================================
   3. TABLA: productos
   ========================================================= */

IF OBJECT_ID('dbo.productos', 'U') IS NULL
BEGIN
    CREATE TABLE productos (
        producto_id INT IDENTITY(1,1) PRIMARY KEY,
        categoria_id INT NOT NULL,
        producto VARCHAR(100) NOT NULL,
        marca VARCHAR(50) NOT NULL,
        precio DECIMAL(10,2) NOT NULL,
        costo DECIMAL(10,2) NOT NULL,
        stock INT NOT NULL,
        estado VARCHAR(20) NOT NULL,

        CONSTRAINT FK_productos_categorias
            FOREIGN KEY (categoria_id)
            REFERENCES categorias(categoria_id),

        CONSTRAINT CK_productos_precio
            CHECK (precio > 0),

        CONSTRAINT CK_productos_costo
            CHECK (costo >= 0),

        CONSTRAINT CK_productos_stock
            CHECK (stock >= 0),

        CONSTRAINT CK_productos_estado
            CHECK (estado IN ('Activo', 'Inactivo'))
    );
END;
GO


/* =========================================================
   4. TABLA: fechas
   ========================================================= */

IF OBJECT_ID('dbo.fechas', 'U') IS NULL
BEGIN
    CREATE TABLE fechas (
        fecha_id INT PRIMARY KEY,
        fecha DATE NOT NULL UNIQUE,
        anio INT NOT NULL,
        trimestre INT NOT NULL,
        mes INT NOT NULL,
        nombre_mes VARCHAR(20) NOT NULL,
        semana INT NOT NULL,
        dia INT NOT NULL,
        nombre_dia VARCHAR(20) NOT NULL,

        CONSTRAINT CK_fechas_trimestre
            CHECK (trimestre BETWEEN 1 AND 4),

        CONSTRAINT CK_fechas_mes
            CHECK (mes BETWEEN 1 AND 12),

        CONSTRAINT CK_fechas_dia
            CHECK (dia BETWEEN 1 AND 31)
    );
END;
GO


/* =========================================================
   5. TABLA: ventas
   ========================================================= */

IF OBJECT_ID('dbo.ventas', 'U') IS NULL
BEGIN
    CREATE TABLE ventas (
        venta_id INT IDENTITY(1,1) PRIMARY KEY,
        fecha_id INT NOT NULL,
        cliente_id INT NOT NULL,
        producto_id INT NOT NULL,
        cantidad INT NOT NULL,
        precio_unitario DECIMAL(10,2) NOT NULL,
        descuento DECIMAL(10,2) NOT NULL DEFAULT 0,
        canal VARCHAR(30) NOT NULL,

        CONSTRAINT FK_ventas_fechas
            FOREIGN KEY (fecha_id)
            REFERENCES fechas(fecha_id),

        CONSTRAINT FK_ventas_clientes
            FOREIGN KEY (cliente_id)
            REFERENCES clientes(cliente_id),

        CONSTRAINT FK_ventas_productos
            FOREIGN KEY (producto_id)
            REFERENCES productos(producto_id),

        CONSTRAINT CK_ventas_cantidad
            CHECK (cantidad > 0),

        CONSTRAINT CK_ventas_precio
            CHECK (precio_unitario > 0),

        CONSTRAINT CK_ventas_descuento
            CHECK (descuento >= 0),

        CONSTRAINT CK_ventas_canal
            CHECK (canal IN ('Web', 'Tienda Fisica', 'Marketplace'))
    );
END;
GO

