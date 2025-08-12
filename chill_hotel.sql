CREATE SCHEMA IF NOT EXISTS `chill_hotel` DEFAULT CHARACTER SET utf8 ;
USE `chill_hotel` ;

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
select * from Habitaciones;

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
    Categoria VARCHAR(25) 
);

CREATE VIEW v_habitaciones_ocupadas AS
SELECT
	CONCAT(c.nombre, ' ', c.apellido) AS nombre_completo,
    h.Numero_Habitacion,
    h.Estado,
    r.fecha_entrada,
    r.fecha_salida
FROM reserva_habitaciones r
JOIN habitaciones h ON r.idx_habitacion = h.id_habitacion
JOIN cliente_registrado c ON r.idx_cliente = c.id_cliente;

SELECT * FROM v_habitaciones_ocupadas