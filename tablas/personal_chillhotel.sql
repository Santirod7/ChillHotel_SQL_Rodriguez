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