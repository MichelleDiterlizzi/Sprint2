En primer lloc, l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor: El nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF.

DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;

CREATE TABLE proveedor(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    calle VARCHAR(50) NOT NULL,
    numero INT NOT NULL,
    piso INT NOT NULL,
    puerta INT NOT NULL,
    ciudad VARCHAR(50) NOT NULL,
    codigo_postal VARCHAR(10) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    telefono VARCHAR(20) NOT NULL,
    fax VARCHAR(50) NOT NULL,
    nif VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE marca(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    id_proveedor INT UNSIGNED,
    FOREIGN KEY (id_proveedor) REFERENCES proveedor(id) ON DELETE SET NULL
);

CREATE TABLE modelo_gafa(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_marca INT UNSIGNED,
    graduacion_derecha VARCHAR(10) NOT NULL,
    graduacion_izquierda VARCHAR(10) NOT NULL,
    tipo_montura ENUM('flotante', 'pasta', 'metal'),
    color_montura VARCHAR(50) NOT NULL,
    color_cristales VARCHAR(50) NOT NULL,
    precio DECIMAL (10,2) NOT NULL,
    FOREIGN KEY (id_marca) REFERENCES marca(id) ON DELETE CASCADE
);

CREATE TABLE cliente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    direccion VARCHAR (50) NOT NULL,
    telefono VARCHAR (20) NOT NULL,
    correo_electronico VARCHAR(50) NOT NULL,
    fecha_registro DATE,
    recomandacion INT UNSIGNED,  
    FOREIGN KEY (recomandacion) REFERENCES cliente(id) ON DELETE SET NULL
);

CREATE TABLE empleado (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL
);

CREATE TABLE venta(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    fecha DATETIME,
    id_cliente INT UNSIGNED,
    id_empleado INT UNSIGNED,
    FOREIGN KEY (id_empleado) REFERENCES empleado(id) ON DELETE SET NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE SET NULL
);

CREATE TABLE venta_modelo_gafa(
    id_modelo_gafa INT UNSIGNED,
    id_venta INT UNSIGNED,
    cantidad_gafas INT,
    PRIMARY KEY(id_modelo_gafa, id_venta),
    FOREIGN KEY (id_modelo_gafa) REFERENCES modelo_gafa(id),
    FOREIGN KEY (id_venta) REFERENCES venta(id)
);