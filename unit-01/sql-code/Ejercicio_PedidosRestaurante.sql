-- Pedidos de restaurante
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Cliente, Mesero, Categoría y Pedido no tienen atributos en el diagrama: solo se agrega su clave.

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY
);

CREATE TABLE mesero (
    id_mesero INT PRIMARY KEY
);

CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY
);

-- Cliente (1) hace Pedido (1..N); Mesero (1) atiende Pedido (1..N)
CREATE TABLE pedido (
    id_pedido  INT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_mesero  INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente),
    FOREIGN KEY (id_mesero)  REFERENCES mesero(id_mesero)
);

-- Pedido (1) lleva Plato (1..N), tal como está en el diagrama;
-- Plato (1..N) puede estar en Categoría (1)
CREATE TABLE plato (
    id_plato     INT PRIMARY KEY,
    precio       DECIMAL(8,2) NOT NULL,
    id_pedido    INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_pedido)    REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Si tu docente lo quiere N:M (un plato en varios pedidos), quita id_pedido de plato y usa:
-- CREATE TABLE pedido_plato (
--     id_pedido INT NOT NULL, id_plato INT NOT NULL,
--     PRIMARY KEY (id_pedido, id_plato),
--     FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
--     FOREIGN KEY (id_plato)  REFERENCES plato(id_plato)
-- );
