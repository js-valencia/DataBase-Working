-- Clínica médica
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Especialidad, Cliente y Medicamentos no tienen atributos en el diagrama: solo se agrega su clave.

CREATE TABLE especialidad (
    id_especialidad INT PRIMARY KEY
);

CREATE TABLE cliente (
    id_cliente INT PRIMARY KEY
);

CREATE TABLE medicamentos (
    id_medicamento INT PRIMARY KEY
);

-- Especialidad (1..N) tiene Médico (1)
CREATE TABLE medico (
    id_medico       INT PRIMARY KEY,
    id_especialidad INT NOT NULL,
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

-- Médico (1) atiende Cita (1..N), con consultorio como atributo de la relación
-- Cliente (1) solicita Cita (1..N)
CREATE TABLE cita (
    id_cita     INT PRIMARY KEY,
    fecha       DATE NOT NULL,
    hora        TIME NOT NULL,
    consultorio VARCHAR(30),
    id_medico   INT NOT NULL,
    id_cliente  INT NOT NULL,
    FOREIGN KEY (id_medico)  REFERENCES medico(id_medico),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id_cliente)
);

-- Cita (1) genera Receta (0..1): UNIQUE para que cada cita tenga como máximo una receta
CREATE TABLE receta (
    id_receta INT PRIMARY KEY,
    dosis     VARCHAR(60),
    duracion  VARCHAR(60),
    id_cita   INT NOT NULL UNIQUE,
    FOREIGN KEY (id_cita) REFERENCES cita(id_cita)
);

-- Receta (1..N) tiene Medicamentos (1..N)
CREATE TABLE receta_medicamento (
    id_receta      INT NOT NULL,
    id_medicamento INT NOT NULL,
    PRIMARY KEY (id_receta, id_medicamento),
    FOREIGN KEY (id_receta)      REFERENCES receta(id_receta),
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);
