/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 05_generate_clients.sql
    Descripcion:
    Generacion de 5,000 clientes ficticios.
*/

USE NovaMarketDB;
GO

/* =========================================================
   GENERACION DE CLIENTES
   ========================================================= */

IF NOT EXISTS (SELECT 1 FROM clientes)
BEGIN

    ;WITH Numeros AS
    (
        SELECT TOP (5000)
            ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
        FROM sys.all_objects a
        CROSS JOIN sys.all_objects b
    )

    INSERT INTO clientes
    (
        nombre,
        apellido,
        genero,
        fecha_nacimiento,
        ciudad,
        segmento,
        fecha_registro
    )
    SELECT

        /* Nombre */
        CASE ((n - 1) % 20)
            WHEN 0 THEN 'Carlos'
            WHEN 1 THEN 'Andrea'
            WHEN 2 THEN 'Luis'
            WHEN 3 THEN 'Maria'
            WHEN 4 THEN 'Jose'
            WHEN 5 THEN 'Daniel'
            WHEN 6 THEN 'Sofia'
            WHEN 7 THEN 'Miguel'
            WHEN 8 THEN 'Valeria'
            WHEN 9 THEN 'Jorge'
            WHEN 10 THEN 'Lucia'
            WHEN 11 THEN 'Fernando'
            WHEN 12 THEN 'Camila'
            WHEN 13 THEN 'Diego'
            WHEN 14 THEN 'Paola'
            WHEN 15 THEN 'Ricardo'
            WHEN 16 THEN 'Gabriela'
            WHEN 17 THEN 'Alejandro'
            WHEN 18 THEN 'Natalia'
            WHEN 19 THEN 'Martin'
        END,

        /* Apellido */
        CASE ((n - 1) % 20)
            WHEN 0 THEN 'Garcia'
            WHEN 1 THEN 'Torres'
            WHEN 2 THEN 'Mendoza'
            WHEN 3 THEN 'Flores'
            WHEN 4 THEN 'Ramirez'
            WHEN 5 THEN 'Castillo'
            WHEN 6 THEN 'Vargas'
            WHEN 7 THEN 'Rojas'
            WHEN 8 THEN 'Quispe'
            WHEN 9 THEN 'Sanchez'
            WHEN 10 THEN 'Fernandez'
            WHEN 11 THEN 'Gonzales'
            WHEN 12 THEN 'Diaz'
            WHEN 13 THEN 'Morales'
            WHEN 14 THEN 'Paredes'
            WHEN 15 THEN 'Vega'
            WHEN 16 THEN 'Herrera'
            WHEN 17 THEN 'Cruz'
            WHEN 18 THEN 'Navarro'
            WHEN 19 THEN 'Medina'
        END,

        /* Genero */
        CASE
            WHEN n % 2 = 0 THEN 'Masculino'
            ELSE 'Femenino'
        END,

        /* Fecha de nacimiento */
        DATEADD(
            DAY,
            -(6570 + ((n - 1) % 14600)),
            CAST('2025-12-31' AS DATE)
        ),

        /* Ciudad */
        CASE ((n - 1) % 6)
            WHEN 0 THEN 'Lima'
            WHEN 1 THEN 'Arequipa'
            WHEN 2 THEN 'Trujillo'
            WHEN 3 THEN 'Cusco'
            WHEN 4 THEN 'Piura'
            WHEN 5 THEN 'Chiclayo'
        END,

        /* Segmento */
        CASE
            WHEN ((n - 1) % 10) < 2 THEN 'Premium'
            WHEN ((n - 1) % 10) < 7 THEN 'Regular'
            ELSE 'Basico'
        END,

        /* Fecha de registro */
        DATEADD(
            DAY,
            ((n - 1) % 1096),
            CAST('2024-01-01' AS DATE)
        )

    FROM Numeros;

END;
GO