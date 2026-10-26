-- Ejemplo 3: Clínica médica
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL
-- Especialidad, Paciente y Medicamentos no tienen atributos en el enunciado: solo se agrega su clave.

CREATE TABLE especialidad (
    id_especialidad INT PRIMARY KEY
);

CREATE TABLE paciente (
    id_paciente INT PRIMARY KEY
);

CREATE TABLE medicamentos (
    id_medicamento INT PRIMARY KEY
);

-- Cada médico pertenece a una especialidad (Especialidad 1..N, Médico 1)
CREATE TABLE medico (
    id_medico       INT PRIMARY KEY,
    id_especialidad INT NOT NULL,
    FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)
);

-- Cada cita la atiende un médico a un paciente, en fecha, hora y consultorio
CREATE TABLE cita (
    id_cita     INT PRIMARY KEY,
    fecha       DATE NOT NULL,
    hora        TIME NOT NULL,
    consultorio VARCHAR(30) NOT NULL,
    id_medico   INT NOT NULL,
    id_paciente INT NOT NULL,
    FOREIGN KEY (id_medico)   REFERENCES medico(id_medico),
    FOREIGN KEY (id_paciente) REFERENCES paciente(id_paciente)
);

-- De algunas citas se genera una receta (0..1): UNIQUE evita más de una receta por cita
CREATE TABLE receta (
    id_receta INT PRIMARY KEY,
    id_cita   INT NOT NULL UNIQUE,
    FOREIGN KEY (id_cita) REFERENCES cita(id_cita)
);

-- Receta (N:M) Medicamentos: la dosis y la duración son de cada medicamento dentro de la receta
CREATE TABLE receta_medicamento (
    id_receta      INT NOT NULL,
    id_medicamento INT NOT NULL,
    dosis          VARCHAR(60) NOT NULL,
    duracion       VARCHAR(60) NOT NULL,
    PRIMARY KEY (id_receta, id_medicamento),
    FOREIGN KEY (id_receta)      REFERENCES receta(id_receta),
    FOREIGN KEY (id_medicamento) REFERENCES medicamentos(id_medicamento)
);