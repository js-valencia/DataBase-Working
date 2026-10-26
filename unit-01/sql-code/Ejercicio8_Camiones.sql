-- Ejercicio 8: Camiones
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE camionero (
    cedula    VARCHAR(15) PRIMARY KEY,
    nombre    VARCHAR(100) NOT NULL,
    telefono  VARCHAR(20),
    direccion VARCHAR(150),
    salario   DECIMAL(10,2),
    poblacion VARCHAR(80)
);

CREATE TABLE camion (
    matricula VARCHAR(15) PRIMARY KEY,
    modelo    VARCHAR(60),
    tipo      VARCHAR(40),
    potencia  INT
);

CREATE TABLE provincia (
    codigo_provincia VARCHAR(10) PRIMARY KEY,
    nombre           VARCHAR(80) NOT NULL
);

-- Camionero (N:M) Camión: un camionero conduce distintos camiones en fechas diferentes
CREATE TABLE lleva_en (
    cedula_camionero VARCHAR(15) NOT NULL,
    matricula        VARCHAR(15) NOT NULL,
    fecha            DATE NOT NULL,
    PRIMARY KEY (cedula_camionero, matricula, fecha),
    FOREIGN KEY (cedula_camionero) REFERENCES camionero(cedula),
    FOREIGN KEY (matricula)        REFERENCES camion(matricula)
);

-- Un paquete lo distribuye un solo camionero y llega a una sola provincia.
-- El destinatario y su dirección son atributos del paquete.
CREATE TABLE paquete (
    codigo                 INT PRIMARY KEY,
    descripcion            VARCHAR(200),
    destinatario           VARCHAR(100) NOT NULL,
    direccion_destinatario VARCHAR(150) NOT NULL,
    cedula_camionero       VARCHAR(15) NOT NULL,
    codigo_provincia       VARCHAR(10) NOT NULL,
    FOREIGN KEY (cedula_camionero) REFERENCES camionero(cedula),
    FOREIGN KEY (codigo_provincia) REFERENCES provincia(codigo_provincia)
);