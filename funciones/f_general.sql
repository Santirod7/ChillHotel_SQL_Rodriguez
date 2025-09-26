DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `f_calcular_total_estancia`(p_id_reserva INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    DECLARE v_precio_base DECIMAL(10, 2);
    DECLARE v_total_cargos DECIMAL(10, 2);
    DECLARE v_precio_final DECIMAL(10, 2);

    SELECT precio_total INTO v_precio_base
    FROM Reserva_habitaciones
    WHERE id_reserva = p_id_reserva;

    SELECT IFNULL(SUM(precio_en_el_momento * cantidad), 0) INTO v_total_cargos
    FROM Cargos_Habitacion
    WHERE idx_reserva = p_id_reserva;
    SET v_precio_final = v_precio_base + v_total_cargos;
    RETURN v_precio_final;
END$$

DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `f_calcular_noches_de_hospedaje`(p_fecha_entrada DATE, p_fecha_salida DATE) RETURNS int
    DETERMINISTIC
BEGIN
DECLARE var_recuento_noches INT;
SET var_recuento_noches = DATEDIFF(p_fecha_salida, p_fecha_entrada);
RETURN var_recuento_noches;
END$$
