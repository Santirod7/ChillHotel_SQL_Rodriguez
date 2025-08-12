CREATE VIEW v_habitaciones_ocupadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente;

SELECT * FROM v_habitaciones_ocupadas