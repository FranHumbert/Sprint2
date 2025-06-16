DROP DATABASE IF EXISTS optica_cul_ampolla;
CREATE DATABASE optica_cul_ampolla CHARACTER SET utf8mb4;
USE optica_cul_ampolla;

CREATE TABLE proveidors (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(60) NOT NULL,
    carrer  VARCHAR(60) NOT NULL, 
    numero VARCHAR(10) NOT NULL, 
    pis VARCHAR(10), 
    porta VARCHAR(10), 
    ciutat VARCHAR(60) NOT NULL, 
    codi_postal VARCHAR(10) NOT NULL, 
    pais VARCHAR(60) NOT NULL, 
    telefon VARCHAR(30) NOT NULL, 
    fax VARCHAR(30), 
    NIF VARCHAR(20) UNIQUE NOT NULL
    );
    
    CREATE TABLE marques (
	id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(60) NOT NULL UNIQUE,
    id_proveidor INT UNSIGNED NOT NULL,
    FOREIGN KEY (id_proveidor) REFERENCES proveidors (id) 
    );
    
    CREATE TABLE ulleres (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_marca INT UNSIGNED NOT NULL,
    graduacio_vidre_E DECIMAL(4.2), 
    graduacio_vidre_D DECIMAL(4.2),
    muntura ENUM('flotant', 'pasta', 'metalica') NOT NULL,
    color_muntura VARCHAR(30) NOT NULL,
    color_vidre_E VARCHAR(30) NOT NULL, 
	color_vidre_D VARCHAR(30) NOT NULL,
    preu DECIMAL(8.2) UNSIGNED NOT NULL,
    FOREIGN KEY(id_marca) REFERENCES marques(id)
    );
    
    CREATE TABLE clients (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(60) NOT NULL,
    cognom VARCHAR(60) NOT NULL,
    carrer  VARCHAR(60) NOT NULL, 
    numero VARCHAR(10) NOT NULL, 
    pis VARCHAR(10), 
    porta VARCHAR(10), 
    ciutat VARCHAR(60) NOT NULL, 
    codi_postal VARCHAR(10) NOT NULL, 
    pais VARCHAR(60) NOT NULL, 
    telefon VARCHAR(30) NOT NULL, 
    correu_electronic VARCHAR(100) NOT NULL, 
    data_registre DATE NOT NULL,
    id_client_recomanat INT UNSIGNED,
    FOREIGN KEY(id_client_recomanat) REFERENCES clients(id)
    );
    
    CREATE TABLE empleats (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    nom VARCHAR(60) NOT NULL,
    cognom VARCHAR(60) NOT NULL
    );
    
    CREATE TABLE vendes (
    id INT UNSIGNED PRIMARY KEY AUTO_INCREMENT,
    id_client INT UNSIGNED NOT NULL,
    id_empleat INT UNSIGNED NOT NULL,
    id_ulleres INT UNSIGNED NOT NULL,
    data_venda DATETIME NOT NULL,
    preu_venda DECIMAL(8,2) NOT NULL,
    FOREIGN KEY (id_client) REFERENCES clients(id),
    FOREIGN KEY (id_empleat) REFERENCES empleats(id),
    FOREIGN KEY (id_ulleres) REFERENCES ulleres(id)
    );

INSERT INTO proveidors (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, NIF) VALUES
('Luxottica España', 'Carrer de Balmes', '145', '3', 'A', 'Barcelona', '08008', 'España', '+34 93 215 4567', '+34 93 215 4568', 'A12345678'),
('Safilo Ibérica', 'Gran Vía', '28', '5', 'B', 'Madrid', '28013', 'España', '+34 91 523 7890', '+34 91 523 7891', 'B23456789'),
('Essilor España', 'Carrer de Provença', '89', '2', 'C', 'Barcelona', '08029', 'España', '+34 93 487 1234', '+34 93 487 1235', 'C34567890'),
('Marchon Eyewear', 'Calle Serrano', '67', '4', 'A', 'Madrid', '28006', 'España', '+34 91 781 2345', '+34 91 781 2346', 'D45678901'),
('De Rigo Vision', 'Passeig de Gràcia', '112', '1', 'B', 'Barcelona', '08008', 'España', '+34 93 216 5678', '+34 93 216 5679', 'E56789012'),
('Maui Jim España', 'Calle Alcalá', '200', '6', 'C', 'Madrid', '28028', 'España', '+34 91 402 3456', '+34 91 402 3457', 'F67890123'),
('Oakley Iberia', 'Carrer del Consell de Cent', '334', '3', 'A', 'Barcelona', '08007', 'España', '+34 93 454 7890', '+34 93 454 7891', 'G78901234'),
('Persol España', 'Calle Goya', '45', '2', 'B', 'Madrid', '28001', 'España', '+34 91 578 9012', '+34 91 578 9013', 'H89012345'),
('Silhouette Ibérica', 'Rambla de Catalunya', '78', '4', 'C', 'Barcelona', '08008', 'España', '+34 93 317 0123', '+34 93 317 0124', 'I90123456'),
('Lindberg España', 'Calle Velázquez', '134', '5', 'A', 'Madrid', '28006', 'España', '+34 91 563 1234', '+34 91 563 1235', 'J01234567');

INSERT INTO marques (nom, id_proveidor) VALUES
('Ray-Ban', 1),
('Oakley', 1),
('Gucci', 2),
('Prada', 2),
('Varilux', 3),
('Crizal', 3),
('Calvin Klein', 4),
('Nike', 4),
('Police', 5),
('Silhouette', 9);

INSERT INTO ulleres (id_marca, graduacio_vidre_E, graduacio_vidre_D, muntura, color_muntura, color_vidre_E, color_vidre_D, preu) VALUES
(1, -2.50, -2.25, 'pasta', 'negro', 'transparente', 'transparente', 189.99),
(2, 0.00, 0.00, 'metalica', 'plateado', 'gris', 'gris', 245.50),
(3, -1.75, -1.50, 'pasta', 'marrón', 'transparente', 'transparente', 320.00),
(4, -3.00, -3.25, 'metalica', 'dorado', 'transparente', 'transparente', 410.75),
(5, -0.75, -1.00, 'flotant', 'transparente', 'azul', 'azul', 156.25),
(6, -4.50, -4.75, 'pasta', 'rojo', 'transparente', 'transparente', 278.90),
(7, 0.00, 0.00, 'metalica', 'negro', 'marrón', 'marrón', 195.00),
(8, -1.25, -1.00, 'pasta', 'azul', 'transparente', 'transparente', 167.50),
(9, -2.00, -2.50, 'metalica', 'plateado', 'verde', 'verde', 298.75),
(10, -0.50, -0.75, 'flotant', 'transparente', 'rosa', 'rosa', 445.00);

INSERT INTO clients (nom, cognom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, correu_electronic, data_registre, id_client_recomanat) VALUES
('María', 'García López', 'Carrer Major', '15', '2', 'A', 'Barcelona', '08001', 'España', '+34 93 123 4567', 'maria.garcia@email.com', '2024-01-15', NULL),
('Juan', 'Martínez Ruiz', 'Calle Principal', '42', '1', 'B', 'Madrid', '28001', 'España', '+34 91 234 5678', 'juan.martinez@email.com', '2024-02-20', 1),
('Ana', 'Rodríguez Sánchez', 'Avinguda Diagonal', '123', '4', 'C', 'Barcelona', '08028', 'España', '+34 93 345 6789', 'ana.rodriguez@email.com', '2024-03-10', NULL),
('Carlos', 'López Fernández', 'Gran Vía', '67', '3', 'A', 'Madrid', '28013', 'España', '+34 91 456 7890', 'carlos.lopez@email.com', '2024-04-05', 2),
('Laura', 'Jiménez Torres', 'Passeig de Sant Joan', '89', '2', 'B', 'Barcelona', '08009', 'España', '+34 93 567 8901', 'laura.jimenez@email.com', '2024-05-12', 3),
('Pedro', 'Moreno Díaz', 'Calle Alcalá', '156', '5', 'C', 'Madrid', '28009', 'España', '+34 91 678 9012', 'pedro.moreno@email.com', '2024-06-18', NULL),
('Carmen', 'Herrera Vega', 'Rambla Catalunya', '78', '1', 'A', 'Barcelona', '08007', 'España', '+34 93 789 0123', 'carmen.herrera@email.com', '2024-07-22', 4),
('Miguel', 'Romero Castro', 'Calle Serrano', '234', '6', 'B', 'Madrid', '28006', 'España', '+34 91 890 1234', 'miguel.romero@email.com', '2024-08-30', 5),
('Isabel', 'Navarro Ramos', 'Carrer de Muntaner', '145', '3', 'C', 'Barcelona', '08036', 'España', '+34 93 901 2345', 'isabel.navarro@email.com', '2024-09-14', 6),
('Francisco', 'Gil Ortega', 'Calle Goya', '98', '4', 'A', 'Madrid', '28001', 'España', '+34 91 012 3456', 'francisco.gil@email.com', '2024-10-25', 7);

INSERT INTO empleats (nom, cognom) VALUES
('Alejandro', 'Pérez Martín'),
('Beatriz', 'González Ruiz'),
('David', 'Sánchez López'),
('Elena', 'Fernández García'),
('Fernando', 'Torres Jiménez'),
('Gloria', 'Díaz Moreno'),
('Héctor', 'Vega Herrera'),
('Irene', 'Castro Romero'),
('Javier', 'Ramos Navarro'),
('Lucía', 'Ortega Gil');

INSERT INTO vendes (id_client, id_empleat, id_ulleres, data_venda, preu_venda) VALUES
(10, 1, 1, '2024-01-20 10:30:00', 189.99),
(2, 1, 2, '2024-02-25 14:15:00', 245.50),
(3, 3, 3, '2024-03-15 11:45:00', 320.00),
(4, 4, 4, '2024-04-10 16:20:00', 410.75),
(5, 5, 5, '2024-05-18 09:30:00', 156.25),
(6, 6, 6, '2024-06-22 13:10:00', 278.90),
(7, 7, 7, '2024-07-28 15:45:00', 195.00),
(8, 8, 8, '2024-09-05 12:00:00', 167.50),
(9, 9, 9, '2024-09-20 17:30:00', 298.75),
(10, 10, 10, '2024-11-02 10:15:00', 445.00);
