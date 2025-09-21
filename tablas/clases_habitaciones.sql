CREATE TABLE IF NOT EXISTS Clases_Habitaciones (
  idClases_habitaciones INT PRIMARY KEY NOT NULL,
  Nombre_habitacion VARCHAR(25) UNIQUE NOT NULL,
  Tipo_de_cama VARCHAR(25) NOT NULL,
  Capacidad_maxima INT NOT NULL,
  Piso INT NOT NULL,
  Comodidades TEXT DEFAULT NULL,
  Precio_base DECIMAL(10, 2) NOT NULL);


