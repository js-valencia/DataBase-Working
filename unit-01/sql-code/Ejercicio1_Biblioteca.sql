-- Ejemplo 1: Sistema de biblioteca
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Libro, Autor y Socio no tienen atributos en el enunciado: solo se agrega su clave.

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

-- Libro (N:N) Socio: préstamo, con fecha de retiro y de devolución.
-- id_prestamo permite que un socio retire el mismo libro más de una vez.
-- fecha_devolucion queda vacía mientras el libro no se haya devuelto.
CREATE TABLE prestamo (
    id_prestamo      INT PRIMARY KEY,
    id_libro         INT NOT NULL,
    id_socio         INT NOT NULL,
    fecha_retiro     DATE NOT NULL,
    fecha_devolucion DATE,
    FOREIGN KEY (id_libro) REFERENCES libro(id_libro),
    FOREIGN KEY (id_socio) REFERENCES socio(id_socio)
);