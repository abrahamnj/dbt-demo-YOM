/*
Unión entre la tabla de productos y la tabla de proveedores: Si necesitas información sobre los productos y sus proveedores, puedes unir la tabla Productos con la tabla Proveedores
*/
{{ config(materialized='table') }}

SELECT p.nombre_producto, pr.nombre_proveedor
FROM `abraham-project.ambiente_rawzone.Productos` AS p
INNER JOIN `abraham-project.ambiente_rawzone.Proveedores` AS pr
ON p.proveedor_id = pr.proveedor_id