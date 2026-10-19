-- Ejercicio 7: Discos Musicales
-- Compatible con MySQL / MariaDB / PostgreSQL

-- El enunciado solo indica identificador; puedes agregar un campo nombre si lo necesitas.
CREATE TABLE genero_musical (
    id_genero INT PRIMARY KEY
);

-- El enunciado no da identificador, por eso el nombre es la clave.
CREATE TABLE cantante (
    nombre VARCHAR(100) PRIMARY KEY,
    pais   VARCHAR(60) NOT NULL
);

-- Género (1) clasifica Disco (0..N); Cantante (1) graba Disco (1..N)
CREATE TABLE disco (
    id_disco        INT PRIMARY KEY,
    titulo          VARCHAR(150) NOT NULL,
    precio          DECIMAL(8,2) NOT NULL,
    id_genero       INT NOT NULL,
    nombre_cantante VARCHAR(100) NOT NULL,
    FOREIGN KEY (id_genero)       REFERENCES genero_musical(id_genero),
    FOREIGN KEY (nombre_cantante) REFERENCES cantante(nombre)
);

CREATE TABLE cancion (
    id_cancion INT PRIMARY KEY,
    titulo     VARCHAR(150) NOT NULL
);

-- Disco (N:M) Canción: contiene (con posición dentro del disco)
CREATE TABLE contiene (
    id_disco   INT NOT NULL,
    id_cancion INT NOT NULL,
    posicion   INT NOT NULL,
    PRIMARY KEY (id_disco, id_cancion),
    UNIQUE (id_disco, posicion),
    FOREIGN KEY (id_disco)   REFERENCES disco(id_disco),
    FOREIGN KEY (id_cancion) REFERENCES cancion(id_cancion)
);
