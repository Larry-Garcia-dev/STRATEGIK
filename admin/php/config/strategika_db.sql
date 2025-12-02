-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: localhost:3306
-- Tiempo de generación: 02-12-2025 a las 10:55:18
-- Versión del servidor: 10.6.20-MariaDB-cll-lve
-- Versión de PHP: 8.1.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `magnificapec_strategika_db`
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
(37, 11, '/uploads/6923d22845eb5_pmp2.jpg'),
(48, 13, '/uploads/6924aee77121d_1cd2bb5d-1e79-482c-a986-7ee9832adaf2.jpg'),
(49, 13, '/uploads/6924aee771667_7a3ee770-5326-47bb-9e3c-79ae8b38360d.jpg'),
(50, 13, '/uploads/6924aee7a1a9c_7bdda79b-6b32-4e1f-8fa2-8e06658aa4c5.jpg'),
(51, 13, '/uploads/6924aee7a1d75_7c47f835-0e54-4bca-b666-060bdc4c98cf.jpg'),
(52, 13, '/uploads/6924aee7a204e_9f9eb4bc-2cfb-4358-8a9b-b3dfe8114c7c.jpg'),
(53, 13, '/uploads/6924aee7a2351_26bbe860-4d43-4e76-b462-921d1f0aa8cd.jpg'),
(54, 13, '/uploads/6924aee7aba55_38ff2a7b-a874-4920-94de-1e81919eec4b.jpg'),
(55, 13, '/uploads/6924aee7abd2a_39acaa54-d677-471c-8a16-1ffd9f155ef5.jpg'),
(56, 13, '/uploads/6924aee7ac064_92ad97a7-799a-43c5-a5ce-11515024cf76.jpg'),
(57, 13, '/uploads/6924aee7ac34b_435d8539-ba38-4b7f-9969-107dae6cb8c8.jpg'),
(58, 14, '/uploads/6924b06254d5b_BAÑO LAVAMANOS.jpg'),
(59, 14, '/uploads/6924b06255200_ESTANTE DE TV -SALA.jpg'),
(60, 14, '/uploads/6924b06255426_PAGINA 4.jpg'),
(61, 14, '/uploads/6924b06255674_PAGINA 5.jpg'),
(62, 14, '/uploads/6924b06255941_PORTADA.jpeg'),
(63, 14, '/uploads/6924b06255c0d_VISTA LATERAL CASA.jpeg'),
(64, 14, '/uploads/6924b06255fda_WhatsApp Image 2025-03-18 at 10.19.51 AM (1).jpeg'),
(65, 14, '/uploads/6924b06256236_WhatsApp Image 2025-03-18 at 10.19.51 AM.jpeg'),
(66, 14, '/uploads/6924b062564e9_WhatsApp Image 2025-03-18 at 10.19.59 AM (2).jpeg'),
(67, 14, '/uploads/6924b06256786_ZONA DE PISCINA.jpg'),
(88, 15, '/uploads/6924b1a96930a_3.JPG'),
(89, 15, '/uploads/6924b1abb2e8b_25.JPG'),
(90, 15, '/uploads/6924b1abd6cce_IMG_7921.JPG'),
(91, 15, '/uploads/6924b1abd8cb0_IMG_7935.JPG'),
(92, 15, '/uploads/6924b1abe0e6d_IMG_7937.JPG'),
(93, 15, '/uploads/6924b1abe3198_IMG_7938.JPG'),
(94, 15, '/uploads/6924b1abe5436_IMG_7947.JPG'),
(95, 15, '/uploads/6924b1abe6a0f_IMG_7954.JPG'),
(96, 15, '/uploads/6924b1abe8797_IMG_7955.JPG'),
(97, 15, '/uploads/6924b1abea3b3_IMG_7956.JPG'),
(98, 16, '/uploads/6924b2ab03080_PH1.jpg'),
(99, 16, '/uploads/6924b2ab033f4_PH2.jpg'),
(100, 16, '/uploads/6924b2ab0367c_PH3.jpg'),
(101, 16, '/uploads/6924b2ab0386a_PH4.jpg'),
(102, 16, '/uploads/6924b2ab03a3e_PH6.jpg'),
(103, 16, '/uploads/6924b2ab03c79_PH7.jpg'),
(104, 16, '/uploads/6924b2ab03e60_PH8.jpg'),
(105, 16, '/uploads/6924b2ab04080_PH45.jpg'),
(106, 17, '/uploads/6924b30b2b600_7bdda79b-6b32-4e1f-8fa2-8e06658aa4c5.jpg'),
(107, 17, '/uploads/6924b30b2bace_7c47f835-0e54-4bca-b666-060bdc4c98cf.jpg'),
(108, 17, '/uploads/6924b30b2be10_9f9eb4bc-2cfb-4358-8a9b-b3dfe8114c7c.jpg'),
(109, 17, '/uploads/6924b30b2c219_26bbe860-4d43-4e76-b462-921d1f0aa8cd.jpg'),
(110, 17, '/uploads/6924b30b2c595_38ff2a7b-a874-4920-94de-1e81919eec4b.jpg'),
(111, 17, '/uploads/6924b30b2c881_39acaa54-d677-471c-8a16-1ffd9f155ef5.jpg'),
(112, 17, '/uploads/6924b30b2cd5c_92ad97a7-799a-43c5-a5ce-11515024cf76.jpg'),
(113, 17, '/uploads/6924b30b2d077_92675749-921b-4de0-9a3c-8e34d5e0d58a.jpg'),
(114, 17, '/uploads/6924b30b2d478_bdf6b5fa-193c-416a-8f36-021f18ce3dc6.jpg'),
(115, 17, '/uploads/6924b30b2d713_c1a5dd60-6e5f-49d1-9029-5e20656f98a2.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `inmuebles`
--

CREATE TABLE `inmuebles` (
  `id` int(11) NOT NULL,
  `codigo` varchar(50) DEFAULT NULL,
  `titulo` varchar(255) NOT NULL,
  `tipo_oferta` enum('Venta','Arriendo') NOT NULL DEFAULT 'Arriendo',
  `precio` decimal(15,2) DEFAULT NULL,
  `descripcion_corta` text DEFAULT NULL,
  `descripcion_larga` text DEFAULT NULL,
  `ubicacion` varchar(100) DEFAULT NULL,
  `area` varchar(50) DEFAULT NULL,
  `canon_texto` varchar(100) DEFAULT NULL,
  `estado` enum('Disponible','No Disponible') DEFAULT 'Disponible',
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `inmuebles`
--

INSERT INTO `inmuebles` (`id`, `codigo`, `titulo`, `tipo_oferta`, `precio`, `descripcion_corta`, `descripcion_larga`, `ubicacion`, `area`, `canon_texto`, `estado`, `fecha_creacion`) VALUES
(11, '01', 'Parcelas Strategik 2', 'Arriendo', 1000000.00, 'Desarrollado en un terreno de 10 Hectáreas, sectorizado en 15 parcelas útiles, desde 2.000 m² hasta 17.899,75 m², con un valor comercial de $1.000.000 m².\r\n\r\n- Zona comercial integrada\r\n- Espacios colaborativos\r\n- Extensas áreas verdes', '¡Encuentre en Strategik 2, su nuevo epicentro empresarial diseñado para potenciar su empresa desde el primer momento! Con zona comercial integrada para diversificar su entorno, redes de servicios independientes para operar sin complicaciones, espacios colaborativos que impulsan la innovación y extensas áreas verdes para un ambiente laboral saludable y estimulante.\r\n\r\n¡Transforme su negocio y lidere el futuro!', 'Ubicado en el corredor Comercial y de Servicios en el Km 11 de la vía Ibagué-Picaleña-Bogotá, a la a', 'Desde 2.000 m² hasta 17.899,75 m²', '$1.000.000 m²', 'Disponible', '2025-11-24 03:34:00'),
(13, '03', 'BODEGA LA FRANCIA', 'Arriendo', 0.00, 'Excelente ubicación con alto flujo peatonal. Espacios iluminados...', 'Se arrienda local amplio ideal para negocio...', 'DIRECCION: CRA 4B DIAGONAL ENTRE CALLE 30 Y 31 # 30-65 SECTOR: LA FRANCIA IBAGUE TOLIMA', 'TERRENO: 1.190 M2 AREA UTIL: 1.330 M2', '0', 'Disponible', '2025-11-24 19:15:51'),
(14, '04', 'ALTOS DE LA CAROLINA CASA 12', 'Arriendo', 0.00, 'Excelente ubicación con alto flujo peatonal. Espacios iluminados...', 'Se arrienda local amplio ideal para negocio...', 'DIRECCION: CRA 20 SUR No 103-124 MANZANA 3 CASA No12 ALTOS DE LA CAROLINA ', ':236,98 M2', '0', 'No Disponible', '2025-11-24 19:17:00'),
(15, '02', 'BODEGA EL SALADO', 'Arriendo', 0.00, 'Excelente ubicación con alto flujo peatonal. Espacios iluminados...', 'Se arrienda local amplio ideal para negocio...', 'DIRECCION: CRA 8 No 129-45 SECTOR: EL SALADO IBAGUE TOLIMA', 'TERRENO: 2.145,37 M2 AREA UTIL: 2.636,48 M2', '0', 'Disponible', '2025-11-24 19:27:37'),
(16, '05', 'PENTHOUSE 1001', 'Venta', 0.00, 'Excelente ubicación con alto flujo peatonal. Espacios iluminados...', 'Viva en la cima. Este impresionante Penthouse ofrece un estilo de vida inigualable con terrazas privadas y las mejores vistas de la ciudad.', 'DIRECCION: CRA 18 A # 72-75 SECTOR: EL VERGEL IBAGUE TOLIMA', '185.35 M2 ', '0', 'Disponible', '2025-11-24 19:31:55'),
(17, '06', 'BODEGA CON OFICINAS ', 'Arriendo', 0.00, 'Excelente ubicación con alto flujo peatonal. Espacios iluminados...', 'Se arrienda local amplio ideal para negocio...', 'Cra 6 # 12 Esquina   -   cra 12 – 9 y por calle 16 -42  SECTOR: PUEBLO NUEVO', 'UTIL: 1.348 M2 AREA TERRENO: 1.048 M2.', '0', 'Disponible', '2025-11-24 19:33:31');

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
(1, 'admin', '$2y$10$RUi3DFTav3Hrpk9o6eg3B.kga9kRE8fdbX4e6Ya9WLESjGRceq6Ue', '2025-11-24 18:47:50');

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
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=116;

--
-- AUTO_INCREMENT de la tabla `inmuebles`
--
ALTER TABLE `inmuebles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

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
