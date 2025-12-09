-- EJERCICIO 3: CONTROL DE ESTUDIANTES
CREATE DATABASE IF NOT EXISTS colegio;
USE colegio;

CREATE TABLE estudiantes (
    id_estudiante INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    matricula_escolar VARCHAR(20) UNIQUE
);

CREATE TABLE cursos (
    id_curso INT AUTO_INCREMENT PRIMARY KEY,
    nombre_curso VARCHAR(50) NOT NULL
);

CREATE TABLE matriculas (
    id_matricula INT AUTO_INCREMENT PRIMARY KEY,
    id_estudiante INT,
    id_curso INT,
    FOREIGN KEY (id_estudiante) REFERENCES estudiantes(id_estudiante),
    FOREIGN KEY (id_curso) REFERENCES cursos(id_curso)
);

INSERT INTO estudiantes (nombre, matricula_escolar) VALUES ('Ana Lopez', 'A001');
INSERT INTO cursos (nombre_curso) VALUES ('Seguridad Informática');
INSERT INTO matriculas (id_estudiante, id_curso) VALUES (1, 1);