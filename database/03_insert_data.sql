/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 03_insert_data.sql
    Descripción:
    Inserción de datos maestros iniciales.
*/

USE NovaMarketDB;
GO


/* =========================================================
   1. CATEGORIAS
   ========================================================= */

IF NOT EXISTS (SELECT 1 FROM categorias)
BEGIN
    INSERT INTO categorias (categoria, descripcion)
    VALUES
        ('Laptops', 'Computadoras portatiles y equipos de trabajo'),
        ('Smartphones', 'Telefonos inteligentes'),
        ('Monitores', 'Monitores para trabajo, gaming y entretenimiento'),
        ('Perifericos', 'Teclados, mouse y otros perifericos'),
        ('Componentes', 'Componentes internos para computadoras'),
        ('Accesorios', 'Accesorios tecnologicos');
END;
GO


/* =========================================================
   2. PRODUCTOS
   ========================================================= */

IF NOT EXISTS (SELECT 1 FROM productos)
BEGIN
    INSERT INTO productos
        (categoria_id, producto, marca, precio, costo, stock, estado)
    VALUES

        /* Laptops */
        (1, 'IdeaPad 5', 'Lenovo', 2899.90, 2250.00, 35, 'Activo'),
        (1, 'Aspire 5', 'Acer', 2499.90, 1950.00, 28, 'Activo'),
        (1, 'VivoBook 15', 'ASUS', 2699.90, 2100.00, 42, 'Activo'),
        (1, 'Inspiron 15', 'Dell', 3199.90, 2500.00, 20, 'Activo'),

        /* Smartphones */
        (2, 'Galaxy A55', 'Samsung', 1699.90, 1320.00, 50, 'Activo'),
        (2, 'iPhone 15', 'Apple', 3299.90, 2700.00, 25, 'Activo'),
        (2, 'Redmi Note 13', 'Xiaomi', 999.90, 760.00, 65, 'Activo'),
        (2, 'Moto G84', 'Motorola', 1199.90, 900.00, 40, 'Activo'),

        /* Monitores */
        (3, 'UltraGear 27', 'LG', 1399.90, 1050.00, 22, 'Activo'),
        (3, 'Odyssey G5', 'Samsung', 1599.90, 1220.00, 18, 'Activo'),
        (3, 'TUF Gaming 24', 'ASUS', 999.90, 740.00, 30, 'Activo'),
        (3, 'ProArt 27', 'ASUS', 1899.90, 1450.00, 12, 'Activo'),

        /* Perifericos */
        (4, 'MX Master 3S', 'Logitech', 399.90, 280.00, 45, 'Activo'),
        (4, 'G502 Hero', 'Logitech', 299.90, 205.00, 60, 'Activo'),
        (4, 'Kumara K552', 'Redragon', 179.90, 120.00, 70, 'Activo'),
        (4, 'BlackWidow V3', 'Razer', 549.90, 390.00, 25, 'Activo'),

        /* Componentes */
        (5, 'SSD NVMe 1TB', 'Kingston', 329.90, 240.00, 80, 'Activo'),
        (5, 'RAM DDR4 16GB', 'Corsair', 249.90, 175.00, 90, 'Activo'),
        (5, 'RTX 4060', 'NVIDIA', 1699.90, 1320.00, 15, 'Activo'),
        (5, 'Ryzen 5 7600', 'AMD', 899.90, 690.00, 20, 'Activo'),

        /* Accesorios */
        (6, 'Webcam C920', 'Logitech', 349.90, 250.00, 35, 'Activo'),
        (6, 'Hub USB-C 7 en 1', 'UGREEN', 199.90, 135.00, 55, 'Activo'),
        (6, 'Audifonos Cloud II', 'HyperX', 449.90, 320.00, 30, 'Activo'),
        (6, 'Mochila para Laptop', 'Targus', 279.90, 190.00, 40, 'Activo');
END;
GO