DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE CLIENTS (
    id_client INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(60) NOT NULL,
    cognoms VARCHAR(60) NOT NULL,
    adreca VARCHAR(200) NOT NULL,
    codi_postal VARCHAR(10) NOT NULL,
    localitat VARCHAR(60) NOT NULL,
    provincia VARCHAR(60) NOT NULL,
    telefon VARCHAR(20) NOT NULL
);

CREATE TABLE BOTIGUES (
    id_botiga INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    adreca VARCHAR(200) NOT NULL,
    codi_postal VARCHAR(10) NOT NULL,
    localitat VARCHAR(60) NOT NULL,
    provincia VARCHAR(60) NOT NULL
);

CREATE TABLE EMPLEATS (
    id_empleat INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(50) NOT NULL,
    cognoms VARCHAR(100) NOT NULL,
    nif VARCHAR(15) UNIQUE NOT NULL,
    telefon VARCHAR(15) NOT NULL,
    tipus_empleat ENUM('cuiner', 'repartidor') NOT NULL,
    id_botiga INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_botiga) REFERENCES BOTIGUES(id_botiga)
);

CREATE TABLE CATEGORIES (
    id_categoria INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom_categoria VARCHAR(100) NOT NULL
);

CREATE TABLE PRODUCTES (
    id_producte INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(100) NOT NULL,
    descripcio TEXT,
    imatge VARCHAR(255),
    preu DECIMAL(8,2) NOT NULL,
    tipus_producte ENUM('pizza', 'hamburguesa', 'beguda') NOT NULL,
    id_categoria INT UNSIGNED NULL,
    FOREIGN KEY (id_categoria) REFERENCES CATEGORIES(id_categoria)
);

CREATE TABLE COMANDES (
    id_comanda INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    data_hora DATETIME NOT NULL,
    tipus_comanda ENUM('domicili', 'recollir') NOT NULL,
    preu_total DECIMAL(10,2) NOT NULL,
    id_client INT UNSIGNED NOT NULL,
    id_botiga INT UNSIGNED NOT NULL,
    id_repartidor INT UNSIGNED NULL,
    data_hora_lliurament DATETIME NULL,
    FOREIGN KEY (id_client) REFERENCES CLIENTS(id_client),
    FOREIGN KEY (id_botiga) REFERENCES BOTIGUES(id_botiga),
    FOREIGN KEY (id_repartidor) REFERENCES EMPLEATS(id_empleat)
);

CREATE TABLE DETALLS_COMANDA (
    id_detall INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_comanda INT UNSIGNED NOT NULL,
    id_producte INT UNSIGNED NOT NULL,
    quantitat INT NOT NULL,
    preu_unitari DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES COMANDES(id_comanda),
    FOREIGN KEY (id_producte) REFERENCES PRODUCTES(id_producte)
);

INSERT INTO CLIENTS (nom, cognoms, adreca, codi_postal, localitat, provincia, telefon) VALUES
('Maria', 'García López', 'Carrer de la Pau, 15', '08001', 'Barcelona', 'Barcelona', '934567890'),
('Joan', 'Martínez Pérez', 'Avinguda Diagonal, 234', '08013', 'Barcelona', 'Barcelona', '932345678'),
('Anna', 'Rodríguez Sánchez', 'Carrer Major, 45', '08002', 'Barcelona', 'Barcelona', '931234567'),
('Pere', 'Fernández Ruiz', 'Plaça Catalunya, 12', '08007', 'Barcelona', 'Barcelona', '935678901'),
('Laura', 'González Moreno', 'Carrer Balmes, 78', '08008', 'Barcelona', 'Barcelona', '936789012'),
('David', 'López Jiménez', 'Rambla Catalunya, 156', '08011', 'Barcelona', 'Barcelona', '937890123'),
('Carmen', 'Sánchez Herrera', 'Carrer Aragó, 289', '08009', 'Barcelona', 'Barcelona', '938901234'),
('Miguel', 'Pérez Castro', 'Via Laietana, 67', '08003', 'Barcelona', 'Barcelona', '939012345'),
('Elena', 'Moreno Vega', 'Carrer Muntaner, 123', '08036', 'Barcelona', 'Barcelona', '930123456'),
('Carlos', 'Jiménez Romero', 'Passeig de Gràcia, 89', '08008', 'Barcelona', 'Barcelona', '931234568');

-- Insertar datos en BOTIGUES
INSERT INTO BOTIGUES (adreca, codi_postal, localitat, provincia) VALUES
('Calle Pelaio, 25', '08001', 'Madrid', 'Madrid'),
('Avinguda Meridiana, 156', '08026', 'Madrid', 'Madrid'),
('Carrer Gran de Gràcia, 78', '08012', 'Barcelona', 'Barcelona'),
('Ronda Sant Pere, 45', '08010', 'Barcelona', 'Barcelona'),
('Carrer Sants, 234', '08014', 'Barcelona', 'Barcelona'),
('Avinguda Paral·lel, 67', '08004', 'Barcelona', 'Barcelona'),
('Carrer Provença, 189', '08036', 'Barcelona', 'Barcelona'),
('Via Augusta, 123', '08006', 'Barcelona', 'Barcelona'),
('Carrer Rosselló, 345', '08025', 'Barcelona', 'Barcelona'),
('Plaça Universitat, 12', '08007', 'Barcelona', 'Barcelona');

-- Insertar datos en EMPLEATS
INSERT INTO EMPLEATS (nom, cognoms, nif, telefon, tipus_empleat, id_botiga) VALUES
('Antonio', 'Ruiz García', '12345678A', '666111222', 'cuiner', 1),
('Francisco', 'Martín López', '23456789B', '666222333', 'repartidor', 1),
('José', 'Hernández Pérez', '34567890C', '666333444', 'cuiner', 2),
('Manuel', 'Jiménez Sánchez', '45678901D', '666444555', 'repartidor', 2),
('Rafael', 'Gómez Moreno', '56789012E', '666555666', 'cuiner', 3),
('Alejandro', 'Díaz Fernández', '67890123F', '666666777', 'repartidor', 3),
('Pablo', 'Álvarez Ruiz', '78901234G', '666777888', 'cuiner', 4),
('Sergio', 'Romero Castro', '89012345H', '666888999', 'repartidor', 4),
('Adrián', 'Torres Vega', '90123456I', '666999000', 'cuiner', 5),
('Daniel', 'Ramírez Herrera', '01234567J', '666000111', 'repartidor', 5);

-- Insertar datos en CATEGORIES (solo tipos de pizza)
INSERT INTO CATEGORIES (nom_categoria) VALUES
('Pizza Clàssica'),
('Pizza Especial'),
('Pizza Vegetariana'),
('Pizza Picant'),
('Pizza Gourmet'),
('Pizza Americana'),
('Pizza Italiana Tradicional'),
('Pizza Sense Tomàquet'),
('Pizza Dolça'),
('Pizza Regional');

-- Insertar datos en PRODUCTES (solo pizzas tienen categoría)
INSERT INTO PRODUCTES (nom, descripcio, imatge, preu, tipus_producte, id_categoria) VALUES
-- Pizzas con categoría
('Pizza Margherita', 'Pizza clàssica amb tomàquet, mozzarella i alfàbrega fresca', 'margherita.jpg', 12.50, 'pizza', 1),
('Pizza Pepperoni', 'Pizza americana amb tomàquet, mozzarella i pepperoni', 'pepperoni.jpg', 14.00, 'pizza', 6),
('Pizza Quattro Stagioni', 'Pizza italiana amb tomàquet, mozzarella, pernil, bolets, carxofes i olives', 'quattro.jpg', 16.50, 'pizza', 7),
('Pizza Vegetariana', 'Pizza amb verdures de temporada, tomàquet i mozzarella', 'vegetariana.jpg', 15.00, 'pizza', 3),
('Pizza Napolitana', 'Pizza tradicional amb tomàquet, mozzarella, anxoves, orégano i alcaparres', 'napolitana.jpg', 15.50, 'pizza', 7),
('Pizza Diávola', 'Pizza picant amb salami, xoriço, formatge fort i xili', 'diavola.jpg', 17.00, 'pizza', 4),
('Pizza Hawaiana', 'Pizza amb pernil dolç, pinya i mozzarella', 'hawaiana.jpg', 16.00, 'pizza', 6),
('Pizza Quattro Formaggi', 'Pizza amb mozzarella, gorgonzola, fontina i parmesà', 'quattro_formaggi.jpg', 18.00, 'pizza', 5),
-- Hamburguesas y bebidas SIN categoría (NULL)
('Hamburguesa Clàssica', 'Hamburguesa de vedella amb enciam, tomàquet i ceba', 'classic_burger.jpg', 9.50, 'hamburguesa', NULL),
('Coca-Cola', 'Beguda refrescant de cola', 'cocacola.jpg', 2.50, 'beguda', NULL);

-- Insertar datos en COMANDES
INSERT INTO COMANDES (data_hora, tipus_comanda, preu_total, id_client, id_botiga, id_repartidor, data_hora_lliurament) VALUES
('2025-06-15 12:30:00', 'domicili', 27.00, 1, 1, 2, '2025-06-15 13:15:00'),
('2025-06-15 13:45:00', 'recollir', 15.50, 2, 2, NULL, NULL),
('2025-06-15 14:20:00', 'domicili', 33.50, 3, 1, 2, '2025-06-15 15:05:00'),
('2025-06-15 15:10:00', 'recollir', 19.00, 4, 3, NULL, NULL),
('2025-06-15 16:00:00', 'domicili', 25.50, 5, 2, 4, '2025-06-15 16:45:00'),
('2025-06-14 19:30:00', 'domicili', 31.00, 6, 3, 6, '2025-06-14 20:15:00'),
('2025-06-14 20:15:00', 'recollir', 22.50, 7, 4, NULL, NULL),
('2025-06-14 21:00:00', 'domicili', 28.00, 8, 4, 8, '2025-06-14 21:45:00'),
('2025-06-13 18:45:00', 'recollir', 17.50, 9, 5, NULL, NULL),
('2025-06-13 19:30:00', 'domicili', 35.00, 10, 5, 10, '2025-06-13 20:15:00');

-- Insertar datos en DETALLS_COMANDA
INSERT INTO DETALLS_COMANDA (id_comanda, id_producte, quantitat, preu_unitari) VALUES
(1, 1, 1, 12.50),  -- Pizza Margherita
(1, 2, 1, 14.00),  -- Pizza Pepperoni
(2, 9, 1, 9.50),   -- Hamburguesa
(2, 10, 2, 2.50),  -- Coca-Cola
(3, 3, 2, 16.50),  -- Pizza Quattro Stagioni
(4, 4, 1, 15.00),  -- Pizza Vegetariana
(4, 10, 1, 2.50),  -- Coca-Cola
(5, 5, 1, 15.50),  -- Pizza Napolitana
(5, 6, 1, 17.00),  -- Pizza Diávola
(6, 7, 1, 16.00);  -- Pizza Hawaiana