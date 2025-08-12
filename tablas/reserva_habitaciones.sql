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