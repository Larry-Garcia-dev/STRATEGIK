-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 24-11-2025 a las 19:23:34
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `strategika_db`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_inmueble`
--

CREATE TABLE `imagenes_inmueble` (
  `id` int(11) NOT NULL,
  `inmueble_id` int(11) DEFAULT NULL,
  `ruta_imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `imagenes_inmueble`
--

INSERT INTO `imagenes_inmueble` (`id`, `inmueble_id`, `ruta_imagen`) VALUES
(29, 11, '/uploads/6923d2283d72f_area_parque2.jpg'),
(30, 11, '/uploads/6923d2283f359_parcelas_parque2.jpg'),
(31, 11, '/uploads/6923d228401f5_parque2.jpg'),
(32, 11, '/uploads/6923d228414e4_parque2_1.jpg'),
(33, 11, '/uploads/6923d22842a20_parque2_2.jpg'),
(34, 11, '/uploads/6923d22843973_parque2_3.jpg'),
(35, 11, '/uploads/6923d228446b9_parque2_4.jpg'),
(36, 11, '/uploads/6923d228452d5_parque2_5.jpg'),
(37, 11, '/uploads/6923d22845eb5_pmp2.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `precio` decimal(15,2) DEFAULT NULL,
  `descripcion_corta` text DEFAULT NULL,
  `descripcion_larga` text DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `canon_texto` varchar(100) DEFAULT NULL,
  `estado` enum('Disponible','Arrendado') DEFAULT 'Disponible',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `codigo`, `titulo`, `precio`, `descripcion_corta`, `descripcion_larga`, `ubicacion`, `area`, `canon_texto`, `estado`, `fecha_creacion`) VALUES
(11, '01', 'Parcelas Strategik 2', 1000000.00, 'Desarrollado en un terreno de 10 Hectáreas, sectorizado en 15 parcelas útiles, desde 2.000 m² hasta 17.899,75 m², con un valor comercial de $1.000.000 m².\r\n\r\n- Zona comercial integrada\r\n- Espacios colaborativos\r\n- Extensas áreas verdes', '¡Encuentre en Strategik 2, su nuevo epicentro empresarial diseñado para potenciar su empresa desde el primer momento! Con zona comercial integrada para diversificar su entorno, redes de servicios independientes para operar sin complicaciones, espacios colaborativos que impulsan la innovación y extensas áreas verdes para un ambiente laboral saludable y estimulante.\r\n\r\n¡Transforme su negocio y lidere el futuro!', 'Ubicado en el corredor Comercial y de Servicios en el Km 11 de la vía Ibagué-Picaleña-Bogotá, a la a', 'Desde 2.000 m² hasta 17.899,75 m²', '$1.000.000 m²', 'Disponible', '2025-11-24 03:34:00');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios_admin`
--

CREATE TABLE `usuarios_admin` (
  `id` int(11) NOT NULL,
  `usuario` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `ultimo_acceso` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `usuarios_admin`
--

INSERT INTO `usuarios_admin` (`id`, `usuario`, `password`, `ultimo_acceso`) VALUES
(1, 'admin', '$2y$10$RUi3DFTav3Hrpk9o6eg3B.kga9kRE8fdbX4e6Ya9WLESjGRceq6Ue', '2025-11-24 03:29:19');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `imagenes_inmueble`
--
ALTER TABLE `imagenes_inmueble`
  ADD PRIMARY KEY (`id`),
  ADD KEY `inmueble_id` (`inmueble_id`);

--
-- Indices de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  ADD PRIMARY KEY (`id`);

--
-- Indices de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `usuario` (`usuario`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `imagenes_inmueble`
--
ALTER TABLE `imagenes_inmueble`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=38;

--
-- AUTO_INCREMENT de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT de la tabla `usuarios_admin`
--
ALTER TABLE `usuarios_admin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `imagenes_inmueble`
--
ALTER TABLE `imagenes_inmueble`
  ADD CONSTRAINT `imagenes_inmueble_ibfk_1` FOREIGN KEY (`inmueble_id`) REFERENCES `inmuebles` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
