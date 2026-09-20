/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 08_create_sales_view.sql
    Descripcion:
    Vista consolidada de ventas para analisis y Power BI.
*/

USE NovaMarketDB;
GO

CREATE OR ALTER VIEW dbo.vw_sales_analysis
AS

SELECT

    /* Fecha */
    f.fecha_id,
    f.fecha,
    f.anio,
    f.trimestre,
    f.mes,
    f.nombre_mes,
    f.semana,
    f.dia,
    f.nombre_dia,

    /* Cliente */
    c.cliente_id,
    c.nombre,
    c.apellido,
    c.genero,
    c.fecha_nacimiento,
    c.ciudad,
    c.segmento,

    /* Producto */
    p.producto_id,
    p.producto,
    p.marca,
    cat.categoria_id,
    cat.categoria,

    /* Venta */
    v.venta_id,
    v.cantidad,
    v.precio_unitario,
    v.descuento,
    v.canal,

    /* Metricas */
    (v.cantidad * v.precio_unitario) - v.descuento
        AS ingresos,

    (v.cantidad * p.costo)
        AS costo_total,

    ((v.cantidad * v.precio_unitario) - v.descuento)
        - (v.cantidad * p.costo)
        AS utilidad

FROM ventas v

INNER JOIN fechas f
    ON v.fecha_id = f.fecha_id

INNER JOIN clientes c
    ON v.cliente_id = c.cliente_id

INNER JOIN productos p
    ON v.producto_id = p.producto_id

INNER JOIN categorias cat
    ON p.categoria_id = cat.categoria_id;
GO