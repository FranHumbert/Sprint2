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

INSERT INTO proveidors (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES
('Òptiques Mediterrani SL', 'Carrer Major', '15', '2', 'A', 'Barcelona', '08001', 'Espanya', '934567890', '934567891', 'B12345678'),
('Visió Europa SA', 'Avinguda Diagonal', '245', NULL, NULL, 'Barcelona', '08013', 'Espanya', '932345678', '932345679', 'A23456789'),
('Lentes Ibérica SL', 'Carrer de la Pau', '78', '1', 'B', 'Madrid', '28001', 'Espanya', '915678901', '915678902', 'B34567890'),
('Monturas Premium SL', 'Gran Via', '123', '3', 'C', 'Madrid', '28013', 'Espanya', '914567890', '914567891', 'B45678901'),
('Òptica Catalana SA', 'Rambla Catalunya', '56', NULL, NULL, 'Barcelona', '08007', 'Espanya', '933456789', '933456790', 'A56789012'),
('Ulleres Modernes SL', 'Carrer Sant Antoni', '89', '2', 'A', 'València', '46001', 'Espanya', '963456789', '963456790', 'B67890123'),
('Cristals i Muntures SA', 'Avinguda del Port', '34', '1', 'D', 'Tarragona', '43001', 'Espanya', '977123456', '977123457', 'A78901234'),
('Proveïdor Òptic del Sud SL', 'Carrer Reial', '67', NULL, NULL, 'Sevilla', '41001', 'Espanya', '954123456', '954123457', 'B89012345'),
('Visió Internacional SA', 'Passeig de Gràcia', '102', '4', 'B', 'Barcelona', '08008', 'Espanya', '934123456', '934123457', 'A90123456'),
('Òptiques del Llevant SL', 'Carrer del Mar', '23', '1', 'A', 'Palma', '07001', 'Espanya', '971234567', '971234568', 'B01234567');

INSERT INTO marques (nom, id_proveidor) VALUES
('Ray-Ban', 1),
('Oakley', 2),
('Polaroid', 3),
('Vogue', 4),
('Carolina Herrera', 5),
('Armani', 6),
('Persol', 7),
('Lacoste', 8),
('Chanel', 9),
('Prada', 10),
('Tommy Hilfiger', 1),
('Guess', 2),
('Dolce & Gabbana', 3),
('LOOL', 4),
('THEO', 5),
('HOET', 6),
('MYKITA', 7),
('ANNE ET VALENTIN', 8),
('VASUMA', 9),
('ROLF', 10);
