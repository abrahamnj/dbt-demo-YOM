{{ config(materialized='table') }}

SELECT c.nombre_cliente, SUM(t.monto_total) AS total
FROM `abraham-project.ambiente_rawzone.Ventas` AS t
RIGHT OUTER JOIN `abraham-project.ambiente_rawzone.Clientes` AS c
ON t.cliente_id = c.cliente_id
GROUP BY c.nombre_cliente