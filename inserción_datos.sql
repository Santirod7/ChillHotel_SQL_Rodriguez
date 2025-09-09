-- Clases de Habitaciones
INSERT INTO `Clases_Habitaciones` (`idClases_habitaciones`, `Nombre_habitacion`, `Tipo_de_cama`, `Capacidad_maxima`, `Piso`, `Comodidades`, `Precio_base`) VALUES
(1, 'Estándar Individual', 'Individual', 1, 1, 'Wi-Fi, TV por cable, Baño privado', 75.00),
(2, 'Doble Queen', 'Queen Size', 2, 2, 'Wi-Fi, TV por cable, Baño privado, Mini-bar', 120.50),
(3, 'Suite de Lujo', 'King Size', 4, 5, 'Wi-Fi de alta velocidad, Smart TV 55", Baño con jacuzzi, Vistas panorámicas, Sofá cama', 250.00);

-- Clientes
INSERT INTO `Cliente_registrado` (`nombre`, `apellido`, `email`, `dni`, `edad`, `telefono`, `nacionalidad`) VALUES
('Ana', 'Torres', 'ana.t@email.com', 40123456, 28, '11-1234-5678', 'Argentina'),
('Carlos', 'Gomez', 'carlos.g@email.com', 95876543, 45, '22-9876-5432', 'Mexicano'),
('Lucia', 'Fernandez', 'lucia.f@email.com', 21123987, 35, '33-5555-4444', 'Española');

-- Productos
INSERT INTO `Productos_servicioHabitacion` (`ID_Producto`, `Nombre_Producto`, `Descripcion`, `Precio_Venta`, `Stock`, `Categoria`) VALUES
(1, 'Papas Fritas Lays', 'Bolsa de 150g', 5.00, 20, 'Snacks'),
(2, 'Maní Salado Pehuamar', 'Bolsa de 100g', 4.50, 8, 'Snacks'),
(3, 'Agua Mineral sin gas 500ml', 'Botella de agua Villavicencio', 3.00, 50, 'Bebidas'),
(4, 'Gaseosa Coca-Cola 350ml', 'Lata de Coca-Cola sabor original', 4.00, 45, 'Bebidas'),
(5, 'Sándwich de Jamón y Queso', 'Pan de molde, jamón cocido, queso tybo', 12.00, 15, 'Comidas'),
(6, 'Ensalada César con Pollo', 'Lechuga, pollo grillado, crutones, aderezo césar', 15.00, 10, 'Comidas');

-- Personal
INSERT INTO `personal_chillhotel` (`nombre`, `apellido`, `area`, `email`, `telefono`, `fecha_Contratacion`, `horariolabotal_entrada`, `salario`, `estado`) VALUES
('Juan', 'Perez', 'Recepción', 'jperez@chillhotel.com', '11-0000-1111', '2023-05-10', '08:00:00', 950.00, 'Activo'),
('Maria', 'Lopez', 'Limpieza', 'mlopez@chillhotel.com', '11-0000-2222', '2022-11-20', '07:00:00', 800.00, 'Activo');

-- Habitaciones Físicas
INSERT INTO `Habitaciones` (`Numero_Habitacion`, `id_Clase_Habitacion`, `Estado`) VALUES
('101', 1, 'Disponible'),
('102', 1, 'Disponible'),
('201', 2, 'Disponible'),
('202', 2, 'Mantenimiento'),
('501', 3, 'Disponible');

-- Insertar Reservas
INSERT INTO `Reserva_habitaciones` (`idx_habitacion`, `idx_cliente`, `fecha_entrada`, `fecha_salida`, `precio_total`, `estado_Reserva`) VALUES
(1, 1, '2025-09-08', '2025-09-12', 300.00, 'Confirmada'),
(3, 2, CURDATE(), '2025-09-15', 602.50, 'Confirmada'),
(5, 3, '2025-08-01', '2025-08-05', 1000.00, 'Finalizada'),
(5, 1, '2025-10-20', '2025-10-25', 1250.00, 'Confirmada');

-- check-in para la primera reserva
UPDATE `Reserva_habitaciones` SET `estado_Reserva` = 'Activa' WHERE `id_reserva` = 1;
UPDATE `Habitaciones` SET `Estado` = 'Ocupada' WHERE `id_Habitacion` = 1;

-- Cargos 
INSERT INTO `Cargos_Habitacion` (`idx_reserva`, `idx_producto`, `cantidad`, `precio_en_el_momento`, `fecha_cargo`) VALUES
(1, 3, 2, 3.00, '2025-09-09 10:30:00'),
(1, 1, 1, 5.00, '2025-09-09 15:00:00');