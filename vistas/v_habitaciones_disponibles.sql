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