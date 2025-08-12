CREATE TABLE Productos_servicioHabitacion (
    ID_Producto INT PRIMARY KEY AUTO_INCREMENT,
    Nombre_Producto VARCHAR(50) NOT NULL,
    Descripcion TEXT,
    Precio_Venta DECIMAL(10, 2) NOT NULL,
    Stock INT DEFAULT 0,
    Categoria VARCHAR(25) 
);