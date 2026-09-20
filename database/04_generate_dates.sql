/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 04_generate_dates.sql
    Descripción:
    Generación de la dimensión calendario.
*/

USE NovaMarketDB;
GO


/* =========================================================
   DIMENSION DE FECHAS
   Periodo: 2024 - 2026
   ========================================================= */

DECLARE @FechaInicio DATE = '2024-01-01';
DECLARE @FechaFin DATE = '2026-12-31';

DECLARE @FechaActual DATE = @FechaInicio;

WHILE @FechaActual <= @FechaFin
BEGIN

    IF NOT EXISTS (
        SELECT 1
        FROM fechas
        WHERE fecha = @FechaActual
    )
    BEGIN

        INSERT INTO fechas (
            fecha_id,
            fecha,
            anio,
            trimestre,
            mes,
            nombre_mes,
            semana,
            dia,
            nombre_dia
        )
        VALUES (
            CONVERT(INT, FORMAT(@FechaActual, 'yyyyMMdd')),
            @FechaActual,
            YEAR(@FechaActual),
            DATEPART(QUARTER, @FechaActual),
            MONTH(@FechaActual),
            DATENAME(MONTH, @FechaActual),
            DATEPART(WEEK, @FechaActual),
            DAY(@FechaActual),
            DATENAME(WEEKDAY, @FechaActual)
        );

    END;

    SET @FechaActual = DATEADD(DAY, 1, @FechaActual);

END;
GO