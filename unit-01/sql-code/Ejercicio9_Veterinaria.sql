-- Ejercicio 9: Veterinaria
-- @author: js-valencia
-- Compatible con MySQL / MariaDB / PostgreSQL

CREATE TABLE propietario (
    cedula    VARCHAR(15) PRIMARY KEY,
    apellidos VARCHAR(80) NOT NULL,
    nombres   VARCHAR(80) NOT NULL,
    direccion VARCHAR(150)
);

-- teléfonos es multivaluado: tabla aparte
CREATE TABLE propietario_telefono (
    cedula   VARCHAR(15) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    PRIMARY KEY (cedula, telefono),
    FOREIGN KEY (cedula) REFERENCES propietario(cedula)
);

-- Una mascota la lleva uno y solo un propietario; un propietario lleva una o varias
CREATE TABLE mascota (
    identificador      INT PRIMARY KEY,
    nombre             VARCHAR(60) NOT NULL,
    fecha_nacimiento   DATE,
    tipo               VARCHAR(40) NOT NULL,
    cedula_propietario VARCHAR(15) NOT NULL,
    FOREIGN KEY (cedula_propietario) REFERENCES propietario(cedula)
);

-- Cada propietario tiene un familiar de contacto (entidad débil).
-- Si el propietario se da de baja, el familiar se elimina (ON DELETE CASCADE).
-- cedula es UNIQUE porque el familiar es contacto de un solo propietario.
CREATE TABLE familiar_contacto (
    cedula_propietario VARCHAR(15) PRIMARY KEY,
    cedula             VARCHAR(15) NOT NULL UNIQUE,
    nombre             VARCHAR(100) NOT NULL,
    telefono           VARCHAR(20),
    FOREIGN KEY (cedula_propietario) REFERENCES propietario(cedula) ON DELETE CASCADE
);

CREATE TABLE personal (
    codigo INT PRIMARY KEY,
    cedula VARCHAR(15) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL
);

-- Especialización de Personal (pueden existir otros tipos)
CREATE TABLE veterinario (
    codigo       INT PRIMARY KEY,
    fecha_alta   DATE,
    especialidad VARCHAR(80),
    FOREIGN KEY (codigo) REFERENCES personal(codigo)
);

CREATE TABLE auxiliar (
    codigo          INT PRIMARY KEY,
    base_cotizacion DECIMAL(10,2),
    FOREIGN KEY (codigo) REFERENCES personal(codigo)
);

-- Mascota (N:M) Veterinario: pasa consulta.
-- La fecha va en la clave porque una mascota puede consultar varias veces con el mismo veterinario.
CREATE TABLE consulta (
    identificador_mascota INT NOT NULL,
    codigo_veterinario    INT NOT NULL,
    fecha                 DATE NOT NULL,
    diagnostico           VARCHAR(300),
    PRIMARY KEY (identificador_mascota, codigo_veterinario, fecha),
    FOREIGN KEY (identificador_mascota) REFERENCES mascota(identificador),
    FOREIGN KEY (codigo_veterinario)    REFERENCES veterinario(codigo)
);