/*
 Navicat Premium Data Transfer

 Source Server         : Brayan
 Source Server Type    : MySQL
 Source Server Version : 100408
 Source Host           : localhost:3306
 Source Schema         : syscol

 Target Server Type    : MySQL
 Target Server Version : 100408
 File Encoding         : 65001

 Date: 14/11/2019 23:39:12
*/

CREATE DATABASE syscol;
USE syscol;

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for abono
-- ----------------------------
DROP TABLE IF EXISTS `abono`;
CREATE TABLE `abono`  (
  `id_abono` int(11) NOT NULL AUTO_INCREMENT,
  `anticipo` float NOT NULL,
  `fecha_anticipo` date NOT NULL,
  `clave_cotizacion` int(11) NOT NULL,
  PRIMARY KEY (`id_abono`) USING BTREE,
  INDEX `fk_clave_cotizacion_abono`(`clave_cotizacion`) USING BTREE,
  CONSTRAINT `fk_clave_cotizacion_abono` FOREIGN KEY (`clave_cotizacion`) REFERENCES `cotizacion` (`id_cotizacion`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cliente
-- ----------------------------
DROP TABLE IF EXISTS `cliente`;
CREATE TABLE `cliente`  (
  `id_cliente` int(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `apellido_p` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido_m` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `correo` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  PRIMARY KEY (`id_cliente`) USING BTREE,
  INDEX `fk_clavetelefono`(`telefono`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of cliente
-- ----------------------------
INSERT INTO `cliente` VALUES (3, 'arroyo', 'chavez', 'brayan', '1234567890', NULL);

-- ----------------------------
-- Table structure for cobranza
-- ----------------------------
DROP TABLE IF EXISTS `cobranza`;
CREATE TABLE `cobranza`  (
  `id_cobranza` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_inicio` date NOT NULL,
  `fecha_fin` date NOT NULL,
  `monto` float NOT NULL,
  `estatus` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `fecha_cobro` float NOT NULL,
  `clave_inmueble` int(10) UNSIGNED NOT NULL,
  `clave_orden_trabajo` int(11) NOT NULL,
  PRIMARY KEY (`id_cobranza`) USING BTREE,
  INDEX `FK_clave_inmueble_cobranza`(`clave_inmueble`) USING BTREE,
  INDEX `fk_clave_orden_trabajo_cobranza`(`clave_orden_trabajo`) USING BTREE,
  CONSTRAINT `fk_clave_inmueble_cobranza` FOREIGN KEY (`clave_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_orden_trabajo_cobranza` FOREIGN KEY (`clave_orden_trabajo`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contacto
-- ----------------------------
DROP TABLE IF EXISTS `contacto`;
CREATE TABLE `contacto`  (
  `id_contacto` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre_completo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `relacion` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_inmueble` int(10) UNSIGNED NOT NULL,
  `telefono` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_contacto`) USING BTREE,
  INDEX `fk_idinmueble`(`id_inmueble`) USING BTREE,
  INDEX `fk_clavetelefono`(`telefono`) USING BTREE,
  CONSTRAINT `fk_idinmueble_contacto` FOREIGN KEY (`id_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cotizacion
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion`;
CREATE TABLE `cotizacion`  (
  `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_cotizacion` date NOT NULL,
  `costo_material` float NULL DEFAULT NULL,
  `mano_obra` float NULL DEFAULT NULL,
  `precio_total` float NULL DEFAULT NULL,
  `estatus` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `clave_orden` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cotizacion`) USING BTREE,
  INDEX `FK_clave_solicitud_cotizacion`(`clave_orden`) USING BTREE,
  CONSTRAINT `fk_clave_orden_trabajo_cotizacion` FOREIGN KEY (`clave_orden`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cotizacion_material
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion_material`;
CREATE TABLE `cotizacion_material`  (
  `clave_material` int(10) NOT NULL,
  `clave_cotizacion` int(10) NOT NULL,
  INDEX `fk_clave_material_cotizacion_material`(`clave_material`) USING BTREE,
  INDEX `fk_clave_cotizacion_cotizacion_material`(`clave_cotizacion`) USING BTREE,
  CONSTRAINT `fk_clave_cotizacion_cotizacion_material` FOREIGN KEY (`clave_cotizacion`) REFERENCES `cotizacion` (`id_cotizacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_material_cotizacion_material` FOREIGN KEY (`clave_material`) REFERENCES `material` (`codigo_dis`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for empleado
-- ----------------------------
DROP TABLE IF EXISTS `empleado`;
CREATE TABLE `empleado`  (
  `id_empleado` int(11) NOT NULL AUTO_INCREMENT,
  `puesto` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido_p` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido_m` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `telefono` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT '',
  PRIMARY KEY (`id_empleado`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empleado
-- ----------------------------
INSERT INTO `empleado` VALUES (1, 'q', 'q', 'q', 'q', '1234567890');

-- ----------------------------
-- Table structure for factura
-- ----------------------------
DROP TABLE IF EXISTS `factura`;
CREATE TABLE `factura`  (
  `num_factura` int(11) NOT NULL,
  `fecha_facturacion` date NOT NULL,
  `iva` float NOT NULL,
  `subtotal` float NOT NULL,
  `total` float NOT NULL,
  `clave_cotizacion` int(11) NOT NULL,
  PRIMARY KEY (`num_factura`) USING BTREE,
  INDEX `FK_clave_cotizacion_factura`(`clave_cotizacion`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for inmueble
-- ----------------------------
DROP TABLE IF EXISTS `inmueble`;
CREATE TABLE `inmueble`  (
  `clave_inm` int(10) UNSIGNED NOT NULL,
  `estado_republica` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `municipio` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `codigo_postal` varchar(5) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `colonia` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `calle` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `numero_interior` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `numero_exterior` varchar(6) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `monitoreo` varchar(2) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_tipo` tinyint(4) NOT NULL,
  `clave_cliente` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`clave_inm`) USING BTREE,
  INDEX `fk_id_tipo_tipo_inmueble`(`id_tipo`) USING BTREE,
  INDEX `fk_clave_cliente_cliente`(`clave_cliente`) USING BTREE,
  CONSTRAINT `fk_clave_cliente_cliente` FOREIGN KEY (`clave_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_tipo_tipo_inmueble` FOREIGN KEY (`id_tipo`) REFERENCES `tipo_inmueble` (`clave_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of inmueble
-- ----------------------------
INSERT INTO `inmueble` VALUES (0, 'colima', 'colima', '12345', 'colima', 'colima', '1', '1', '', 1, 3);

-- ----------------------------
-- Table structure for inmueble_zona
-- ----------------------------
DROP TABLE IF EXISTS `inmueble_zona`;
CREATE TABLE `inmueble_zona`  (
  `clave_zona` tinyint(4) NOT NULL,
  `clave_material` int(11) NOT NULL,
  `clave_instalacion` int(255) NULL DEFAULT NULL,
  INDEX `FK_clave_zona_inmueble_zona`(`clave_zona`) USING BTREE,
  INDEX `fk_clave_material_inmueble_zona`(`clave_material`) USING BTREE,
  INDEX `fk_clave_instalacion_inmueble_zona`(`clave_instalacion`) USING BTREE,
  CONSTRAINT `fk_clave_instalacion_inmueble_zona` FOREIGN KEY (`clave_instalacion`) REFERENCES `instalacion` (`id_instalacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_material_inmueble_zona` FOREIGN KEY (`clave_material`) REFERENCES `material` (`codigo_dis`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_zona_inmueble_zona` FOREIGN KEY (`clave_zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for instalacion
-- ----------------------------
DROP TABLE IF EXISTS `instalacion`;
CREATE TABLE `instalacion`  (
  `id_instalacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NULL DEFAULT NULL,
  `clave_cotizacion` int(11) NOT NULL,
  `clave_inmueble` int(11) UNSIGNED NULL DEFAULT NULL,
  PRIMARY KEY (`id_instalacion`) USING BTREE,
  INDEX `FK_clave_cotizacion_instalacion`(`clave_cotizacion`) USING BTREE,
  INDEX `fk_clave_inmueble_instalacion`(`clave_inmueble`) USING BTREE,
  CONSTRAINT `fk_clave_cotizacion_instalacion` FOREIGN KEY (`clave_cotizacion`) REFERENCES `cotizacion` (`id_cotizacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_inmueble_instalacion` FOREIGN KEY (`clave_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for mantenimiento
-- ----------------------------
DROP TABLE IF EXISTS `mantenimiento`;
CREATE TABLE `mantenimiento`  (
  `id_mantenimiento` int(11) NOT NULL AUTO_INCREMENT,
  `observaciones` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `clave_instalacion` int(11) NOT NULL,
  `clave_orden` int(11) NOT NULL,
  PRIMARY KEY (`id_mantenimiento`) USING BTREE,
  INDEX `FK_clave_instalacion_mantenimiento`(`clave_instalacion`) USING BTREE,
  INDEX `FK_clave_orden_mantenimiento`(`clave_orden`) USING BTREE,
  CONSTRAINT `FK_clave_instalacion_mantenimiento` FOREIGN KEY (`clave_instalacion`) REFERENCES `instalacion` (`id_instalacion`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clave_orden_mantenimiento` FOREIGN KEY (`clave_orden`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for material
-- ----------------------------
DROP TABLE IF EXISTS `material`;
CREATE TABLE `material`  (
  `codigo_dis` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `modelo` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `precio_compra` float NOT NULL,
  `precio_venta` float NOT NULL,
  `clave_tipo` tinyint(4) NOT NULL,
  PRIMARY KEY (`codigo_dis`) USING BTREE,
  INDEX `fk_clave_tipo_material`(`clave_tipo`) USING BTREE,
  CONSTRAINT `fk_clave_tipo_material` FOREIGN KEY (`clave_tipo`) REFERENCES `tipo_material` (`id_tipo`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for orden_trabajo
-- ----------------------------
DROP TABLE IF EXISTS `orden_trabajo`;
CREATE TABLE `orden_trabajo`  (
  `id_orden` int(11) NOT NULL AUTO_INCREMENT,
  `observaciones` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `clave_solicitud` int(11) NOT NULL,
  `clave_empleado` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_orden`) USING BTREE,
  INDEX `Fk_clave_cotizacion_orden_trabajo`(`clave_solicitud`) USING BTREE,
  INDEX `fk_clave_empleado_orden_trabajo`(`clave_empleado`) USING BTREE,
  CONSTRAINT `fk_clave_empleado_orden_trabajo` FOREIGN KEY (`clave_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_solicitud_orden_trabajo` FOREIGN KEY (`clave_solicitud`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of orden_trabajo
-- ----------------------------
INSERT INTO `orden_trabajo` VALUES (2, NULL, '', 64, 1);
INSERT INTO `orden_trabajo` VALUES (3, NULL, '', 65, 1);
INSERT INTO `orden_trabajo` VALUES (4, NULL, '', 72, 1);

-- ----------------------------
-- Table structure for señal
-- ----------------------------
DROP TABLE IF EXISTS `señal`;
CREATE TABLE `señal`  (
  `id_señal` int(11) NOT NULL AUTO_INCREMENT,
  `fecha` date NOT NULL,
  `hora` time(0) NOT NULL,
  `clave_inmueble` int(11) UNSIGNED NOT NULL,
  `clave_tipo_evento` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_señal`) USING BTREE,
  INDEX `FK_clave_inmueble_señal`(`clave_inmueble`) USING BTREE,
  INDEX `fk_clave_tipo_evento_señal`(`clave_tipo_evento`) USING BTREE,
  CONSTRAINT `fk_clave_inmueble_señal` FOREIGN KEY (`clave_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_tipo_evento_señal` FOREIGN KEY (`clave_tipo_evento`) REFERENCES `tipo_evento` (`clave_tipp`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for señal_robo
-- ----------------------------
DROP TABLE IF EXISTS `señal_robo`;
CREATE TABLE `señal_robo`  (
  `id_señal_robo` int(11) NOT NULL AUTO_INCREMENT,
  `clave_zona` tinyint(4) NOT NULL,
  `clave_señal` int(11) NOT NULL,
  PRIMARY KEY (`id_señal_robo`) USING BTREE,
  INDEX `FK_clave_zona_señal_robo`(`clave_zona`) USING BTREE,
  INDEX `FK_clave_señal_señal_robo`(`clave_señal`) USING BTREE,
  CONSTRAINT `fk_clave_señal_señal_robo` FOREIGN KEY (`clave_señal`) REFERENCES `señal` (`id_señal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_zona_señal_robo` FOREIGN KEY (`clave_zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for señal_rutinaria
-- ----------------------------
DROP TABLE IF EXISTS `señal_rutinaria`;
CREATE TABLE `señal_rutinaria`  (
  `id_señal_rutinaria` int(11) NOT NULL AUTO_INCREMENT,
  `clave_usuario` int(11) NOT NULL,
  `clave_señal` int(11) NOT NULL,
  PRIMARY KEY (`id_señal_rutinaria`) USING BTREE,
  INDEX `FK_clave_usuario_señal_rutinaria`(`clave_usuario`) USING BTREE,
  INDEX `FK_clave_señalseñal_rutinaria`(`clave_señal`) USING BTREE,
  CONSTRAINT `FK_clave_señalseñal_rutinaria` FOREIGN KEY (`clave_señal`) REFERENCES `señal` (`id_señal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clave_usuario_señal_rutinaria` FOREIGN KEY (`clave_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for solicitud
-- ----------------------------
DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE `solicitud`  (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` date NOT NULL,
  `fecha_visita` date NULL DEFAULT NULL,
  `hora` time(0) NOT NULL,
  `estatus` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_solicitud` tinyint(4) NOT NULL,
  `tipo_servicio` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_solicitud`) USING BTREE,
  INDEX `FK_tipo_solicitud_solicitud`(`tipo_solicitud`) USING BTREE,
  INDEX `fk_tipo_servicio_solicitud`(`tipo_servicio`) USING BTREE,
  CONSTRAINT `fk_tipo_servicio_solicitud` FOREIGN KEY (`tipo_servicio`) REFERENCES `tipo_servicio` (`id_tipo_servicio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_solicitud_solicitud` FOREIGN KEY (`tipo_solicitud`) REFERENCES `tipo_solicitud` (`clave_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 77 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud
-- ----------------------------
INSERT INTO `solicitud` VALUES (63, '2019-11-13', '2019-11-13', '08:00:00', 'sin cotizar', 3, 1);
INSERT INTO `solicitud` VALUES (64, '2019-11-13', '2019-11-13', '08:00:00', 'sin cotizar', 3, 1);
INSERT INTO `solicitud` VALUES (65, '2019-11-13', '2019-11-05', '04:15:00', NULL, 5, 1);
INSERT INTO `solicitud` VALUES (70, '2019-11-13', '2019-11-05', '04:15:00', NULL, 5, 1);
INSERT INTO `solicitud` VALUES (72, '2019-11-13', '2019-11-05', '04:15:00', NULL, 5, 1);
INSERT INTO `solicitud` VALUES (73, '2019-11-13', '2019-11-05', '04:15:00', NULL, 5, 1);
INSERT INTO `solicitud` VALUES (74, '2019-11-14', '2019-10-10', '00:00:00', 'pendiente', 5, 2);
INSERT INTO `solicitud` VALUES (75, '2019-11-14', '2019-10-10', '00:00:00', 'pendiente', 5, 2);
INSERT INTO `solicitud` VALUES (76, '2019-11-14', '2019-10-10', '00:00:00', 'pendiente', 5, 2);

-- ----------------------------
-- Table structure for solicitud_cliente
-- ----------------------------
DROP TABLE IF EXISTS `solicitud_cliente`;
CREATE TABLE `solicitud_cliente`  (
  `id_solicitud_cliente` int(10) NOT NULL,
  `clave_cliente` int(10) UNSIGNED NOT NULL,
  `clave_inmueble` int(10) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_solicitud_cliente`) USING BTREE,
  INDEX `fk_clave_cliente_solicitud_cliente`(`clave_cliente`) USING BTREE,
  INDEX `fk_clave_inmueble_solicitud_cliente`(`clave_inmueble`) USING BTREE,
  CONSTRAINT `fk_clave_cliente_solicitud_cliente` FOREIGN KEY (`clave_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_inmueble_solicitud_cliente` FOREIGN KEY (`clave_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_solicitud_cliente_solicitud_cliente` FOREIGN KEY (`id_solicitud_cliente`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud_cliente
-- ----------------------------
INSERT INTO `solicitud_cliente` VALUES (72, 3, 0);
INSERT INTO `solicitud_cliente` VALUES (73, 3, 0);
INSERT INTO `solicitud_cliente` VALUES (76, 3, 0);

-- ----------------------------
-- Table structure for solicitud_inmueble
-- ----------------------------
DROP TABLE IF EXISTS `solicitud_inmueble`;
CREATE TABLE `solicitud_inmueble`  (
  `id_solicitud_inmueble` int(11) NOT NULL,
  `domicilio` varchar(150) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `clave_cliente` int(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id_solicitud_inmueble`) USING BTREE,
  INDEX `fk_clave_cliente_solicitud_inmueble`(`clave_cliente`) USING BTREE,
  CONSTRAINT `fk_clave_cliente_solicitud_inmueble` FOREIGN KEY (`clave_cliente`) REFERENCES `cliente` (`id_cliente`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_inmueble_solicitud_inmueble` FOREIGN KEY (`id_solicitud_inmueble`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud_inmueble
-- ----------------------------
INSERT INTO `solicitud_inmueble` VALUES (65, 'colima 1 colima', 3);

-- ----------------------------
-- Table structure for solicitud_pendiente
-- ----------------------------
DROP TABLE IF EXISTS `solicitud_pendiente`;
CREATE TABLE `solicitud_pendiente`  (
  `id_solicitud_pendiente` int(11) NOT NULL,
  `nombre_completo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `domicilio` varchar(150) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `telefono` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_solicitud_pendiente`) USING BTREE,
  CONSTRAINT `fk_solicitud_pendiente_solicitud_pendiente` FOREIGN KEY (`id_solicitud_pendiente`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of solicitud_pendiente
-- ----------------------------
INSERT INTO `solicitud_pendiente` VALUES (63, 'brayan arroyo chávez', 'del bronce', '3121438840');
INSERT INTO `solicitud_pendiente` VALUES (64, 'brayan arroyo chávez', 'del bronce', '3121438840');

-- ----------------------------
-- Table structure for tipo_evento
-- ----------------------------
DROP TABLE IF EXISTS `tipo_evento`;
CREATE TABLE `tipo_evento`  (
  `clave_tipp` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`clave_tipp`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipo_inmueble
-- ----------------------------
DROP TABLE IF EXISTS `tipo_inmueble`;
CREATE TABLE `tipo_inmueble`  (
  `clave_tipo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`clave_tipo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_inmueble
-- ----------------------------
INSERT INTO `tipo_inmueble` VALUES (1, '1');

-- ----------------------------
-- Table structure for tipo_material
-- ----------------------------
DROP TABLE IF EXISTS `tipo_material`;
CREATE TABLE `tipo_material`  (
  `id_tipo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_tipo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for tipo_servicio
-- ----------------------------
DROP TABLE IF EXISTS `tipo_servicio`;
CREATE TABLE `tipo_servicio`  (
  `id_tipo_servicio` tinyint(4) NOT NULL,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_tipo_servicio`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_servicio
-- ----------------------------
INSERT INTO `tipo_servicio` VALUES (1, 'instalacion');
INSERT INTO `tipo_servicio` VALUES (2, 'monitoreo');
INSERT INTO `tipo_servicio` VALUES (3, 'mantenimiento');

-- ----------------------------
-- Table structure for tipo_solicitud
-- ----------------------------
DROP TABLE IF EXISTS `tipo_solicitud`;
CREATE TABLE `tipo_solicitud`  (
  `clave_solicitud` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`clave_solicitud`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 9 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_solicitud
-- ----------------------------
INSERT INTO `tipo_solicitud` VALUES (3, 'Nuevo cliente');
INSERT INTO `tipo_solicitud` VALUES (4, 'Nuevo inmueble');
INSERT INTO `tipo_solicitud` VALUES (5, 'Nuevo servicio');

-- ----------------------------
-- Table structure for usuario
-- ----------------------------
DROP TABLE IF EXISTS `usuario`;
CREATE TABLE `usuario`  (
  `id_usuario` int(11) NOT NULL AUTO_INCREMENT,
  `num_usuario` int(11) NOT NULL,
  `apellido_p` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `apellido_m` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `nombre` varchar(40) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `cargo` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_mueble` int(10) UNSIGNED NOT NULL,
  `telefono` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  INDEX `fk_idmueble`(`id_mueble`) USING BTREE,
  CONSTRAINT `fk_idmueble_usuario` FOREIGN KEY (`id_mueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for zona
-- ----------------------------
DROP TABLE IF EXISTS `zona`;
CREATE TABLE `zona`  (
  `id_zona` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_zona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for view_detalle_solicitud_cliente
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_cliente`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_cliente` AS SELECT CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, CONCAT(i.calle," ",i.numero_exterior,i.numero_interior," ",i.colonia) as domicilio, c.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado
FROM solicitud s INNER JOIN solicitud_cliente sc 
on s.id_solicitud = sc.id_solicitud_cliente INNER JOIN cliente c
on sc.clave_cliente = c.id_cliente INNER JOIN inmueble i
on sc.clave_inmueble = i.clave_inm INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado ;

-- ----------------------------
-- View structure for view_detalle_solicitud_cliente_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_cliente_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_cliente_nuevo` AS SELECT sp.nombre_completo, sp.domicilio, sp.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado
FROM solicitud s INNER JOIN solicitud_pendiente sp
on s.id_solicitud=sp.id_solicitud_pendiente INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado ;

-- ----------------------------
-- View structure for view_detalle_solicitud_inmueble_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_inmueble_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_inmueble_nuevo` AS SELECT CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, si.domicilio, c.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado
FROM solicitud s INNER JOIN solicitud_inmueble si
on s.id_solicitud=si.id_solicitud_inmueble INNER JOIN cliente c
on si.clave_cliente = c.id_cliente INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado ;

-- ----------------------------
-- View structure for view_solicitud_cliente
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_cliente`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_cliente` AS SELECT s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus 
FROM solicitud s INNER JOIN solicitud_cliente sc 
on s.id_solicitud=sc.id_solicitud_cliente INNER JOIN cliente c on sc.clave_cliente = c.id_cliente ;

-- ----------------------------
-- View structure for view_solicitud_inmueble
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_inmueble`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_inmueble` AS SELECT s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus 
FROM solicitud s INNER JOIN solicitud_inmueble si
on s.id_solicitud = si.id_solicitud_inmueble INNER JOIN cliente c
on c.id_cliente=si.clave_cliente ;

-- ----------------------------
-- View structure for view_solicitud_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_nuevo` AS SELECT s.id_solicitud,sp.nombre_completo,DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita, s.estatus
FROM solicitud s INNER JOIN solicitud_pendiente sp 
on s .id_solicitud = sp.id_solicitud_pendiente ;

-- ----------------------------
-- Function structure for f_costo_material
-- ----------------------------
DROP FUNCTION IF EXISTS `f_costo_material`;
delimiter ;;
CREATE FUNCTION `f_costo_material`(nombre varchar(30))
 RETURNS int(11)
BEGIN
	SELECT precio_venta INTO @precio
	FROM material m
	WHERE m.nommbre = nombre;

	RETURN @precio;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for f_last_id
-- ----------------------------
DROP FUNCTION IF EXISTS `f_last_id`;
delimiter ;;
CREATE FUNCTION `f_last_id`()
 RETURNS int(11)
BEGIN
	RETURN LAST_INSERT_ID();
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_abono
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_abono`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_abono`(anticipo float,clave_cotizacion int)
BEGIN
	
	INSERT INTO abono (anticipo, fecha_anticipo,clave_cotizacion)
	VALUES (anticipo, CURDATE(),clave_cotizacion);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_cliente
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_cliente`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_cliente`(apellido_p varchar(30),apellido_m varchar(30),nombre varchar(30),telefono varchar(10),correo varchar(40))
BEGIN
	INSERT INTO cliente (apellido_p,apellido_m,nombre,telefono,correo)
	VALUES (apellido_p,apellido_m,nombre,telefono,correo);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_contacto
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_contacto`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_contacto`(nombre_completo varchar(100),relacion varchar(15),id_inmueble int,telefono varchar(10))
BEGIN
	
	INSERT INTO contacto (nombre_completo,relacion,id_inmueble,telefono)
	VALUES (nombre_completo,relacion,id_inmueble,telefono);
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_cotizacion
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_cotizacion`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_cotizacion`(costo_material float ,mano_obra float,clave_solicitud int)
BEGIN

	SELECT id_orden INTO @id_ot
	FROM orden_trabajo ot WHERE ot.clave_solicitud = clave_solicitud;

	INSERT INTO cotizacion (costo_material,mano_obra,estatus,precio_total,clave_orden)
	VALUES (costo_material,mano_obra,"pendiente",(costo_material+mano_obra),@id_ot);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_cotizacion_material
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_cotizacion_material`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_cotizacion_material`(nombre varchar(30),clave_cotizacion int)
BEGIN
	
	SELECT codigo_dis INTO @cod FROM material m WHERE m.nombre = nombre;
	
	INSERT INTO cotizacion_material (clave_material,clave_cotizacion)
	VALUES (@cod,clave_cotizacion);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_empleado
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_empleado`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_empleado`(puesto varchar(15),apellido_p varchar(30),apellido_m varchar(30),nombre varchar(40),telefono varchar(10))
BEGIN
	INSERT INTO empleado (puesto, apellido_p,apellido_m,nombre,telefono)
	VALUES (puesto, apellido_p,apellido_m,nombre,telefono);
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_inmueble
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_inmueble`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_inmueble`(estado_republica varchar(20),municipio varchar(20),codigo_postal varchar(5),colonia  varchar(30),calle  varchar(30),numero_exterior  varchar(6),id_tipo tinyint(4),clave_cliente int)
BEGIN
	INSERT INTO inmueble (estado_republica,municipio,codigo_postal,colonia,calle,numero_exterior,monitoreo,id_tipo,clave_cliente)
	VALUES (estado_republica,municipio,codigo_postal,colonia,calle,numero_exterior,"no",id_tipo,clave_cliente);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_mantenimiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_mantenimiento`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_mantenimiento`(observaciones varchar(255),clave_solicitud int)
BEGIN
	
	SELECT id_orden INTO @id_ot
	FROM orden_trabajo ot WHERE ot.clave_solicitud = clave_solicitud;
	
	SELECT i.id_instalacion INTO @id_i
	FROM solicitud_cliente sc INNER JOIN inmueble inm
	on sc.clave_inmueble = inm.clave_inm INNER JOIN instalacion i
	on inm.clave_inm = i.clave_inmueble
	WHERE i.id_solicitud_cliente= clave_solicitud;
	
	INSERT INTO mantenimiento (observaciones,clave_instalacion,clave_orden)
	VALUES (observaciones,@id_i,@id_ot);
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_material
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_material`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_material`(nombre varchar(30),modelo varchar(20),precio_compra float,precio_venta float,clave_tipo varchar(30))
BEGIN
	
	SELECT id_tipo INTO @tipo
	FROM tipo_material WHERE nombre=clave_tipo;
	
	INSERT INTO material (nombre,modelo,precio_compra,precio_venta,clave_tipo)
	VALUES (nombre,modelo,precio_compra,precio_venta,@tipo);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_orden_trabajo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_orden_trabajo`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_orden_trabajo`(observaciones varchar(255),clave_solicitud int, nombre_empleado varchar(100))
BEGIN
	
	SELECT id_empleado INTO @id_e FROM empleado 
	WHERE CONCAT(nombre," ",apellido_p," ",apellido_m) = nombre_empleado;
	
	INSERT INTO orden_trabajo (observaciones,estatus,clave_solicitud,clave_empleado)
	VALUES (observaciones,"pendiente",clave_solicitud,@id_e);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_señal_robo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_señal_robo`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_señal_robo`(clave_inmueble int, tipo_evento varchar(20), nombre_zona varchar(30))
BEGIN
	START TRANSACTION;
	
	SELECT id_tipo INTO @tipo
	FROM tipo_evento 
	WHERE nombre= tipo_evento;
	
	INSERT INTO señal (fecha,hora,clave_inmueble,clave_tipp)
	VALUES (fecha,hora,clave_inmueble,@tipo);
	
	SELECT id_señal_robo INTO @sr
	FROM zona
	WHERE nombre=nombre_zona;
	
	INSERT INTO señal_robo (clave_zona,clave_señal)
	VALUES (@sr,LAST_INSERT_ID());
	
	COMMIT;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_señal_rutinaria
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_señal_rutinaria`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_señal_rutinaria`(clave_inmueble int, tipo_evento varchar(20), nombre_usuario varchar(100))
BEGIN
	START TRANSACTION;
	
	SELECT id_tipo INTO @tipo
	FROM tipo_evento 
	WHERE nombre= tipo_evento;
	
	INSERT INTO señal (fecha,hora,clave_inmueble,clave_tipp)
	VALUES (fecha,hora,clave_inmueble,@tipo);
	
	SELECT id_usuario INTO @sr
	FROM usuario
	WHERE nombre=nombre_usuario;
	
	INSERT INTO señal_robo (clave_usuario,clave_señal)
	VALUES (@sr,LAST_INSERT_ID());
	
	COMMIT;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_solicitud_cliente
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_solicitud_cliente`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_solicitud_cliente`(fecha_visita Date,hora time,tipo_solicitud varchar(30),tipo_servicio varchar(30),nombre_completo varchar(100),domicilio varchar(150))
BEGIN
	START TRANSACTION;
	
	SELECT clave_solicitud INTO @cs FROM tipo_solicitud WHERE nombre = tipo_solicitud;
	
	SELECT id_tipo_servicio INTO @id_ts FROM tipo_servicio WHERE nombre = tipo_servicio;
	
	CASE @id_ts
    WHEN "1" THEN SET @estatus="sin cotizar";
    WHEN "2" THEN SET @estatus="pendiente";
		WHEN "3" THEN SET @estatus="pendiente";
    ELSE
			BEGIN
			END;
	END CASE;
	
	INSERT INTO solicitud (fecha_solicitud,fecha_visita,hora,estatus,tipo_solicitud,tipo_servicio)
	VALUES (CURDATE(),fecha_visita,hora,@estatus,@cs,@id_ts);
	
	SELECT id_cliente INTO @id_c FROM cliente 
	WHERE CONCAT(nombre," ",apellido_p," ",apellido_m) = nombre_completo;
	
	SELECT clave_inm INTO @id_d FROM inmueble 
	WHERE CONCAT(calle," ",numero_exterior," ",colonia) = domicilio;
		
	INSERT INTO solicitud_cliente (id_solicitud_cliente,clave_cliente,clave_inmueble)
	VALUES (LAST_INSERT_ID(),@id_c,@id_d);
	
	COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_solicitud_cliente_nuevo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_solicitud_cliente_nuevo`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_solicitud_cliente_nuevo`(fecha_visita Date,hora time,tipo_solicitud varchar(30),tipo_servicio varchar(30),nombre_completo varchar(100),domicilio varchar(150),telefono varchar(10))
BEGIN
	START TRANSACTION;
	
	SELECT clave_solicitud INTO @cs FROM tipo_solicitud WHERE nombre = tipo_solicitud;
	
	SELECT id_tipo_servicio INTO @id_ts FROM tipo_servicio WHERE nombre = tipo_servicio;
	
	INSERT INTO solicitud (fecha_solicitud,fecha_visita,hora,estatus,tipo_solicitud,tipo_servicio)
	VALUES (CURDATE(),fecha_visita,hora,"sin cotizar",@cs,@id_ts);
		
	INSERT INTO solicitud_pendiente (id_solicitud_pendiente,nombre_completo,domicilio,telefono)
	VALUES (LAST_INSERT_ID(),nombre_completo,domicilio,telefono);
	
	COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_solicitud_inmueble
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_solicitud_inmueble`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_solicitud_inmueble`(fecha_visita Date,hora time,tipo_solicitud varchar(30),tipo_servicio varchar(30),nombre_completo varchar(100),domicilio varchar(150))
BEGIN
	START TRANSACTION;
	
	SELECT clave_solicitud INTO @cs FROM tipo_solicitud WHERE nombre = tipo_solicitud;
	
	SELECT id_tipo_servicio INTO @id_ts FROM tipo_servicio WHERE nombre = tipo_servicio;
	
	INSERT INTO solicitud (fecha_solicitud,fecha_visita,hora,estatus,tipo_solicitud,tipo_servicio)
	VALUES (CURDATE(),fecha_visita,hora,"sin cotizar",@cs,@id_ts);
	
	SELECT id_cliente INTO @id_c FROM cliente 
	WHERE CONCAT(nombre," ",apellido_p," ",apellido_m) = nombre_completo;
		
	INSERT INTO solicitud_inmueble (id_solicitud_inmueble,domicilio,clave_cliente)
	VALUES (LAST_INSERT_ID(),domicilio,@id_c);
	
	COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_tipo_inmueble
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_tipo_inmueble`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_tipo_inmueble`(nombre varchar(30))
BEGIN
	INSERT INTO inmueble (nombre)
	VALUES (nombre);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_tipo_material
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_tipo_material`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_tipo_material`(nombre varchar(30))
BEGIN
	INSERT INTO tipo_material (nombre)
	VALUES (nombre);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_tipo_solicitud
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_tipo_solicitud`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_tipo_solicitud`(nombre varchar(30))
BEGIN
	INSERT INTO tipo_solicitud (nombre)
	VALUES (nombre);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_usuario
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_usuario`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_usuario`(num_usuario int,apellido_p varchar(30),apellido_m varchar(30),nombre varchar(40),cargo varchar(20),id_inmueble int,telefono varchar(10))
BEGIN
	
	INSERT INTO contacto (num_usuario,apellido_p,apellido_m,nombre,cargo,id_inmueble,telefono)
	VALUES (num_usuario,apellido_p,apellido_m,nombre,cargo,id_inmueble,telefono);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_zona
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_zona`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_zona`(zona varchar(30),material varchar(30), clave_instalacion int)
BEGIN
	START TRANSACTION;
	
	INSERT INTO zona (nombre)
	VALUES (zona);
	
	SELECT codigo_dis into @cod
	FROM material m 
	WHERE m.nombre = material;
	
	INSERT INTO inmueble_zona (clave_zona, clave_material, clave_instalacion)
	VALUES (LAST_INSERT_ID(),@cod,clave_instalacion);
	
	COMMIT;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_generar_cotizacion
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_generar_cotizacion`;
delimiter ;;
CREATE PROCEDURE `sp_generar_cotizacion`()
BEGIN

	INSERT INTO cotizacion (fecha_cotizacion)
	VALUES (CURDATE());
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_generar_instalacion
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_generar_instalacion`;
delimiter ;;
CREATE PROCEDURE `sp_generar_instalacion`(clave_cotizacion int)
BEGIN
	
	INSERT INTO instalacion (clave_cotizacion)
	VALUES (clave_cotizacion);

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table cotizacion
-- ----------------------------
DROP TRIGGER IF EXISTS `tg_cotizacion`;
delimiter ;;
CREATE TRIGGER `tg_cotizacion` AFTER INSERT ON `cotizacion` FOR EACH ROW BEGIN

UPDATE solicitud s
SET s.estatus="cotizado"
WHERE s.id_solicitud = (SELECT ot.clave_solicitud
FROM cotizacion c INNER JOIN orden_trabajo ot
on c.clave_orden = ot.id_orden
WHERE c.id_cotizacion=LAST_INSERT_ID());

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table mantenimiento
-- ----------------------------
DROP TRIGGER IF EXISTS `tg_mantenimiento`;
delimiter ;;
CREATE TRIGGER `tg_mantenimiento` AFTER INSERT ON `mantenimiento` FOR EACH ROW BEGIN

UPDATE solicitud s
SET s.estatus="finalizado"
WHERE s.id_solicitud = (SELECT ot.clave_solicitud
FROM mantenimiento m INNER JOIN orden_trabajo ot
on m.clave_orden = ot.id_orden
WHERE m.id_mantenimiento=LAST_INSERT_ID());

END
;;
delimiter ;

-- ----------------------------
-- Triggers structure for table orden_trabajo
-- ----------------------------
DROP TRIGGER IF EXISTS `tg_monitoreo`;
delimiter ;;
CREATE TRIGGER `tg_monitoreo` AFTER UPDATE ON `orden_trabajo` FOR EACH ROW BEGIN

UPDATE inmueble i
SET i.monitoreo="si"
WHERE i.clave_inmueble = (SELECT sc.clave_inmueble
FROM orden_trabajo ot INNER JOIN solicitud_cliente sc
on ot.clave_solicitud = sc.id_solicitud_cliente 
WHERE ot.id_orden=LAST_INSERT_ID());

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
