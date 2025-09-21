CREATE VIEW v_habitaciones_reservadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente;

-- VISTA PARA PRÓXIMAS LLEGADAS A HABITACIONES

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

-- VISTA PARA HABITACIONES QUE REQUIEREN LIMPIEZA ANTES DE SER USADA

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

-- VISTA PARA PERSONAL DE REPOSICIÓN DE PRODUCTOS EN BAJO STOCK

CREATE VIEW v_productos_stock_bajo AS
SELECT
	p.nombre_producto,
    p.stock,
    p.Categoria
FROM productos_serviciohabitacion p
WHERE
p.Stock <= 10;

-- VISTA PARA RECEPCIONISTA COMO MUESTRA DE HABITACIONES DISPONIBLES

CREATE VIEW v_habitaciones_disponibles AS
SELECT
	c.Nombre_habitacion,
    c.Piso,
    c.Tipo_de_cama,                        
    c.Capacidad_maxima,                    
    c.Precio_base, 
    h.Numero_Habitacion
FROM habitaciones h
JOIN clases_habitaciones c ON h.id_Clase_habitacion = c.idClases_Habitaciones
WHERE h.estado = 'Disponible'
ORDER BY c.Piso ASC, h.Numero_Habitacion ASC;