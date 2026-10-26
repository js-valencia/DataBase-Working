-- Ejemplo 4: Sistema de aerolínea
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Aerolínea, Avión y Pasajero no tienen atributos en el enunciado: solo se agrega su clave.

CREATE TABLE aerolinea (
    id_aerolinea INT PRIMARY KEY
);

CREATE TABLE avion (
    id_avion INT PRIMARY KEY
);

CREATE TABLE pasajero (
    id_pasajero INT PRIMARY KEY
);

-- Aerolínea (1) opera Vuelo (1..N); cada vuelo lo realiza un avión
CREATE TABLE vuelo (
    numero_vuelo VARCHAR(10) PRIMARY KEY,
    fecha        DATE NOT NULL,
    origen       VARCHAR(80) NOT NULL,
    destino      VARCHAR(80) NOT NULL,
    id_aerolinea INT NOT NULL,
    id_avion     INT NOT NULL,
    FOREIGN KEY (id_aerolinea) REFERENCES aerolinea(id_aerolinea),
    FOREIGN KEY (id_avion)     REFERENCES avion(id_avion)
);

-- Un pasajero realiza una reserva para un vuelo específico.
-- tarifa guarda lo pagado en el momento de la reserva.
CREATE TABLE reserva (
    id_reserva   INT PRIMARY KEY,
    asiento      VARCHAR(10) NOT NULL,
    tarifa       DECIMAL(10,2) NOT NULL,
    id_pasajero  INT NOT NULL,
    numero_vuelo VARCHAR(10) NOT NULL,
    FOREIGN KEY (id_pasajero)  REFERENCES pasajero(id_pasajero),
    FOREIGN KEY (numero_vuelo) REFERENCES vuelo(numero_vuelo)
);