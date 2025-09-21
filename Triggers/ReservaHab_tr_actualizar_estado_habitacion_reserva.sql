DELIMITER $$

CREATE TRIGGER tr_actualizar_estado_habitacion_reserva
AFTER INSERT ON Reserva_habitaciones
FOR EACH ROW
BEGIN
    UPDATE Habitaciones
    SET Estado = 'Reservada'
    WHERE id_Habitacion = NEW.idx_habitacion;
END$$