DROP TABLE RELACION_CP;

DROP TABLE CLIENTE CASCADE;

DROP TABLE PRODUCTO_INVERSION CASCADE;

-- Comienzo creando las entidades y sus atributos, a los cuales aplico características y constraints.   

-- Creo Tabla CLIENTE
CREATE TABLE CLIENTE (
    DNI VARCHAR(8) PRIMARY KEY, -- Clave primaria para identificar a cada cliente
    Apellido_nombre VARCHAR(50) NOT NULL, 
    Ingresos_Mensuales NUMERIC(10, 2) NOT NULL,
    Capital_Disponible NUMERIC(10, 2) NOT NULL,
    Perfil_Inversor VARCHAR(15) NOT NULL CHECK (Perfil_Inversor IN ('Conservador', 'Moderado', 'Dinámico')), 
    Objetivo_Inversion VARCHAR(50) NOT NULL CHECK (Objetivo_Inversion IN ( 
        'Cobertura sobre dólar oficial',
        'Liquidez',
        'Tasa',
        'Inflación',
        'Crecimiento de la economía',
        'Rentabilidad en dólares',
        'Diversificación de activos',
        'Estrategia activa',
        'Lecaps'
    ))
);

-- Creo Tabla PRODUCTO_INVERSION
CREATE TABLE PRODUCTO_INVERSION (
    Nombre_producto VARCHAR(50) PRIMARY KEY, -- Clave primaria para cada producto
    Tipo_renta VARCHAR(20) NOT NULL CHECK (Tipo_renta IN ('Money Market', 'Renta Fija', 'Renta Variable',	'Renta Mixta')),
    Perfil_inversor VARCHAR(15) NOT NULL CHECK (Perfil_inversor IN ('Conservador', 'Moderado', 'Dinámico')),
    Objetivo_inversion VARCHAR(50) NOT NULL CHECK (Objetivo_inversion IN (
        'Cobertura sobre dólar oficial',
        'Liquidez',
        'Tasa',
        'Inflación',
        'Crecimiento de la economía',
        'Rentabilidad en dólares',
        'Diversificación de activos',
        'Estrategia activa',
        'Lecaps'
    )),
    Rentabilidad NUMERIC(5, 2), -- Valor en porcentaje de la rentabilidad que dejó el prod. a la fecha
    Composicion TEXT -- Descripción detallada de los activos que componen al producto
);


-- Tabla RELACION_CP (Relación N:N entre CLIENTE y PRODUCTO_INVERSION)
CREATE TABLE RELACION_CP (
    DNI VARCHAR(8) REFERENCES CLIENTE(DNI), -- FK hacia CLIENTE
    Nombre_producto VARCHAR(50) REFERENCES PRODUCTO_INVERSION(Nombre_producto), -- FK hacia PRODUCTO_INVERSION
    PRIMARY KEY (DNI, Nombre_producto) -- Clave primaria compuesta
);


-- Inserto datos en Tabla CLIENTE

INSERT INTO CLIENTE (DNI, Apellido_nombre, Ingresos_Mensuales, Capital_Disponible, Perfil_Inversor, Objetivo_Inversion)
VALUES
('33789123', 'San Martín, José', 1500000.00, 500000.00, 'Dinámico', 'Rentabilidad en dólares'),
('09123456', 'Roca, Julio', 800000.00, 150000.00, 'Conservador', 'Liquidez'),
('14812378', 'Azurduy, Juana', 950000.00, 300000.00, 'Moderado', 'Cobertura sobre dólar oficial'),
('15432879', 'Guemes, Martin', 1450000.00, 200000.00, 'Conservador', 'Diversificación de activos'),
('17456231', 'Sanchez, Mariquita', 1700000.00, 550000.00, 'Moderado', 'Estrategia activa'),
('23478091', 'Sarmiento, Domingo', 650000.00, 100000.00, 'Moderado', 'Rentabilidad en dólares'),
('14812765', 'Grierson, Cecilia', 1800000.00, 600000.00, 'Dinámico', 'Crecimiento de la economía');


-- Inserto datos en PRODUCTO_INVERSION
INSERT INTO PRODUCTO_INVERSION (Nombre_producto, Tipo_renta, Rentabilidad, Composicion, Perfil_inversor, Objetivo_inversion)
VALUES
('Alpha Pesos', 'Money Market', 55.83,'"Disponibilidades 38,62%, Plazos Fijos 27,34%, Plazos Fijos Precancelables 19,05%, Cauciones y Pases 12,70%"', 'Conservador','Liquidez'),
('Alpha Ahorro', 'Renta Fija', 61.95, '"Letras Tesoro ARS 65,75%, Plazos Fijos 20,50%, Obligaciones Negociables 8,18%, Fideicomisos Financieros 5,61%, Títulos Públicos CER 0,30% y Fondos Comunes de Inversión 0,17%"', 'Moderado', 'Liquidez'),
('Alpha Renta Plus', 'Renta Fija', 59.96, '"Letras del Tesoro 70,93%, Obligaciones Negociables 10,35%, Títulos Públicos CER ARS 8,43%, Fideicomisos Financieros 8,26%, Títulos Públicos ARS 2,06% y Fondos Comunes de Inversión 1,07%"', 'Moderado', 'Tasa'),
('Alpha Planeamiento Conservador', 'Renta Fija', 61.85, '"Letras del Tesoro ARS 49,65%, Títulos Públicos CER ARS 25,85%, Obligaciones Negociables (ARS) 9,18%, Obligaciones Negociables (Dólar Linked) 5,79%, Fondos Comunes de Inversión 3,44%, Fideicomisos Financieros 3,21% y Disponibilidades 2,40%"', 'Conservador', 'Diversificación de activos'),
('Alpha Renta Capital Pesos', 'Renta Fija', 59.39, '"Títulos Públicos CER ARS 76,59%, Letras del Tesoro 20,57%, Fondos Comunes de Inversión 3,13%, Títulos Públicos ARS 0,23%, Obligaciones Negociables ARS 0,21%, Disponibilidades 0,01%"', 'Moderado', 'Inflación'),
('Alpha Renta Cobertura', 'Renta Fija', 32.58, '"Letras del Tesoro (ARS) 49,80%, Obligaciones Negociables (Dólar Linked) 47,66%, Futuros 46,95%, Obligaciones Negociables USD 1,73%, Titulos Publicos CER ARS 1,27%, Fondos Comunes de Inversión 1,24%"', 'Moderado', 'Cobertura sobre dólar oficial'),
('Alpha Renta Fija Global', 'Renta Fija', 3.83, '"Bonos Corporativos Int. (Mercosur) en USD 52,45%, Disponibilidades 21,29%, Bonos del Tesoro USD 15,24%, Títulos Públicos USD Mercosur 8,84%, Bonos Corporativos Int. en USD 3,28%"', 'Moderado', 'Rentabilidad en dólares'),
('Alpha Renta Fija Serie 4', 'Renta Fija', 71.06, '"Letras del Tesoro ARS 95,93%, Fondos Comunes de Inversión 3,63%"', 'Moderado', 'Lecaps'),
('Alpha Retorno Total', 'Renta Mixta', 100.03, '"Acciones ARS 39,36%, Letras del Tesoro (ARS) 0,3831%, Títulos Públicos USD 0,1041%, Títulos Públicos ARS 0,0454%, Disponibilidades 2,89%, Fondos Comunes de Inversión 2,86%, Acciones Extranjeras 2,22%"', 'Moderado', 'Estrategia activa'),
('Alpha Planeamiento Equilibrado', 'Renta Mixta', 73.64, '"Letras del Tesoro (ARS) 52,50%, Acciones ARS 26,14%, Títulos Públicos CER ARS 7,02%, Fondos Comunes de Inversión 5,50%, Obligaciones Negociables (Dólar Linked) 3,56%, Disponibilidades 3,42%, Obligaciones Negociables ARS 2,93%, Fideicomisos Financieros ARS 1,39%, Títulos Públicos USD 0,42%, Acciones Extranjeras 0,36%"', 'Moderado', 'Diversificación de activos'),
('Alpha Planeamiento Dinámico', 'Renta Mixta', 82.53, '"Acciones ARS 45,28%, Letras del Tesoro (ARS) 34,89%, Títulos Públicos USD 11,53%, Obligaciones Negociables ARS 2,60%, Disponibilidades 2,29%, Fideicomisos Financieros 2,18%, Fondos Comunes de Inversión 1,67%, Acciones Extranjeras 0,79%, Títulos Públicos ARS 0,02%"', 'Dinámico', 'Diversificación de activos'),
('Alpha Recursos Naturales', 'Renta Variable', 36.83, '"Acciones Ordinarias en Pesos 74,33%, CEDEAR (Acciones) en Pesos 24,14%, Fondo Común de Inversión 1,15%, Disponibilidades 1,15%"', 'Dinámico', 'Crecimiento de la economía'),
('Alpha LATAM', 'Renta Variable', 11.30, '"Disponibilidades 19,01%, Acciones Ordinarias en Reales 27,63%, Acciones Ordinarias en Pesos 12,28%, Titulos Publicos Ley Extranjera en Dolares 21,00%, Acciones Ordinarias en Dólares 7,60%, Acciones Preferidas en Reales 13,73%"', 'Dinámico', 'Rentabilidad en dólares'),
('ALPHA ACCIONES', 'Renta Variable', 97.47, '"Acciones Ordinarias en Pesos 97,38%, Fondo común de Inversión en Pesos 2,16%, Disponibilidades 1,05%"', 'Dinámico', 'Inflación');


-- Realizo consultas a las Tablas creadas con opciones de SELECT. 

-- Selecciono solo los atributos Perfil Inversor y Objetivo Inversión de la Entidad CLIENTE
SELECT Perfil_inversor, 
Objetivo_inversion
FROM CLIENTE

--  Selecciono la selección de toda la tabla CLIENTE y PRODUCTO_INVERSION
SELECT * FROM CLIENTE;


SELECT * FROM PRODUCTO_INVERSION;

-- Selecciono solo ver el DNI y Perfil Inversor de la tabla CLIENTE, si este último es DINÁMICO
SELECT DNI, 
Perfil_inversor 
FROM CLIENTE
WHERE Perfil_inversor = 'Dinámico'


-- Selecciono en la tabla CLIENTE, en el atributo Apellido y Nombre, solo los que comienzan con la letra S
SELECT 
    DNI, 
    Apellido_nombre, 
    Perfil_Inversor, 
    Objetivo_Inversion 
FROM 
    CLIENTE 
WHERE 
    Apellido_nombre LIKE 'S%';



-- Ordeno de manera descendente la rentabilidad de los Productos
SELECT 
    Nombre_producto, 
    Tipo_renta, 
    Rentabilidad
FROM 
    PRODUCTO_INVERSION 
ORDER BY 
    Rentabilidad DESC;

--Agruparé a los clientes por Perfil inversor, mostrarando promedio de ingresos mensuales y capital disponible 
--para cada categoría. 

SELECT 
    Perfil_Inversor, 
    COUNT(*) AS Cantidad_Clientes, 
    AVG(Ingresos_Mensuales) AS Promedio_Ingresos, 
    AVG(Capital_Disponible) AS Promedio_Capital
FROM 
    CLIENTE
GROUP BY 
    Perfil_Inversor
ORDER BY 
    Perfil_Inversor;


-- Redondeare ingresos y capital a dos decimales para una mejor visualización
SELECT 
    Perfil_Inversor, 
    COUNT(*) AS Cantidad_Clientes, 
    ROUND(AVG(Ingresos_Mensuales), 2) AS Promedio_Ingresos, 
    ROUND(AVG(Capital_Disponible), 2) AS Promedio_Capital
FROM 
    CLIENTE
GROUP BY 
    Perfil_Inversor
ORDER BY 
    Perfil_Inversor;


-- Realizaré consultas con la función JOIN para verificar si el sistema cumple su objetivo de Recomendaciones

-- Verifico si con JOIN puedo hacer recomendaciones según perfil de riesgo y objetivo
SELECT 
c.DNI, 
c.Apellido_nombre AS Cliente, 
c.Perfil_Inversor, 
c.Objetivo_Inversion, 
p.Nombre_producto AS Producto_Sugerido, 
p.Rentabilidad 
FROM CLIENTE c 
JOIN PRODUCTO_INVERSION p 
ON c.Perfil_Inversor = p.Perfil_inversor AND c.Objetivo_Inversion = p.Objetivo_inversion;


-- Finalmente creare una vista para la visualización final 
CREATE VIEW Vis_CP AS
SELECT 
    c.DNI, 
    c.Apellido_nombre AS Cliente, 
    c.Perfil_Inversor, 
    c.Objetivo_Inversion, 
    p.Nombre_producto AS Producto_Sugerido, 
    p.Rentabilidad,
    p.Composicion
FROM 
    CLIENTE c
JOIN 
    PRODUCTO_INVERSION p 
ON 
    c.Perfil_Inversor = p.Perfil_inversor 
    AND c.Objetivo_Inversion = p.Objetivo_inversion;


SELECT * FROM VIS_CP
