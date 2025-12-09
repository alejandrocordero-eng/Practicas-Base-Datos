-- 1. Seleccionar todos los estudiantes
SELECT * FROM Estudiante;

-- 2. Listar solo los nombres y apellidos
SELECT Nombre, Apellido FROM Estudiante;

-- 3. Filtrar estudiantes de un departamento 
SELECT * FROM Estudiante 
WHERE DepartamentoID = 1;

-- 4. Ordenar estudiantes por fecha de nacimiento (más viejos primero)
SELECT * FROM Estudiante 
ORDER BY FechaNacimiento ASC;

-- 5. Contar cuántos estudiantes hay
SELECT COUNT(*) AS Total_Estudiantes FROM Estudiante;

-- 6. Buscar estudiantes con apellido 'García'
SELECT * FROM Estudiante 
WHERE Apellido = 'García';

-- 7. Buscar por patrón (nombres que empiezan con 'A')
SELECT * FROM Estudiante 
WHERE Nombre LIKE 'A%';

-- 8. Join: Mostrar nombre del estudiante y el nombre del departamento
SELECT E.Nombre, E.Apellido, D.Nombre AS Departamento
FROM Estudiante E
JOIN Departamento D ON E.DepartamentoID = D.DepartamentoID;

-- 9. Promedio de calificaciones por estudiante
SELECT E.Nombre, E.Apellido, AVG(C.Nota) AS Promedio_Notas
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID;

-- 10. Cantidad de estudiantes por departamento
SELECT D.Nombre AS Departamento, COUNT(E.EstudianteID) AS Cantidad_Estudiantes
FROM Departamento D
JOIN Estudiante E ON D.DepartamentoID = E.DepartamentoID
GROUP BY D.Nombre;

-- 11. Cursos impartidos por cada profesor
SELECT P.Nombre, P.Apellido, Cu.Nombre AS Curso_Impartido
FROM Profesor P
JOIN Clase Cl ON P.ProfesorID = Cl.ProfesorID
JOIN Curso Cu ON Cl.CursoID = Cu.CursoID;

-- 12. Estudiantes con promedio mayor a 90
SELECT E.Nombre, E.Apellido, AVG(C.Nota) AS Promedio
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID
HAVING Promedio > 90;

-- 13. Top 5 estudiantes con mejores promedios
SELECT E.Nombre, E.Apellido, AVG(C.Nota) AS Promedio
FROM Estudiante E
JOIN Inscripcion I ON E.EstudianteID = I.EstudianteID
JOIN Calificacion C ON I.InscripcionID = C.InscripcionID
GROUP BY E.EstudianteID
ORDER BY Promedio DESC
LIMIT 5;