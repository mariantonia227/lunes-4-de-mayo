-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 04-05-2026 a las 12:07:22
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.1.25

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `proyectoleafy`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios`
--

CREATE TABLE `comentarios` (
  `id_comentario` int(11) NOT NULL,
  `id_usuarios` int(11) NOT NULL,
  `comentario` text NOT NULL,
  `fecha` datetime NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `comentarios`
--

INSERT INTO `comentarios` (`id_comentario`, `id_usuarios`, `comentario`, `fecha`) VALUES
(1, 13, 'Hola! me encanta esta pagina', '2026-04-25 11:27:30'),
(2, 13, 'que genial esta todo!', '2026-04-29 17:43:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios_reacciones`
--

CREATE TABLE `comentarios_reacciones` (
  `id_reaccion` int(11) NOT NULL,
  `id_comentario` int(11) NOT NULL,
  `id_usuarios` int(11) NOT NULL,
  `tipo` varchar(20) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `comentarios_reportes`
--

CREATE TABLE `comentarios_reportes` (
  `id_reporte` int(11) NOT NULL,
  `id_comentario` int(11) NOT NULL,
  `id_usuarios` int(11) NOT NULL,
  `fecha` datetime NOT NULL DEFAULT current_timestamp(),
  `motivo` varchar(100) NOT NULL,
  `detalle` text NOT NULL,
  `estado_reporte` enum('pendiente','revisado') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `favoritos`
--

CREATE TABLE `favoritos` (
  `id_favorito` int(11) NOT NULL,
  `id_usuarios` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `fecha_agregado` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `imagenes_productos`
--

CREATE TABLE `imagenes_productos` (
  `id_imagen` int(11) NOT NULL,
  `id_producto` int(11) NOT NULL,
  `url_imagen` varchar(255) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `imagenes_productos`
--

INSERT INTO `imagenes_productos` (`id_imagen`, `id_producto`, `url_imagen`) VALUES
(1, 1, '1773945724_31736034-shirt-children-s-wear-boy-on-background.jpg'),
(2, 2, '1773946195_images.jpg'),
(3, 3, '1773946638_14782220-children-s-t-shirt-isolated-on-white-background-clipping-paths-included.jpg'),
(4, 4, '1773946909_ec83daa5f8ce064436707cc4a1d5023f.jpg'),
(5, 5, '1777605490_31736034-shirt-children-s-wear-boy-on-background.jpg');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `negocios`
--

CREATE TABLE `negocios` (
  `id_negocios` int(11) NOT NULL,
  `id_usuario` int(11) NOT NULL,
  `nombre_negocio` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `telefono` varchar(20) DEFAULT NULL,
  `direccion` varchar(255) DEFAULT NULL,
  `calificacion_promedio` decimal(3,1) NOT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp(),
  `estado` enum('pendiente','aprobado','rechazado','suspendido') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `negocios`
--

INSERT INTO `negocios` (`id_negocios`, `id_usuario`, `nombre_negocio`, `descripcion`, `telefono`, `direccion`, `calificacion_promedio`, `fecha_creacion`, `estado`) VALUES
(1, 8, 'cocatou ', 'ropa usada', '11111111111', 'bogota', 0.0, '2026-02-19 23:26:47', 'suspendido'),
(2, 9, 'cocatou ', 'ropa usada', '1234567890', 'bogota', 0.0, '2026-02-19 23:33:37', 'suspendido'),
(3, 10, 'cocatou ', 'ropa usada', '123456', 'bogota', 0.0, '2026-02-19 23:36:31', 'aprobado'),
(4, 11, 'cocatou ', 'ropa usada', '123456', 'bogota', 0.0, '2026-02-19 23:40:44', 'suspendido'),
(5, 12, 'cocatou ', 'ropa usada', '32475632', 'bogota', 0.0, '2026-03-19 18:21:43', 'aprobado');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `pedidos`
--

CREATE TABLE `pedidos` (
  `id_pedido` int(11) NOT NULL,
  `id_usuarios` int(11) NOT NULL,
  `id_negocios` int(11) NOT NULL,
  `fecha` datetime DEFAULT current_timestamp(),
  `total` decimal(10,2) NOT NULL,
  `estado_pedido` enum('pendiente','enviado','completado','cancelado') NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `productos`
--

CREATE TABLE `productos` (
  `id_producto` int(11) NOT NULL,
  `id_negocios` int(11) NOT NULL,
  `nombre` varchar(150) NOT NULL,
  `descripcion` text DEFAULT NULL,
  `precio` decimal(10,2) NOT NULL,
  `talla` varchar(20) DEFAULT NULL,
  `estado_producto` enum('disponible','vendido') NOT NULL DEFAULT 'disponible',
  `fecha_publicacion` datetime NOT NULL DEFAULT current_timestamp(),
  `categoria` varchar(50) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `productos`
--

INSERT INTO `productos` (`id_producto`, `id_negocios`, `nombre`, `descripcion`, `precio`, `talla`, `estado_producto`, `fecha_publicacion`, `categoria`) VALUES
(5, 5, 'camisa girs', 'Camisa gris con bolsillo en el pecho', 50.00, 'L', 'disponible', '2026-04-30 22:18:10', 'hombre');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id_usuarios` int(11) NOT NULL,
  `nombre` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `contraseña` varchar(255) NOT NULL,
  `tipo_usuario` enum('cliente','negocio','admin') NOT NULL,
  `fecha_registro` datetime NOT NULL DEFAULT current_timestamp(),
  `estado` enum('activo','incactivo') NOT NULL,
  `foto_perfil` varchar(255) DEFAULT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf32 COLLATE=utf32_spanish_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id_usuarios`, `nombre`, `email`, `contraseña`, `tipo_usuario`, `fecha_registro`, `estado`, `foto_perfil`) VALUES
(1, 'maria antonia', 'sarahluciacastellanos@gmail.com', '$2y$10$7/6AruOR1FhyY9gHx62qluXsY/t0/i0jTWDqc.3oR7fErVK9teq9y', 'cliente', '2026-02-11 02:15:25', 'activo', NULL),
(2, 'maria antonia', 'sara@gmail.com', '$2y$10$9IabJEQnu/ShRAGiMinJC.KGu3axG2bOgUEcXS7Ix3vpdGdezDUDW', 'cliente', '2026-02-11 02:38:29', 'activo', NULL),
(3, '123', 'anto@gmail.com', '$2y$10$HJEjsOpx2Z/3veEaMKMMVurAUA7IVhOOPwG1KX2/GYJvvVZkgIEku', 'cliente', '2026-02-11 02:39:33', 'activo', NULL),
(4, 'antonini', 'antonini@gmail.com', '$2y$10$/E7I03u5XOd.TyP3r/dlM.3cOfAZs23xUGIC088bGzyMUTH4xpGjy', 'negocio', '2026-02-19 17:41:45', 'activo', NULL),
(5, 'cuenta', 'cuenta@gmail.com', '$2y$10$61q7CbmAULyI3tZ93TYYFuLFvde/GKEC/P4TWLxoNdUNJ6HAofFxi', 'negocio', '2026-02-19 17:59:38', 'activo', NULL),
(6, '333', '333@gmail.com', '$2y$10$1IT7cAtuU8pnASgpuMo8vumoDuLE.Xt9L8huy12VpnO89ckV22dd.', 'negocio', '2026-02-19 18:13:39', 'activo', NULL),
(7, 'antonini', 'lololololol@gmail.com', '$2y$10$heNYnwqYvK3sFZYu/JKyWevqqHLs88vY7wMqvZycU6jXf1IWXtuCK', 'cliente', '2026-02-19 18:25:55', 'activo', NULL),
(8, 'caca', 'caca@gmail.com', '$2y$10$jN5t/wEwUeFkLS62Tt9J4eGfm/EAL/6JfMDFuBNvadASoZNeY8.pa', 'negocio', '2026-02-19 18:26:47', 'activo', NULL),
(9, 'FAK', 'FAK@gmail.com', '$2y$10$8RjrQPn6Bw10LxTaFEFqEOQkwT0.ChEcchROD3TW0kksylNHTb8dC', 'negocio', '2026-02-19 18:33:37', 'activo', NULL),
(10, 'colu', 'colu@gmail.com', '$2y$10$Fo9TN5izW489ElbxEe55NOnGYvixz5GydL1ORuHQc02rpTzxU3b9a', 'negocio', '2026-02-19 18:36:31', 'activo', NULL),
(11, 'cucu', 'cucu@gmail.com', '$2y$10$vlK.3ox3CafBBlaPkHYu7OBidSY/4wI0M9V/QwMEWFz0ULA5gwzea', 'negocio', '2026-02-19 18:40:44', 'activo', NULL),
(12, 'dorian', 'fifi@test.com', '$2y$10$bI4TQ7/ohIfdrzxf3g5eZu9S7lmt/zmw/Sgr6Z5EwNsh2rqlMLbhO', 'negocio', '2026-03-19 13:21:43', 'activo', '../uploads/1773945283_1.jpeg'),
(15, 'Maria Antonia', 'mariaantoniacastellanosgomez@gmail.com', '$2y$10$kevg8pmN92TMknEr5ffUKuWgucWRwqNsqFiGJhByHWsnOhJhotOOG', 'admin', '2026-04-29 19:18:56', 'activo', NULL);

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  ADD PRIMARY KEY (`id_comentario`);

--
-- Indices de la tabla `comentarios_reacciones`
--
ALTER TABLE `comentarios_reacciones`
  ADD PRIMARY KEY (`id_reaccion`);

--
-- Indices de la tabla `comentarios_reportes`
--
ALTER TABLE `comentarios_reportes`
  ADD PRIMARY KEY (`id_reporte`);

--
-- Indices de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  ADD PRIMARY KEY (`id_favorito`),
  ADD KEY `id_usuario` (`id_usuarios`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `imagenes_productos`
--
ALTER TABLE `imagenes_productos`
  ADD PRIMARY KEY (`id_imagen`),
  ADD KEY `id_producto` (`id_producto`);

--
-- Indices de la tabla `negocios`
--
ALTER TABLE `negocios`
  ADD PRIMARY KEY (`id_negocios`);

--
-- Indices de la tabla `productos`
--
ALTER TABLE `productos`
  ADD PRIMARY KEY (`id_producto`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id_usuarios`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `comentarios`
--
ALTER TABLE `comentarios`
  MODIFY `id_comentario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `comentarios_reacciones`
--
ALTER TABLE `comentarios_reacciones`
  MODIFY `id_reaccion` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `comentarios_reportes`
--
ALTER TABLE `comentarios_reportes`
  MODIFY `id_reporte` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `favoritos`
--
ALTER TABLE `favoritos`
  MODIFY `id_favorito` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de la tabla `imagenes_productos`
--
ALTER TABLE `imagenes_productos`
  MODIFY `id_imagen` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `negocios`
--
ALTER TABLE `negocios`
  MODIFY `id_negocios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `productos`
--
ALTER TABLE `productos`
  MODIFY `id_producto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id_usuarios` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
