CREATE VIEW v_productos_stock_bajo AS
SELECT
	p.nombre_producto,
    p.stock,
    p.Categoria
FROM productos_serviciohabitacion p
WHERE
p.Stock <= 10;
