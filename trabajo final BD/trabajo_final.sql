-- =======================================================
-- TRABAJO FINAL: GESTIÓN ACADÉMICA
-- =======================================================

DROP DATABASE IF EXISTS gestion_academica;
CREATE DATABASE gestion_academica;
USE gestion_academica;

-- =======================================================
-- 1. DISEÑO DE TABLAS (DDL)
-- =======================================================

CREATE TABLE Departamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL
);

CREATE TABLE Estudiante (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    email VARCHAR(100) UNIQUE
);

CREATE TABLE Profesor (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Curso (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100),
    creditos INT,
    departamento_id INT,
    FOREIGN KEY (departamento_id) REFERENCES Departamento(id)
);

CREATE TABLE Clase (
    id INT AUTO_INCREMENT PRIMARY KEY,
    curso_id INT,
    profesor_id INT,
    semestre VARCHAR(20),
    FOREIGN KEY (curso_id) REFERENCES Curso(id),
    FOREIGN KEY (profesor_id) REFERENCES Profesor(id)
);

CREATE TABLE Inscripcion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    estudiante_id INT,
    clase_id INT,
    fecha_inscripcion DATE,
    FOREIGN KEY (estudiante_id) REFERENCES Estudiante(id),
    FOREIGN KEY (clase_id) REFERENCES Clase(id)
);

CREATE TABLE Calificacion (
    id INT AUTO_INCREMENT PRIMARY KEY,
    inscripcion_id INT,
    nota DECIMAL(5,2),
    FOREIGN KEY (inscripcion_id) REFERENCES Inscripcion(id)
);

-- =======================================================
-- 2. MANIPULACIÓN DE DATOS (DML)
-- =======================================================

-- Inserción de registros iniciales
INSERT INTO Departamento (nombre) VALUES ('Ingeniería de Sistemas'), ('Ciencias Básicas');

INSERT INTO Estudiante (nombre, email) VALUES 
('Juan Perez', 'juan@uni.edu'),
('Maria Gomez', 'maria@uni.edu');

INSERT INTO Profesor (nombre, departamento_id) VALUES 
('Dr. Alan Turing', 1),
('Dra. Marie Curie', 2);

INSERT INTO Curso (nombre, creditos, departamento_id) VALUES 
('Base de Datos', 4, 1),
('Física I', 3, 2);

INSERT INTO Clase (curso_id, profesor_id, semestre) VALUES 
(1, 1, '2023-1'),
(2, 2, '2023-1');

INSERT INTO Inscripcion (estudiante_id, clase_id, fecha_inscripcion) VALUES 
(1, 1, '2023-01-15'),
(2, 1, '2023-01-16');

INSERT INTO Calificacion (inscripcion_id, nota) VALUES 
(1, 95.5),
(2, 88.0);

-- Actualización de datos
UPDATE Estudiante SET email = 'juan.perez@nuevo.edu' WHERE id = 1;

-- Eliminación de datos
DELETE FROM Calificacion WHERE id = 1;

-- =======================================================
-- 3. CONSULTAS Y REPORTES
-- =======================================================

-- Consulta con JOINS (Relación Estudiante-Clase-Profesor)
SELECT 
    e.nombre AS Estudiante, 
    c.nombre AS Curso, 
    p.nombre AS Profesor,
    cl.semestre
FROM Inscripcion i
JOIN Estudiante e ON i.estudiante_id = e.id
JOIN Clase cl ON i.clase_id = cl.id
JOIN Curso c ON cl.curso_id = c.id
JOIN Profesor p ON cl.profesor_id = p.id;

-- Consulta Estadística (Promedio por curso)
SELECT 
    c.nombre AS Curso, 
    COUNT(cal.id) AS Cantidad_Notas,
    AVG(cal.nota) AS Promedio
FROM Calificacion cal
JOIN Inscripcion i ON cal.inscripcion_id = i.id
JOIN Clase cl ON i.clase_id = cl.id
JOIN Curso c ON cl.curso_id = c.id
GROUP BY c.nombre;
