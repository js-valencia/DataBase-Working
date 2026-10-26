-- Ejemplo 2: Pedidos de restaurante
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Cliente, Mesero y Categoría no tienen atributos en el enunciado: solo se agrega su clave.

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

-- Los platos se agrupan en categorías (Categoría 1, Plato 1..N)
CREATE TABLE plato (
    id_plato     INT PRIMARY KEY,
    precio       DECIMAL(8,2) NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id_categoria)
);

-- Pedido (N:M) Plato: contiene.
-- precio_unitario guarda el precio del plato al momento del pedido,
-- así no cambia aunque luego se modifique plato.precio.
CREATE TABLE detalle_pedido (
    id_pedido       INT NOT NULL,
    id_plato        INT NOT NULL,
    cantidad        INT NOT NULL,
    precio_unitario DECIMAL(8,2) NOT NULL,
    PRIMARY KEY (id_pedido, id_plato),
    FOREIGN KEY (id_pedido) REFERENCES pedido(id_pedido),
    FOREIGN KEY (id_plato)  REFERENCES plato(id_plato)
);
