-- Sistema de cuenta bancaria
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE cliente (
    ci        VARCHAR(15) PRIMARY KEY,
    nombres   VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL,
    direccion VARCHAR(150),
    correo    VARCHAR(100)
);

-- telefono es multivaluado: tabla aparte
CREATE TABLE cliente_telefono (
    ci       VARCHAR(15) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (ci, telefono),
    FOREIGN KEY (ci) REFERENCES cliente(ci)
);

-- Cliente (1) tiene Cuenta Bancaria (1..N)
CREATE TABLE cuenta_bancaria (
    numero         VARCHAR(20) PRIMARY KEY,
    saldo          DECIMAL(12,2) NOT NULL DEFAULT 0,
    tipo           VARCHAR(10) NOT NULL,   -- 'AHORRO' o 'CORRIENTE'
    fecha_apertura DATE NOT NULL,
    ci_cliente     VARCHAR(15) NOT NULL,
    FOREIGN KEY (ci_cliente) REFERENCES cliente(ci)
);

-- Especialización disjunta (d) de Cuenta Bancaria
CREATE TABLE ahorro (
    numero VARCHAR(20) PRIMARY KEY,
    FOREIGN KEY (numero) REFERENCES cuenta_bancaria(numero)
);

CREATE TABLE corriente (
    numero          VARCHAR(20) PRIMARY KEY,
    saldo_negativo  DECIMAL(12,2) NOT NULL DEFAULT 0,
    cupo_autorizado DECIMAL(12,2) NOT NULL DEFAULT 0,
    FOREIGN KEY (numero) REFERENCES cuenta_bancaria(numero)
);

-- Cuenta Bancaria (1) tiene Transacción (1..N)
-- cuenta_asociada es la cuenta a la que pertenece la transacción
CREATE TABLE transaccion (
    codigo           INT PRIMARY KEY,
    monto            DECIMAL(12,2) NOT NULL,
    fecha            DATE NOT NULL,
    hora             TIME NOT NULL,
    cuenta_asociada  VARCHAR(20) NOT NULL,
    FOREIGN KEY (cuenta_asociada) REFERENCES cuenta_bancaria(numero)
);

-- Especialización disjunta (d) de Transacción
CREATE TABLE deposito (
    codigo INT PRIMARY KEY,
    FOREIGN KEY (codigo) REFERENCES transaccion(codigo)
);

CREATE TABLE retiro (
    codigo INT PRIMARY KEY,
    FOREIGN KEY (codigo) REFERENCES transaccion(codigo)
);

CREATE TABLE transferencia (
    codigo INT PRIMARY KEY,
    FOREIGN KEY (codigo) REFERENCES transaccion(codigo)
);

-- Cliente (1) realiza Préstamo (0..N)
CREATE TABLE prestamo (
    id             INT PRIMARY KEY,
    fecha_otorgada DATE NOT NULL,
    fecha_cierre   DATE,
    monto          DECIMAL(12,2) NOT NULL,
    tasa_interes   DECIMAL(5,2) NOT NULL,
    estado         VARCHAR(20) NOT NULL,
    ci_cliente     VARCHAR(15) NOT NULL,
    FOREIGN KEY (ci_cliente) REFERENCES cliente(ci)
);

-- Préstamo (1) registra Pago (1..N)
-- saldo_restante es derivado (línea punteada): se calcula con consultas, no se guarda.
CREATE TABLE pago (
    id          INT PRIMARY KEY,
    monto       DECIMAL(12,2) NOT NULL,
    fecha       DATE NOT NULL,
    id_prestamo INT NOT NULL,
    FOREIGN KEY (id_prestamo) REFERENCES prestamo(id)
);
