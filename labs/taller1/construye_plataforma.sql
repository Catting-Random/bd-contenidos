-- ============================================================
--  construye_plataforma.sql
--  Construye plataforma.db para el taller "Abrir el capó"
--  (Bases de Datos · Tema de introducción · Sesión 2)
--
--  Uso:   sqlite3 plataforma.db < construye_plataforma.sql
--  Tarda unos 10-20 segundos (genera 4 millones de escuchas).
--
--  Decisiones (ver LEEME_profesor.md):
--   · Solo USUARIO, CANCION y ESCUCHA. Ni LISTA, ni CONTIENE, ni
--     ARTISTA: son los descubrimientos del tema del modelo relacional.
--   · USUARIO y CANCION son pequeñas (se ven enteras en pantalla).
--   · ESCUCHA es grande y NO tiene índice: el bloque 4 lo crea.
--   · Sin claves foráneas declaradas: la integridad referencial
--     llega en la semana 2 del modelo relacional.
--    I love learing sql ("it's a joke")
-- ============================================================

PRAGMA journal_mode = DELETE;   -- modo de diario clásico: el bloque 3 lo asume
PRAGMA page_size = 4096;

DROP TABLE IF EXISTS ESCUCHA;
DROP TABLE IF EXISTS CANCION;
DROP TABLE IF EXISTS USUARIO;

-- ------------------------------------------------------------
-- USUARIO: seis filas, se ve entera. Restricciones para el bloque 2.
-- ------------------------------------------------------------
CREATE TABLE USUARIO (
    id_usuario        INTEGER PRIMARY KEY,
    nombre            TEXT    NOT NULL,
    email             TEXT    NOT NULL UNIQUE CHECK (email LIKE '%@%'),
    fecha_nacimiento  TEXT                                   -- puede faltar (Jon no la dio)
);

INSERT INTO USUARIO (id_usuario, nombre, email, fecha_nacimiento) VALUES
    (1, 'Carla',  'carla@mail.es',  '1999-03-14'),
    (2, 'María',  'maria@mail.es',  '2001-07-22'),
    (3, 'Hugo',   'hugo@mail.es',   '2002-11-02'),
    (4, 'Aitana', 'aitana@mail.es', '2003-05-30'),
    (5, 'Leo',    'leo@mail.es',    '1998-01-09'),
    (6, 'Jon',    'jon@mail.es',    NULL);

-- ------------------------------------------------------------
-- CANCION: seis filas. duracion en segundos, siempre positiva.
-- ------------------------------------------------------------
CREATE TABLE CANCION (
    id_cancion  INTEGER PRIMARY KEY,
    titulo      TEXT    NOT NULL,
    artista     TEXT    NOT NULL,
    duracion    INTEGER NOT NULL CHECK (duracion > 0),
    anio        INTEGER CHECK (anio BETWEEN 1900 AND 2100)
);

INSERT INTO CANCION (id_cancion, titulo, artista, duracion, anio) VALUES
    (1, 'Bohemian Rhapsody',  'Queen',        355, 1975),
    (2, 'Don''t Stop Me Now', 'Queen',        209, 1978),
    (3, 'Blinding Lights',    'The Weeknd',   200, 2019),
    (4, 'Love Story',         'Taylor Swift', 235, 2008),
    (5, 'Malamente',          'Rosalía',      148, 2018),
    (6, 'Tití Me Preguntó',   'Bad Bunny',    243, 2022);

-- ------------------------------------------------------------
-- ESCUCHA: el registro de reproducciones de TODA la plataforma.
-- 4 millones de filas, 50.000 usuarios (en USUARIO solo hemos
-- cargado seis para poder verla entera), sin índice.
-- ------------------------------------------------------------
CREATE TABLE ESCUCHA (
    id_usuario  INTEGER NOT NULL,
    id_cancion  INTEGER NOT NULL,
    fecha       TEXT    NOT NULL          -- 'AAAA-MM-DD HH:MM:SS'
);

-- Generación: una CTE recursiva cuenta hasta N y cada fila recibe
-- un usuario, una canción y una fecha al azar de los últimos 18 meses.
WITH RECURSIVE n(i) AS (
    SELECT 1
    UNION ALL
    SELECT i + 1 FROM n WHERE i < 4000000
)
INSERT INTO ESCUCHA (id_usuario, id_cancion, fecha)
SELECT
    1 + abs(random()) % 50000,
    1 + abs(random()) % 6,
    datetime('2025-03-01',
             '+' || (abs(random()) % 540) || ' days',
             '+' || (abs(random()) % 86400) || ' seconds')
FROM n;

-- Garantizamos que el usuario 4242 (el de la receta del bloque 4)
-- y María (id 2) tienen escuchas suficientes para que se vean.
INSERT INTO ESCUCHA (id_usuario, id_cancion, fecha)
WITH RECURSIVE k(i) AS (SELECT 1 UNION ALL SELECT i + 1 FROM k WHERE i < 120)
SELECT 4242, 1 + abs(random()) % 6,
       datetime('2026-01-01', '+' || (abs(random()) % 200) || ' days',
                              '+' || (abs(random()) % 86400) || ' seconds')
FROM k;

INSERT INTO ESCUCHA (id_usuario, id_cancion, fecha)
WITH RECURSIVE k(i) AS (SELECT 1 UNION ALL SELECT i + 1 FROM k WHERE i < 80)
SELECT 2, 1 + abs(random()) % 6,
       datetime('2026-01-01', '+' || (abs(random()) % 200) || ' days',
                              '+' || (abs(random()) % 86400) || ' seconds')
FROM k;

VACUUM;
