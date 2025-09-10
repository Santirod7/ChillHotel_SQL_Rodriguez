CREATE TRIGGER tr_proteger_estados_finales_reserva
BEFORE UPDATE ON Reserva_habitaciones
FOR EACH ROW
BEGIN

    IF OLD.estado_Reserva <> NEW.estado_Reserva THEN
        IF OLD.estado_Reserva IN ('Finalizada', 'Cancelada', 'No Show') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: No se puede modificar el estado de una reserva que ya está finalizada, cancelada o marcada como No Show.';
        END IF;
    END IF;
END