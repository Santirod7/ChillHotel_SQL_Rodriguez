DELIMITER &&
CREATE DEFINER=`root`@`localhost` PROCEDURE `sp_check_in`(IN p_id_reserva INT)
BEGIN
    DECLARE var_id_habitacion INT;
    DECLARE var_estado_actual ENUM('Confirmada', 'Pendiente', 'Activa', 'Finalizada', 'Cancelada', 'No Show');
    
    SELECT idx_habitacion, estado_Reserva INTO var_id_habitacion, var_estado_actual
    FROM Reserva_habitaciones
    WHERE id_reserva = p_id_reserva;
    
    IF var_estado_actual = 'Confirmada' THEN
        UPDATE Habitaciones
        SET Estado = 'Ocupada'
        WHERE id_Habitacion = var_id_habitacion;
       
       UPDATE Reserva_habitaciones
        SET estado_Reserva = 'Activa'
        WHERE id_reserva = p_id_reserva;
	ELSE
    SIGNAL sqlstate '45000'
    SET message_text = 'ERROR: Hubo un problema al hacer el check_in, Controla si la hab. ya está reservada, sino contactese con el soporte técnico';
    END IF;
END&&

DELIMITER &&
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
END&&