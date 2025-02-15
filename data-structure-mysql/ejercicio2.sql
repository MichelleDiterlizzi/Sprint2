

DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;

CREATE TABLE cliente (
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(50) NOT NULL,
    direccion VARCHAR(50) NOT NULL,
    codigo_postal INT NOT NULL,
    localidad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    telefono VARCHAR(15) NOT NULL
);

CREATE TABLE botiga(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    direccion VARCHAR(100) NOT NULL,
    codigo_postal INT NOT NULL,
    localidad VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL
);

CREATE TABLE categoria(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL
);

CREATE TABLE producto(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    imagen BLOB,
    precio DOUBLE NOT NULL,
    tipo ENUM ('pizza', 'hamburguesa', 'bebida') NOT NULL,
    id_categoria INT UNSIGNED,
    FOREIGN KEY (id_categoria) REFERENCES categoria(id) ON DELETE SET NULL,
    CHECK (tipo = 'pizza' OR id_categoria IS NULL) 
);

CREATE TABLE comanda(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT UNSIGNED,
    fecha_hora DATETIME,
    tipo_recogida ENUM('a domicilio', 'recogida') NOT NULL,
    cantidad_productos INT NOT NULL,
    precio DOUBLE NOT NULL,
    id_botiga INT UNSIGNED,
    FOREIGN KEY (id_botiga) REFERENCES botiga(id) ON DELETE SET NULL,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id) ON DELETE SET NULL
);

CREATE TABLE comandas_productos(
  id_comanda INT UNSIGNED,
  id_producto INT UNSIGNED,
  cantidad_productos INT NOT NULL,
  PRIMARY KEY (id_comanda, id_producto),
  FOREIGN KEY (id_comanda) REFERENCES comanda(id),
  FOREIGN KEY (id_producto) REFERENCES producto(id)
);

CREATE TABLE empleado(
    id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL,
    apellidos VARCHAR(100) NOT NULL,
    nif VARCHAR(50) NOT NULL UNIQUE,
    telefono VARCHAR(15) NOT NULL,
    tipo ENUM('cocinero', 'repartidor') NOT NULL,
    id_botiga INT UNSIGNED,
    FOREIGN KEY (id_botiga) REFERENCES botiga(id) ON DELETE SET NULL
);

CREATE TABLE comanda_domicilio (
    id_comanda INT UNSIGNED PRIMARY KEY,
    id_repartidor INT UNSIGNED,
    fecha_entrega DATETIME NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES comanda(id) ON DELETE CASCADE,
    FOREIGN KEY (id_repartidor) REFERENCES empleado(id) ON DELETE SET NULL
);

