/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket

    Script: 07_sales_analysis.sql
    Descripcion:
    Consultas analiticas de ventas.
*/

USE NovaMarketDB;
GO


/* =========================================================
   1. VENTAS E INGRESOS POR ANIO
   ========================================================= */

SELECT
    f.anio,
    COUNT(*) AS cantidad_ventas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos

FROM ventas v

INNER JOIN fechas f
    ON v.fecha_id = f.fecha_id

GROUP BY
    f.anio

ORDER BY
    f.anio;
GO

/* =========================================================
   2. INGRESOS POR CATEGORIA
   ========================================================= */

SELECT
    c.categoria,

    COUNT(*) AS cantidad_ventas,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos

FROM ventas v

INNER JOIN productos p
    ON v.producto_id = p.producto_id

INNER JOIN categorias c
    ON p.categoria_id = c.categoria_id

GROUP BY
    c.categoria

ORDER BY
    ingresos DESC;
GO

/* =========================================================
   3. TOP 10 PRODUCTOS POR INGRESOS
   ========================================================= */

SELECT TOP 10

    p.producto,
    p.marca,
    c.categoria,

    COUNT(*) AS cantidad_ventas,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos

FROM ventas v

INNER JOIN productos p
    ON v.producto_id = p.producto_id

INNER JOIN categorias c
    ON p.categoria_id = c.categoria_id

GROUP BY
    p.producto,
    p.marca,
    c.categoria

ORDER BY
    ingresos DESC;
GO
/* =========================================================
   4. VENTAS POR SEGMENTO DE CLIENTE
   ========================================================= */

SELECT

    c.segmento,

    COUNT(DISTINCT c.cliente_id) AS clientes,

    COUNT(v.venta_id) AS cantidad_ventas,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos,

    AVG(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingreso_promedio_por_venta

FROM clientes c

INNER JOIN ventas v
    ON c.cliente_id = v.cliente_id

GROUP BY
    c.segmento

ORDER BY
    ingresos DESC;
GO

/* =========================================================
   5. VENTAS POR CIUDAD Y SEGMENTO
   ========================================================= */

SELECT

    c.ciudad,

    c.segmento,

    COUNT(DISTINCT c.cliente_id) AS clientes,

    COUNT(v.venta_id) AS cantidad_ventas,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos

FROM clientes c

INNER JOIN ventas v
    ON c.cliente_id = v.cliente_id

GROUP BY
    c.ciudad,
    c.segmento

ORDER BY
    c.ciudad,
    ingresos DESC;
GO

/* =========================================================
   6. EVOLUCION MENSUAL DE INGRESOS
   ========================================================= */

SELECT

    f.anio,

    f.mes,

    f.nombre_mes,

    COUNT(v.venta_id) AS cantidad_ventas,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos

FROM ventas v

INNER JOIN fechas f
    ON v.fecha_id = f.fecha_id

GROUP BY
    f.anio,
    f.mes,
    f.nombre_mes

ORDER BY
    f.anio,
    f.mes;
GO

/* =========================================================
   7. RENTABILIDAD POR CATEGORIA
   ========================================================= */

SELECT

    c.categoria,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos,

    SUM(
        v.cantidad * p.costo
    ) AS costo_total,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    )
    -
    SUM(
        v.cantidad * p.costo
    ) AS utilidad,

    CAST(
        (
            SUM(
                (v.cantidad * v.precio_unitario) - v.descuento
            )
            -
            SUM(
                v.cantidad * p.costo
            )
        )
        /
        NULLIF(
            SUM(
                (v.cantidad * v.precio_unitario) - v.descuento
            ),
            0
        )
        * 100
        AS DECIMAL(10,2)
    ) AS margen_porcentaje

FROM ventas v

INNER JOIN productos p
    ON v.producto_id = p.producto_id

INNER JOIN categorias c
    ON p.categoria_id = c.categoria_id

GROUP BY
    c.categoria

ORDER BY
    utilidad DESC;
GO

/* =========================================================
   8. RENTABILIDAD POR PRODUCTO
   ========================================================= */

SELECT

    p.producto,

    p.marca,

    c.categoria,

    SUM(v.cantidad) AS unidades_vendidas,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    ) AS ingresos,

    SUM(
        v.cantidad * p.costo
    ) AS costo_total,

    SUM(
        (v.cantidad * v.precio_unitario) - v.descuento
    )
    -
    SUM(
        v.cantidad * p.costo
    ) AS utilidad,

    CAST(
        (
            SUM(
                (v.cantidad * v.precio_unitario) - v.descuento
            )
            -
            SUM(
                v.cantidad * p.costo
            )
        )
        /
        NULLIF(
            SUM(
                (v.cantidad * v.precio_unitario) - v.descuento
            ),
            0
        )
        * 100
        AS DECIMAL(10,2)
    ) AS margen_porcentaje

FROM ventas v

INNER JOIN productos p
    ON v.producto_id = p.producto_id

INNER JOIN categorias c
    ON p.categoria_id = c.categoria_id

GROUP BY
    p.producto,
    p.marca,
    c.categoria

ORDER BY
    utilidad DESC;
GO

