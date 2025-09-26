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