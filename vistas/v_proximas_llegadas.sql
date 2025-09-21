CREATE VIEW v_proximas_llegadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente
WHERE
h.estado = 'Reservada' AND r.estado_reserva = 'Confirmada'
AND r.fecha_entrada BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 DAY);