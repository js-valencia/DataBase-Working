-- Camiones
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE camionero (
    ci        VARCHAR(15) PRIMARY KEY,
    nombre    VARCHAR(100) NOT NULL,
    telef     VARCHAR(20),
    direccion VARCHAR(150),
    salario   DECIMAL(10,2)
);

CREATE TABLE camion (
    matricula VARCHAR(15) PRIMARY KEY,
    modelo    VARCHAR(60),
    tipo      VARCHAR(40),
    potencia  INT
);

CREATE TABLE provincia (
    codigo_prov VARCHAR(10) PRIMARY KEY,
    nombre      VARCHAR(80) NOT NULL
);

CREATE TABLE destinatario (
    ci     VARCHAR(15) PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

-- Camionero (N:M) Camión: lleva en (con fecha)
CREATE TABLE lleva_en (
    ci_camionero VARCHAR(15) NOT NULL,
    matricula    VARCHAR(15) NOT NULL,
    fecha        DATE NOT NULL,
    PRIMARY KEY (ci_camionero, matricula, fecha),
    FOREIGN KEY (ci_camionero) REFERENCES camionero(ci),
    FOREIGN KEY (matricula)    REFERENCES camion(matricula)
);

-- Camionero (1) transporta Paquete (1..N)
-- Paquete (1..N) llega a una Provincia (1)
-- Paquete (1..N) pide y recibe Destinatario (1)
CREATE TABLE paquete (
    codigo          INT PRIMARY KEY,
    descripcion     VARCHAR(200),
    ci_camionero    VARCHAR(15) NOT NULL,
    codigo_prov     VARCHAR(10) NOT NULL,
    ci_destinatario VARCHAR(15) NOT NULL,
    FOREIGN KEY (ci_camionero)    REFERENCES camionero(ci),
    FOREIGN KEY (codigo_prov)     REFERENCES provincia(codigo_prov),
    FOREIGN KEY (ci_destinatario) REFERENCES destinatario(ci)
);
