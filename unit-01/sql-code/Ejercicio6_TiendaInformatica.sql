-- Ejercicio 6: Tienda Informática
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE producto (
    codigo       INT PRIMARY KEY,
    descripcion  VARCHAR(200) NOT NULL,
    precio       DECIMAL(10,2) NOT NULL,
    existencias  INT NOT NULL DEFAULT 0
);

CREATE TABLE cliente (
    codigo    INT PRIMARY KEY,
    nombre    VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    direccion VARCHAR(150),
    telefono  VARCHAR(20)
);

CREATE TABLE proveedor (
    codigo    INT PRIMARY KEY,
    nombres   VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    direccion VARCHAR(150),
    provincia VARCHAR(80),
    telefono  VARCHAR(20)
);

-- Cliente (N:M) Producto: compra (con fecha).
-- La fecha forma parte de la clave para permitir que el mismo cliente compre el mismo producto en días distintos.
CREATE TABLE compra (
    cod_cliente  INT NOT NULL,
    cod_producto INT NOT NULL,
    fecha        DATE NOT NULL,
    PRIMARY KEY (cod_cliente, cod_producto, fecha),
    FOREIGN KEY (cod_cliente)  REFERENCES cliente(codigo),
    FOREIGN KEY (cod_producto) REFERENCES producto(codigo)
);

-- Proveedor (N:M) Producto: suministra
CREATE TABLE suministra (
    cod_proveedor INT NOT NULL,
    cod_producto  INT NOT NULL,
    PRIMARY KEY (cod_proveedor, cod_producto),
    FOREIGN KEY (cod_proveedor) REFERENCES proveedor(codigo),
    FOREIGN KEY (cod_producto)  REFERENCES producto(codigo)
);
