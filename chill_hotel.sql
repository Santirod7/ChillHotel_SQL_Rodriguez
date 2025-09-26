CREATE SCHEMA IF NOT EXISTS `Chill_Hotel` DEFAULT CHARACTER SET utf8 ;
USE `Chill_Hotel` ;


-- CREACIÓN DE TABLAS

CREATE TABLE IF NOT EXISTS Cliente_registrado (
  	id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    edad INT UNSIGNED DEFAULT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina');

CREATE TABLE IF NOT EXISTS Clases_Habitaciones (
  idClases_habitaciones INT PRIMARY KEY NOT NULL,
  Nombre_habitacion VARCHAR(25) UNIQUE NOT NULL,
  Tipo_de_cama VARCHAR(25) NOT NULL,
  Capacidad_maxima INT NOT NULL,
  Piso INT NOT NULL,
  Comodidades TEXT DEFAULT NULL,
  Precio_base DECIMAL(10, 2) NOT NULL);

CREATE TABLE Habitaciones (
    id_Habitacion INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Habitacion VARCHAR(10) NOT NULL UNIQUE,
    id_Clase_Habitacion INT,
    Estado VARCHAR(50) DEFAULT 'Disponible', 
    FOREIGN KEY (Id_Clase_Habitacion) REFERENCES Clases_Habitaciones(idClases_habitaciones)
);

CREATE TABLE IF NOT EXISTS Reserva_habitaciones (
  id_reserva INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  idx_habitacion INT NOT NULL,
  idx_cliente INT NOT NULL,
  fecha_entrada DATE NOT NULL,
  fecha_salida DATE NOT NULL,
  precio_total DECIMAL(10, 2) NOT NULL,
  estado_Reserva VARCHAR(50) DEFAULT 'Confirmada',
  FOREIGN KEY (idx_habitacion) REFERENCES Habitaciones(id_habitacion),
  FOREIGN KEY (idx_Cliente) REFERENCES Cliente_registrado(id_Cliente));

CREATE TABLE personal_chillhotel (
    ID_Personal INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nombre VARCHAR(15) NOT NULL,
    apellido VARCHAR(15) NOT NULL,
    area VARCHAR(20) NOT NULL,
    email VARCHAR(50) UNIQUE,
    telefono VARCHAR(20) UNIQUE,
    fecha_Contratacion DATE NOT NULL,
    horariolabotal_entrada TIME NOT NULL,
    salario DECIMAL(10, 2),
    estado VARCHAR(50) DEFAULT 'Activo' 
);

CREATE TABLE Productos_servicioHabitacion (
    ID_Producto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Producto VARCHAR(50) NOT NULL,
    Descripcion TEXT,
    Precio_Venta DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    Categoria VARCHAR(25) -- Ej: 'Comidas', 'Bebidas', 'Snacks', 'Artículos Personales'
);

CREATE TABLE IF NOT EXISTS Cargos_Habitacion (
    id_cargo INT PRIMARY KEY AUTO_INCREMENT,
    idx_reserva INT NOT NULL,
    idx_producto INT NOT NULL,
    cantidad INT NOT NULL DEFAULT 1,
    precio_en_el_momento DECIMAL(10, 2) NOT NULL,
    fecha_cargo DATETIME NOT NULL,
    FOREIGN KEY (idx_reserva) REFERENCES Reserva_habitaciones(id_reserva),
    FOREIGN KEY (idx_producto) REFERENCES Productos_servicioHabitacion(ID_Producto)
);

ALTER TABLE Habitaciones
MODIFY COLUMN Estado ENUM('Disponible', 'Ocupada', 'Reservada', 'Requiere Limpieza', 'Mantenimiento') DEFAULT 'Disponible';

ALTER TABLE Reserva_habitaciones
MODIFY COLUMN estado_Reserva ENUM('Confirmada', 'Pendiente', 'Activa', 'Finalizada', 'Cancelada', 'No Show') DEFAULT 'Pendiente';


-- INSERCIÓN DE DATOS
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


-- CREACIÓN DE VIEWS

CREATE VIEW v_habitaciones_reservadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente;

CREATE VIEW v_proximas_llegadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente
WHERE
h.estado = 'Reservada' AND r.estado_reserva = 'Confirmada'
AND r.fecha_entrada BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 DAY);

CREATE VIEW v_limpíeza_requerida AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente
WHERE
h.estado = 'Requiere Limpieza' AND r.estado_reserva = 'Activa'
AND r.fecha_salida = CURDATE();

CREATE VIEW v_productos_stock_bajo AS
SELECT
	p.nombre_producto,
    p.stock,
    p.Categoria
FROM productos_serviciohabitacion p
WHERE
p.Stock <= 10;

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


-- CREACIÓN DE FUNCIONES

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


-- CREACIÓN DE STORED PROCEDURE

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

-- CREACIÓN DE TRIGGERS

DELIMITER $$

CREATE TRIGGER tr_actualizar_estado_habitacion_reserva
AFTER INSERT ON Reserva_habitaciones
FOR EACH ROW
BEGIN
    UPDATE Habitaciones
    SET Estado = 'Reservada'
    WHERE id_Habitacion = NEW.idx_habitacion;
END$$

DELIMITER $$

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
END$$