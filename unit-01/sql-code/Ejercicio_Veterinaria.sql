-- Veterinaria
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE propietario (
    cedula    VARCHAR(15) PRIMARY KEY,
    nombres   VARCHAR(80) NOT NULL,
    apellidos VARCHAR(80) NOT NULL
);

-- telefono es multivaluado: tabla aparte
CREATE TABLE propietario_telefono (
    cedula   VARCHAR(15) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (cedula, telefono),
    FOREIGN KEY (cedula) REFERENCES propietario(cedula)
);

-- Propietario (1) lleva Mascota (1..N)
CREATE TABLE mascota (
    identificador    INT PRIMARY KEY,
    nombre           VARCHAR(60) NOT NULL,
    tipo             VARCHAR(40) NOT NULL,
    fecha_nacimiento DATE,
    cedula_propietario VARCHAR(15) NOT NULL,
    FOREIGN KEY (cedula_propietario) REFERENCES propietario(cedula)
);

-- Entidad débil: Familiar Contacto depende de Propietario (tiene, 1 a 1).
-- La clave es la del propietario + su propia cédula; UNIQUE refleja la relación 1:1 del diagrama.
CREATE TABLE familiar_contacto (
    cedula_propietario VARCHAR(15) NOT NULL,
    cedula             VARCHAR(15) NOT NULL,
    nombres            VARCHAR(80) NOT NULL,
    telefono           VARCHAR(20),
    PRIMARY KEY (cedula_propietario, cedula),
    UNIQUE (cedula_propietario),
    FOREIGN KEY (cedula_propietario) REFERENCES propietario(cedula)
);

CREATE TABLE personal (
    codigo INT PRIMARY KEY,
    cedula VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL
);

-- Especialización de Personal
CREATE TABLE veterinario (
    codigo       INT PRIMARY KEY,
    especialidad VARCHAR(80),
    fecha_alta   DATE,
    FOREIGN KEY (codigo) REFERENCES personal(codigo)
);

CREATE TABLE auxiliar (
    codigo          INT PRIMARY KEY,
    base_cotizacion DECIMAL(10,2),
    FOREIGN KEY (codigo) REFERENCES personal(codigo)
);

-- Mascota (0..N) asisten Consulta (1); Veterinario (1) atiende Consulta (1..N)
-- Consulta no tiene clave en el diagrama: se agrega id_consulta.
CREATE TABLE consulta (
    id_consulta     INT PRIMARY KEY,
    diagnostico     VARCHAR(300),
    identificador_mascota INT NOT NULL,
    codigo_veterinario    INT NOT NULL,
    FOREIGN KEY (identificador_mascota) REFERENCES mascota(identificador),
    FOREIGN KEY (codigo_veterinario)    REFERENCES veterinario(codigo)
);
