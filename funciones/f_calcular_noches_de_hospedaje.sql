DELIMITER $$
CREATE DEFINER=`root`@`localhost` FUNCTION `f_calcular_noches_de_hospedaje`(p_fecha_entrada DATE, p_fecha_salida DATE) RETURNS int
    DETERMINISTIC
BEGIN
DECLARE var_recuento_noches INT;

SET var_recuento_noches = DATEDIFF(p_fecha_salida, p_fecha_entrada);
    
RETURN var_recuento_noches;
END$$
