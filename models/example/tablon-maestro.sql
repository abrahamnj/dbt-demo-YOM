{{ config(materialized='view') }}

WITH
  -- Tabla de regiones
  regiones AS (
    SELECT region_id, nombre_region, pais_region
    FROM `abraham-project.ambiente_rawzone.Regiones`
  ),
  -- Tabla de ventas por región
  ventas_por_region AS (
    SELECT vpr.region_id, vpr.fecha_venta, vpr.cantidad_vendida, vpr.monto_total
    FROM `abraham-project.ambiente_rawzone.Ventas_por_Región` AS vpr
  ),
  -- Tabla de clientes SCD
  clientes_scd AS (
    SELECT cs.cliente_id, cs.nombre_cliente, cs.direccion_cliente, cs.ciudad_cliente, cs.pais_cliente
    FROM `abraham-project.ambiente_rawzone.Clientes_SCD` AS cs
  ),
  -- Tabla de proveedores
  proveedores AS (
    SELECT p.proveedor_id, p.nombre_proveedor, p.direccion_proveedor, p.ciudad_proveedor, p.pis_proveedor
    FROM `abraham-project.ambiente_rawzone.Proveedores` AS p
  ),
  -- Tabla de clientes
  clientes AS (
    SELECT c.cliente_id, c.nombre_cliente, c.direccion_cliente, c.ciudad_cliente, c.pais_cliente
    FROM `abraham-project.ambiente_rawzone.Clientes` AS c
  ),
  -- Tabla de productos
  productos AS (
    SELECT pr.producto_id, pr.nombre_producto, pr.categoria_producto, pr.proveedor_id
    FROM `abraham-project.ambiente_rawzone.Productos` AS pr
  ),
  -- Tabla de ventas
  ventas AS (
    SELECT v.venta_id, v.fecha_venta, v.producto_id, v.cliente_id, v.cantidad_vendida, v.monto_total, v.region_id
    FROM `abraham-project.ambiente_rawzone.Ventas` AS v
  )
SELECT
  v.venta_id,
  v.fecha_venta,
  v.producto_id,
  c.nombre_cliente,
  p.nombre_producto,
  v.cantidad_vendida,
  v.monto_total,
  r.nombre_region
FROM ventas AS v
LEFT JOIN clientes AS c ON v.cliente_id = c.cliente_id
LEFT JOIN productos AS p ON v.producto_id = p.producto_id
LEFT JOIN regiones AS r ON v.region_id = r.region_id