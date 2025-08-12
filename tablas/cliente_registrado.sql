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