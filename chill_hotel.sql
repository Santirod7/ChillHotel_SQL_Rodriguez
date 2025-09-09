CREATE SCHEMA IF NOT EXISTS `Chill_Hotel` DEFAULT CHARACTER SET utf8 ;
USE `Chill_Hotel` ;

CREATE TABLE IF NOT EXISTS Cliente_registrado (
  	id_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    nombre VARCHAR(20) NOT NULL,
    apellido VARCHAR(20) NOT NULL,
    email VARCHAR(150) UNIQUE DEFAULT NULL,
    dni INT UNIQUE NOT NULL,
    edad INT UNSIGNED DEFAULT NULL,
    telefono VARCHAR(20) UNIQUE DEFAULT NULL,
    nacionalidad VARCHAR(30) DEFAULT 'Argentina')

select * from Cliente_registrado;

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

select * from habitaciones;

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

SELECT * FROM v_habitaciones_ocupadas;

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