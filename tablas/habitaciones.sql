CREATE TABLE Habitaciones (
    id_Habitacion INT PRIMARY KEY AUTO_INCREMENT,
    Numero_Habitacion VARCHAR(10) NOT NULL UNIQUE,
    id_Clase_Habitacion INT,
    Estado VARCHAR(50) DEFAULT 'Disponible', 
    FOREIGN KEY (Id_Clase_Habitacion) REFERENCES Clases_Habitaciones(idClases_habitaciones)
);
select * from Habitaciones;