-- Ejercicio 5: Empresa Discográfica
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE manager (
    id_manager INT PRIMARY KEY,
    nombre     VARCHAR(100) NOT NULL
);

-- Manager (1) representa Artista (1..N)
CREATE TABLE artista (
    nif             VARCHAR(15) PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    id_manager      INT NOT NULL,
    FOREIGN KEY (id_manager) REFERENCES manager(id_manager)
);

CREATE TABLE evento_promocion (
    id_evento         INT PRIMARY KEY,
    fecha_celebracion DATE NOT NULL,
    num_asistentes    INT
);

-- Artista (N:M) Evento: participa
CREATE TABLE participa (
    nif       VARCHAR(15) NOT NULL,
    id_evento INT NOT NULL,
    PRIMARY KEY (nif, id_evento),
    FOREIGN KEY (nif)       REFERENCES artista(nif),
    FOREIGN KEY (id_evento) REFERENCES evento_promocion(id_evento)
);
