/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 06_generate_sales.sql
    Descripcion:
    Generacion de 50,000 ventas ficticias.
*/

USE NovaMarketDB;
GO


/* =========================================================
   GENERACION DE 50,000 VENTAS
   ========================================================= */

IF NOT EXISTS (SELECT 1 FROM ventas)
BEGIN

    ;WITH Numeros AS
    (
        SELECT TOP (50000)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    ),
    ClientesNumerados AS
    (
        SELECT
            cliente_id,
            ROW_NUMBER() OVER (ORDER BY cliente_id) AS numero
        FROM clientes
    ),
    ProductosNumerados AS
    (
        SELECT
            producto_id,
            precio,
            ROW_NUMBER() OVER (ORDER BY producto_id) AS numero
        FROM productos
    )

    INSERT INTO ventas
    (
        fecha_id,
        cliente_id,
        producto_id,
        cantidad,
        precio_unitario,
        descuento,
        canal
    )

    SELECT

        /* =================================================
           FECHA
           ================================================= */

        CONVERT(
            INT,
            FORMAT(
                DATEADD(
                    DAY,
                    (n.n - 1) % 1096,
                    CAST('2024-01-01' AS DATE)
                ),
                'yyyyMMdd'
            )
        ),

        /* =================================================
           CLIENTE
           Utilizamos IDs que realmente existen.
           ================================================= */

        c.cliente_id,

        /* =================================================
           PRODUCTO
           ================================================= */

        p.producto_id,

        /* =================================================
           CANTIDAD
           ================================================= */

        CASE
            WHEN n.n % 20 = 0 THEN 5
            WHEN n.n % 10 = 0 THEN 4
            WHEN n.n % 5 = 0 THEN 3
            WHEN n.n % 2 = 0 THEN 2
            ELSE 1
        END,

        /* =================================================
           PRECIO UNITARIO
           ================================================= */

        p.precio,

        /* =================================================
           DESCUENTO
           ================================================= */

        CASE
            WHEN n.n % 20 = 0 THEN 150.00
            WHEN n.n % 10 = 0 THEN 100.00
            WHEN n.n % 5 = 0 THEN 50.00
            WHEN n.n % 3 = 0 THEN 25.00
            ELSE 0.00
        END,

        /* =================================================
           CANAL
           ================================================= */

        CASE
            WHEN n.n % 10 < 5 THEN 'Web'
            WHEN n.n % 10 < 8 THEN 'Tienda Fisica'
            ELSE 'Marketplace'
        END

    FROM Numeros n

    INNER JOIN ClientesNumerados c
        ON c.numero = ((n.n - 1) % 5000) + 1

    INNER JOIN ProductosNumerados p
        ON p.numero = ((n.n * 7 - 1) % 24) + 1;

END;
GO
