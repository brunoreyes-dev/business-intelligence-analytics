/*
    Proyecto: Business Intelligence & Sales Analytics
    Empresa: NovaMarket
    Base de datos: NovaMarketDB

    Descripción:
    Creación de la base de datos principal del proyecto.
*/

IF DB_ID('NovaMarketDB') IS NULL
BEGIN
    CREATE DATABASE NovaMarketDB;
END;
GO