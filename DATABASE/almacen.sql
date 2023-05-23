CREATE DATABASE ALMACEN;

USE ALMACEN;

CREATE TABLE persona
(
	idpersona		INT AUTO_INCREMENT PRIMARY KEY,
	apellidos		VARCHAR(30) NOT NULL,
	nombres			VARCHAR(30) NOT NULL,
	telefono			CHAR(9) NOT NULL,
	correo			VARCHAR(50) NOT NULL,
	dni				CHAR(8) NOT NULL,
	estado 			CHAR(1) NOT NULL DEFAULT '1',
	CONSTRAINT uk_persona_pe UNIQUE(dni)

)ENGINE=INNODB;

INSERT INTO persona (apellidos, nombres, telefono, correo, dni) VALUES
	('Camacho Sancho', 'Victor Jesus', 987654321 ,'Jesusito123@gmail.com',60210348),
	('Maldini Cusi', 'Luis David', 988446632 ,'David06@gmail.com',70437285),
	('Ramos Cartagena', 'Jimena Nicol', 955728392 ,'Jimena455@gmail.com',71928949),
	('Araujo Kounde', 'Messi Neymar', 912436283  ,'Messipsg@gmail.com', 69436003);
	
SELECT * FROM persona;

CREATE TABLE usuario
(
	idusuario			INT AUTO_INCREMENT PRIMARY KEY,
	idpersona			INT NOT NULL,
	nombreusuario		VARCHAR(30) NOT NULL,
	contraseña			VARCHAR(30) NOT NULL,
	estado				CHAR(1) NOT NULL DEFAULT '1',
	CONSTRAINT fk_idpersona_sub FOREIGN KEY (idpersona) REFERENCES persona (idpersona),
	CONSTRAINT uk_usuario_us UNIQUE (nombreusuario)
)ENGINE=INNODB;

INSERT INTO usuario (idpersona, nombreusuario, contraseña) VALUES
	(1, 'Jesus12', '12345'),
	(2, 'David06', '12344'),
	(3, 'Jimena28', '12346'),
	(4, 'Messi10', '12348');
	
SELECT * FROM usuario;
	
CREATE TABLE cargos
(
	idcargo		INT AUTO_INCREMENT PRIMARY KEY,
	idpersona 	INT NOT NULL,
	cargo			VARCHAR(50) NOT NULL,
	CONSTRAINT fk_idpersona_car FOREIGN KEY (idpersona) REFERENCES persona (idpersona)
)ENGINE=INNODB;

INSERT INTO cargos (idpersona, cargo) VALUES
	(2, 'Gerente'),
	(3, 'Operador de Montacargas'),
	(1, 'Receptor de Mercancia'),
	(4, 'Empacador');
	
SELECT * FROM cargos;

CREATE TABLE pedidos
(
	idpedido			INT AUTO_INCREMENT PRIMARY KEY,
	idpersona		INT,
	fechapedido		DATE NOT NULL,
	totalpedido		VARCHAR(50) NOT NULL,
	codigopedido	CHAR(4) NOT NULL,
	estado			CHAR(1) NOT NULL DEFAULT '1',
	CONSTRAINT fk_idpersona_ped FOREIGN KEY (idpersona) REFERENCES persona (idpersona),
	CONSTRAINT uk_codigopedido_us UNIQUE (codigopedido)
)ENGINE=INNODB;

INSERT INTO pedidos (idpersona, fechapedido, totalpedido, codigopedido) VALUES
	(1, '2024/03/15', '20 Cajas de libros', 'VJCS'),
	(2, '2023/12/08', '10 Mesas', 'LDMC'),
	(3, '2024/11/25', '30 Sillas', 'JNRC'),
	(4, '2024/09/03', '15 Computadoras', 'MNAK');


SELECT * FROM pedidos

CREATE TABLE entrega
(
	identrega 		INT AUTO_INCREMENT PRIMARY KEY,
	idpedido 		INT NOT NULL,
	fechalimite 	DATE NOT NULL,
	costodemora 	DECIMAL(7,2) NOT NULL,
	CONSTRAINT fk_idpedido_ped FOREIGN KEY (idpedido) REFERENCES pedidos (idpedido),
	CONSTRAINT ck_costodenora_ped CHECK(costodemora > 0)
)ENGINE=INNODB;

INSERT INTO entrega (idpedido, fechalimite, costodemora) VALUES
	(1, '2024-04-15', 20),
	(2, '2024/01/08', 50),
	(3, '2024/12/25', 40),
	(4, '2024/10/03', 70);

SELECT * FROM entrega;

CREATE TABLE productos
(
	idproducto			INT AUTO_INCREMENT PRIMARY KEY,
	nombreProducto		VARCHAR(50) NOT NULL,
	descripcion			VARCHAR(100) NOT NULL
)ENGINE=INNODB;

INSERT INTO productos (nombreProducto, descripcion) VALUES
	('Libros', 'Libros de la intitucion educativa nuestra señora del carmen'),
	('Mesas', 'Mesas de madera'),
	('Sillas', 'Sillas de madera'),
	('Computadoras', 'Computadoras DELL con teclado');

SELECT * FROM productos;

CREATE TABLE requesitos
(
	idrequisitos 	INT AUTO_INCREMENT PRIMARY KEY,
	pesoproducto	VARCHAR (15) NOT NULL,
	maxproducto		CHAR(3) NOT NULL,
	alturaproducto	VARCHAR(15) NOT NULL
)ENGINE=INNODB;

INSERT INTO requesitos (pesoproducto, maxproducto, alturaproducto) VALUES
	('400Kilos', '99 cajas', '60cm'),
	('800Kilos', '60 mesas', '80cm'),
	('450Kilos', '60 sillas', '40cm'),
	('900Kilos', '99 computadoras', '20cm');

SELECT * FROM requesitos;

CREATE TABLE almacen
(
	idalmacen			INT AUTO_INCREMENT PRIMARY KEY,
	idrequisitos		INT NOT NULL,
	idproducto			INT NOT NULL,
	identrega         INT NOT NULL,
	fechallegada		DATE NOT NULL,
	fechasalida			DATE NOT NULL,
	ubicacionalmacen	VARCHAR(50) NOT NULL
)ENGINE=INNODB;

INSERT INTO almacen(idrequisitos, idproducto, identrega, fechallegada, fechasalida, ubicacionalmacen) VALUES
	(1, 1, 1, '2024/03/12', '2024/04/10', 'Sector 1'),
	(2, 2, 2, '2023/4/13', '2024/01/01', 'Sector 3'),
	(3, 3, 3, '2024/11/22', '2024/12/15', 'Sector 3'),
	(4, 4, 4, '2024/09/01', '2024/10/02', 'Sector 5');


SELECT * FROM almacen;
