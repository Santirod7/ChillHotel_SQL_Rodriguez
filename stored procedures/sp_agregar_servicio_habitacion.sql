CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_agregar_servicio_habitacion`(p_id_reserva INT, p_id_producto INT, p_cantidad INT)
BEGIN
    DECLARE v_estado_reserva ENUM('Confirmada', 'Pendiente', 'Activa', 'Finalizada', 'Cancelada', 'No Show');
    DECLARE v_precio_producto DECIMAL(10, 2);

    SELECT estado_Reserva INTO v_estado_reserva
    FROM Reserva_habitaciones
    WHERE id_reserva = p_id_reserva;

    IF v_estado_reserva = 'Activa' THEN
        SELECT Precio_Venta INTO v_precio_producto
        FROM Productos_servicioHabitacion
        WHERE ID_Producto = p_id_producto;
        
        INSERT INTO Cargos_Habitacion (
            idx_reserva,
            idx_producto,
            cantidad,
            precio_en_el_momento,
            fecha_cargo
        ) VALUES (
            p_id_reserva,
            p_id_producto,
            p_cantidad,
            v_precio_producto,
            NOW()
        );
	ELSE
    SIGNAL sqlstate '45000'
    SET message_text = 'ERROR: Carga de servicio a la habitación fallida, inténtelo mas tarde';
    END IF;
END