-- Sistema de bibliotecas
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Libro, Autor y Socio no tienen atributos en el diagrama: solo se agrega su clave.

CREATE TABLE libro (
    id_libro INT PRIMARY KEY
);

CREATE TABLE autor (
    id_autor INT PRIMARY KEY
);

CREATE TABLE socio (
    id_socio INT PRIMARY KEY
);

-- Libro (N:N) Autor: es escrito
CREATE TABLE es_escrito (
    id_libro INT NOT NULL,
    id_autor INT NOT NULL,
    PRIMARY KEY (id_libro, id_autor),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_autor) REFERENCES autor(id_autor)
);

-- Libro (N:N) Socio: préstamo
CREATE TABLE prestamo (
    id_libro INT NOT NULL,
    id_socio INT NOT NULL,
    PRIMARY KEY (id_libro, id_socio),
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio)
);
