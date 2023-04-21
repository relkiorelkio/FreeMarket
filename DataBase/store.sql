-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Apr 21, 2023 at 02:17 AM
-- Server version: 10.4.27-MariaDB
-- PHP Version: 8.2.0

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `store`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `EliminarProducto` (IN `codigo` INT)   BEGIN
    DELETE FROM producto WHERE CodigoProd = codigo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `administrador`
--

CREATE TABLE `administrador` (
  `Nombre` varchar(30) NOT NULL,
  `Clave` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `administrador`
--

INSERT INTO `administrador` (`Nombre`, `Clave`) VALUES
('admin', '21232f297a57a5a743894a0e4a801fc3');

-- --------------------------------------------------------

--
-- Table structure for table `categoria`
--

CREATE TABLE `categoria` (
  `CodigoCat` varchar(30) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `Descripcion` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `categoria`
--

INSERT INTO `categoria` (`CodigoCat`, `Nombre`, `Descripcion`) VALUES
('C1', 'Laptops', 'Computadores portatiles modernos'),
('C2', 'Smart TVs', 'Televisores inteligentes de alta definicion'),
('C3', 'Celulares', 'Teléfonos celulares smartphones');

-- --------------------------------------------------------

--
-- Table structure for table `cliente`
--

CREATE TABLE `cliente` (
  `RFC` varchar(30) NOT NULL,
  `Nombre` varchar(30) NOT NULL,
  `NombreCompleto` varchar(70) NOT NULL,
  `Apellido` varchar(70) NOT NULL,
  `Clave` text NOT NULL,
  `Direccion` varchar(200) NOT NULL,
  `Telefono` int(20) NOT NULL,
  `Email` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `cliente`
--

INSERT INTO `cliente` (`RFC`, `Nombre`, `NombreCompleto`, `Apellido`, `Clave`, `Direccion`, `Telefono`, `Email`) VALUES
('SARJ0103176T1', 'relkio', 'Jesus Aaron', 'Salgado Ramirez', 'e4cea64c5f6d39ccea441001381a7b37', 'Lazaro Cardenas 1819', 2147483647, 'relkioaaron@gmail.com'),
('SARJ0103176T2', 'relkie', 'Desu no', 'Perez Lopez', 'e4cea64c5f6d39ccea441001381a7b37', 'Lomas 3989', 2147483647, 'relkiopopo@gmail.com'),
('SARJ0103176T3', 'relkiu', 'Salgado', 'Salgado Ramirez', 'e4cea64c5f6d39ccea441001381a7b37', 'Campana de Dolores 3404', 2147483647, 'relkioaaron1@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `detalle`
--

CREATE TABLE `detalle` (
  `NumPedido` int(20) NOT NULL,
  `CodigoProd` varchar(30) NOT NULL,
  `CantidadProductos` int(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `detalle`
--

INSERT INTO `detalle` (`NumPedido`, `CodigoProd`, `CantidadProductos`) VALUES
(14, '3', 1),
(15, '1', 1),
(15, '2', 1),
(16, '2', 1),
(16, '1', 1),
(17, '6', 1),
(19, '6', 1),
(28, '6', 1),
(30, '1', 1),
(30, '1', 1),
(32, '1', 1),
(33, '3', 1),
(34, '1', 1),
(35, '1', 1),
(35, '1', 1),
(36, '3', 1),
(40, '3', 1),
(41, '3', 1),
(42, '2', 1),
(43, '1', 1),
(44, '1', 1);

--
-- Triggers `detalle`
--
DELIMITER $$
CREATE TRIGGER `actualizar_stock` AFTER INSERT ON `detalle` FOR EACH ROW BEGIN
    UPDATE producto
    SET Stock = Stock - NEW.CantidadProductos
    WHERE CodigoProd = NEW.CodigoProd;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `producto`
--

CREATE TABLE `producto` (
  `id` int(11) NOT NULL,
  `CodigoProd` int(11) NOT NULL,
  `NombreProd` varchar(30) NOT NULL,
  `CodigoCat` varchar(30) NOT NULL,
  `Precio` decimal(30,2) NOT NULL,
  `Modelo` varchar(30) NOT NULL,
  `Marca` varchar(30) NOT NULL,
  `Stock` int(20) NOT NULL,
  `RFCProveedor` varchar(30) NOT NULL,
  `Imagen` varchar(150) NOT NULL,
  `Nombre` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `producto`
--

INSERT INTO `producto` (`id`, `CodigoProd`, `NombreProd`, `CodigoCat`, `Precio`, `Modelo`, `Marca`, `Stock`, `RFCProveedor`, `Imagen`, `Nombre`) VALUES
(17, 1, 'Sony Xperia 1 IV', 'C3', '19200.00', 'Xperia 1 IV', 'Sony', 4, '0001781', 'xperia1iv.jpg', 'admin'),
(18, 2, 'Motorola Moto G71', 'C3', '5599.00', 'G71', 'Motorola', 5, '0001790', 'motorola g71.jpg', 'admin'),
(23, 3, 'Google Pixel 7', 'C3', '11599.00', 'Pixel 7 ', 'Google', 2, '0001792', 'GooglePixel7.jpg', 'admin'),
(26, 6, 'Lenovo Legion 5 17.3\" FHD', 'C1', '15000.00', 'Legion 5', 'Lenovo', 4, '0001791', 'LenovoLegion5.jpg', 'admin');

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `RFCProveedor` varchar(30) NOT NULL,
  `NombreProveedor` varchar(30) NOT NULL,
  `Direccion` varchar(200) NOT NULL,
  `Telefono` int(20) NOT NULL,
  `PaginaWeb` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `proveedor`
--

INSERT INTO `proveedor` (`RFCProveedor`, `NombreProveedor`, `Direccion`, `Telefono`, `PaginaWeb`) VALUES
('0001781', 'Sony', 'Minato, Tokio, Japón', 22596485, 'www.sony.com'),
('0001782', 'HTC', 'Taoyuan, Taiwán, (República de China)', 25987456, 'www.htc.com'),
('0001783', 'TCL', 'Huizhou, Guangdong, China', 25698745, 'tcl.com.ar'),
('0001785', 'Samsung', 'Samsung Town, Seúl, Corea del Sur', 22504787, 'www.samsung.com'),
('0001787', 'LG', 'Seúl,Corea del Sur', 26589874, 'www.lg.com'),
('0001789', 'Huawei ', 'Shenzhen, Guangdong, China', 22165848, 'www.huawei.com'),
('0001790', 'Motorola', 'Schaumburg, Illinois, USA', 22154687, 'www.motorola.com'),
('0001791', 'Lenovo', 'Haidian District, Beijing, China', 22984561, 'www.lenovo.com'),
('0001792', 'Google', 'Menlo Park, California, United States', 22139678, 'www.google.com');

-- --------------------------------------------------------

--
-- Table structure for table `venta`
--

CREATE TABLE `venta` (
  `NumPedido` int(20) NOT NULL,
  `Fecha` varchar(150) NOT NULL,
  `RFC` varchar(30) NOT NULL,
  `Descuento` int(20) NOT NULL,
  `TotalPagar` decimal(30,2) NOT NULL,
  `Estado` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;

--
-- Dumping data for table `venta`
--

INSERT INTO `venta` (`NumPedido`, `Fecha`, `RFC`, `Descuento`, `TotalPagar`, `Estado`) VALUES
(5, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(6, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(7, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(8, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(9, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(10, '09-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(11, '10-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(12, '10-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(13, '10-04-2023', 'SARJ0103176T1', 0, '19199.00', 'Pendiente'),
(14, '13-04-2023', 'SARJ0103176T1', 0, '28000.00', 'Pendiente'),
(15, '15-04-2023', 'SARJ0103176T1', 0, '24799.00', 'Pendiente'),
(16, '15-04-2023', 'SARJ0103176T1', 0, '24799.00', 'Pendiente'),
(17, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(18, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(19, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(20, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(21, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(22, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(23, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(24, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(25, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(26, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(27, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(28, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(29, '19-04-2023', 'SARJ0103176T1', 0, '15000.00', 'Pendiente'),
(30, '19-04-2023', 'SARJ0103176T1', 0, '38400.00', 'Pendiente'),
(31, '19-04-2023', 'SARJ0103176T1', 0, '38400.00', 'Pendiente'),
(32, '19-04-2023', 'SARJ0103176T1', 0, '19200.00', 'Pendiente'),
(33, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(34, '19-04-2023', 'SARJ0103176T1', 0, '19200.00', 'Pendiente'),
(35, '19-04-2023', 'SARJ0103176T1', 0, '38400.00', 'Pendiente'),
(36, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(37, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(38, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(39, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(40, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(41, '19-04-2023', 'SARJ0103176T1', 0, '11599.00', 'Pendiente'),
(42, '19-04-2023', 'SARJ0103176T1', 0, '5599.00', 'Pendiente'),
(43, '19-04-2023', 'SARJ0103176T1', 0, '19200.00', 'Pendiente'),
(44, '20-04-2023', 'SARJ0103176T1', 0, '19200.00', 'Pendiente');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `administrador`
--
ALTER TABLE `administrador`
  ADD PRIMARY KEY (`Nombre`);

--
-- Indexes for table `categoria`
--
ALTER TABLE `categoria`
  ADD PRIMARY KEY (`CodigoCat`);

--
-- Indexes for table `cliente`
--
ALTER TABLE `cliente`
  ADD PRIMARY KEY (`RFC`);

--
-- Indexes for table `detalle`
--
ALTER TABLE `detalle`
  ADD KEY `NumPedido` (`NumPedido`),
  ADD KEY `CodigoProd` (`CodigoProd`);

--
-- Indexes for table `producto`
--
ALTER TABLE `producto`
  ADD PRIMARY KEY (`id`),
  ADD KEY `CodigoCat` (`CodigoCat`),
  ADD KEY `RFCProveedor` (`RFCProveedor`),
  ADD KEY `Agregado` (`Nombre`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`RFCProveedor`);

--
-- Indexes for table `venta`
--
ALTER TABLE `venta`
  ADD PRIMARY KEY (`NumPedido`),
  ADD KEY `RFC` (`RFC`),
  ADD KEY `RFC_2` (`RFC`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `producto`
--
ALTER TABLE `producto`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `venta`
--
ALTER TABLE `venta`
  MODIFY `NumPedido` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `detalle`
--
ALTER TABLE `detalle`
  ADD CONSTRAINT `detalle_ibfk_9` FOREIGN KEY (`NumPedido`) REFERENCES `venta` (`NumPedido`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `producto`
--
ALTER TABLE `producto`
  ADD CONSTRAINT `producto_ibfk_7` FOREIGN KEY (`CodigoCat`) REFERENCES `categoria` (`CodigoCat`) ON UPDATE CASCADE,
  ADD CONSTRAINT `producto_ibfk_9` FOREIGN KEY (`Nombre`) REFERENCES `administrador` (`Nombre`);

--
-- Constraints for table `venta`
--
ALTER TABLE `venta`
  ADD CONSTRAINT `venta_ibfk_1` FOREIGN KEY (`RFC`) REFERENCES `cliente` (`RFC`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
