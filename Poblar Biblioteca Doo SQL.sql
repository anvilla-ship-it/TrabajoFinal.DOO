USE biblioteca;

-- 1. CATEGORÍAS
INSERT INTO categorias (nombre)
SELECT 'Fantasía'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias WHERE nombre = 'Fantasía'
);

INSERT INTO categorias (nombre)
SELECT 'Ciencia ficción'
WHERE NOT EXISTS (
    SELECT 1 FROM categorias
    WHERE nombre = 'Ciencia ficción'
);

-- 2. USUARIOS
INSERT INTO usuarios
    (nombre, rut, correo, `contraseña`, rol)
SELECT
    'Usuario de prueba',
    '11111111-1',
    'prueba@biblioteca.cl',
    'cambiar123',
    'bibliotecario'
WHERE NOT EXISTS (
    SELECT 1 FROM usuarios
    WHERE rut = '11111111-1'
);

-- 3. ESTUDIANTES
INSERT INTO estudiantes
    (nombre, rut, curso, correo)
SELECT
    'Estudiante de prueba',
    '22222222-2',
    '2A',
    'estudiante@biblioteca.cl'
WHERE NOT EXISTS (
    SELECT 1 FROM estudiantes
    WHERE rut = '22222222-2'
);

-- 4. LIBROS
INSERT INTO libros
    (titulo, autor, isbn, editorial, stock, id_categoria)
SELECT
    'Juego de tronos',
    'George R. R. Martin',
    '9789563251951',
    'Debolsillo',
    5,
    c.id
FROM categorias c
WHERE c.nombre = 'Fantasía'
AND NOT EXISTS (
    SELECT 1 FROM libros
    WHERE isbn = '9789563251951'
)
LIMIT 1;

-- 5. PRÉSTAMOS
INSERT INTO prestamos
    (id_estudiante, id_libro, fecha_prestamo,
     fecha_devolucion, devuelto)
SELECT
    e.id,
    l.id,
    '2026-10-10',
    NULL,
    FALSE
FROM estudiantes e
JOIN libros l ON l.isbn = '9789563251951'
WHERE e.rut = '22222222-2'
AND NOT EXISTS (
    SELECT 1
    FROM prestamos p
    WHERE p.id_estudiante = e.id
      AND p.id_libro = l.id
      AND p.fecha_prestamo = '2026-10-10'
)
LIMIT 1;