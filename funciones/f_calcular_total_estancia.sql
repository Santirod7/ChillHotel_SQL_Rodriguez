CREATE DEFINER=`root`@`localhost` FUNCTION `f_calcular_total_estancia`(p_id_reserva INT) RETURNS decimal(10,2)
    READS SQL DATA
BEGIN
    -- 1. Declaro las variables que usaré como 'cajas' temporales
    DECLARE v_precio_base DECIMAL(10, 2);
    DECLARE v_total_cargos DECIMAL(10, 2);
    DECLARE v_precio_final DECIMAL(10, 2);

    -- 2. Obtengo el precio base de la habitación desde la tabla de reservas
    SELECT precio_total INTO v_precio_base
    FROM Reserva_habitaciones
    WHERE id_reserva = p_id_reserva;

    -- 3. Calculo la suma de todos los productos y servicios consumidos
    -- Uso IFNULL para evitar errores si no hay consumos (SUM de nada es NULL)
    SELECT IFNULL(SUM(precio_en_el_momento * cantidad), 0) INTO v_total_cargos
    FROM Cargos_Habitacion
    WHERE idx_reserva = p_id_reserva;

    -- 4. Sumo ambos valores para obtener el total final
    SET v_precio_final = v_precio_base + v_total_cargos;

    -- 5. Devuelvo el resultado calculado
    RETURN v_precio_final;
END