CREATE VIEW v_limpíeza_requerida AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente
WHERE
h.estado = 'Requiere Limpieza' AND r.estado_reserva = 'Activa'
AND r.fecha_salida = CURDATE();