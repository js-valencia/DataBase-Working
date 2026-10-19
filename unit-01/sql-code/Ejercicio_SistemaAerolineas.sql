-- Sistema de aerolíneas
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Aerolínea, Avión y Pasajero no tienen atributos en el diagrama: solo se agrega su clave.

CREATE TABLE aerolinea (
    id_aerolinea INT PRIMARY KEY
);

CREATE TABLE avion (
    id_avion INT PRIMARY KEY
);

CREATE TABLE pasajero (
    id_pasajero INT PRIMARY KEY
);

-- Aerolínea (1) opera Vuelo (1..N); Vuelo (N) lo realiza Avión (1)
CREATE TABLE vuelo (
    id           INT PRIMARY KEY,
    fecha        DATE NOT NULL,
    origen       VARCHAR(80) NOT NULL,
    destino      VARCHAR(80) NOT NULL,
    id_aerolinea INT NOT NULL,
    id_avion     INT NOT NULL,
    FOREIGN KEY (id_aerolinea) REFERENCES aerolinea(id_aerolinea),
    FOREIGN KEY (id_avion)     REFERENCES avion(id_avion)
);

-- Vuelo (1) tiene Reserva (1..N)
CREATE TABLE reserva (
    id_reserva INT PRIMARY KEY,
    asiento    VARCHAR(10) NOT NULL,
    tarifa     DECIMAL(10,2) NOT NULL,
    id_vuelo   INT NOT NULL,
    FOREIGN KEY (id_vuelo) REFERENCES vuelo(id)
);

-- Pasajero (N:N) Reserva: realiza
CREATE TABLE realiza (
    id_pasajero INT NOT NULL,
    id_reserva  INT NOT NULL,
    PRIMARY KEY (id_pasajero, id_reserva),
    FOREIGN KEY (id_pasajero) REFERENCES pasajero(id_pasajero),
    FOREIGN KEY (id_reserva)  REFERENCES reserva(id_reserva)
);
