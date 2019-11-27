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

 Date: 26/11/2019 20:34:36
*/

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
  `firma` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_cliente`) USING BTREE,
  INDEX `fk_clavetelefono`(`telefono`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 23 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cobranza
-- ----------------------------
DROP TABLE IF EXISTS `cobranza`;
CREATE TABLE `cobranza`  (
  `id_cobranza` int(11) NOT NULL AUTO_INCREMENT,
  `monto` float NOT NULL,
  `fecha_cobro` date NOT NULL,
  `clave_inmueble` int(10) UNSIGNED NOT NULL,
  `clave_empleado` int(11) NOT NULL,
  PRIMARY KEY (`id_cobranza`) USING BTREE,
  INDEX `FK_clave_inmueble_cobranza`(`clave_inmueble`) USING BTREE,
  INDEX `fk_clave_empleado_cobranza`(`clave_empleado`) USING BTREE,
  CONSTRAINT `fk_clave_empleado_cobranza` FOREIGN KEY (`clave_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_inmueble_cobranza` FOREIGN KEY (`clave_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cobranza_mantenimiento
-- ----------------------------
DROP TABLE IF EXISTS `cobranza_mantenimiento`;
CREATE TABLE `cobranza_mantenimiento`  (
  `id_cobranza_mantenimiento` int(11) NOT NULL,
  `observaciones` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `clave_cobranza` int(11) NULL DEFAULT NULL,
  PRIMARY KEY (`id_cobranza_mantenimiento`) USING BTREE,
  INDEX `fk_clave_cobranza_cobranza_mantenimiento`(`clave_cobranza`) USING BTREE,
  CONSTRAINT `fk_clave_cobranza_cobranza_mantenimiento` FOREIGN KEY (`clave_cobranza`) REFERENCES `cobranza` (`id_cobranza`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for contacto
-- ----------------------------
DROP TABLE IF EXISTS `contacto`;
CREATE TABLE `contacto`  (
  `id_contacto` tinyint(4) NOT NULL AUTO_INCREMENT,
  `num_contacto` int(11) NOT NULL,
  `nombre_completo` varchar(100) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `relacion` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `id_inmueble` int(10) UNSIGNED NOT NULL,
  `telefono` varchar(10) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_contacto`) USING BTREE,
  INDEX `fk_idinmueble`(`id_inmueble`) USING BTREE,
  INDEX `fk_clavetelefono`(`telefono`) USING BTREE,
  CONSTRAINT `fk_idinmueble_contacto` FOREIGN KEY (`id_inmueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cotizacion
-- ----------------------------
DROP TABLE IF EXISTS `cotizacion`;
CREATE TABLE `cotizacion`  (
  `id_cotizacion` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_cotizacion` date NULL DEFAULT NULL,
  `costo_material` float NULL DEFAULT NULL,
  `mano_obra` float NULL DEFAULT NULL,
  `precio_total` float NULL DEFAULT NULL,
  `clave_orden` int(11) NOT NULL,
  PRIMARY KEY (`id_cotizacion`) USING BTREE,
  UNIQUE INDEX `clave_orden`(`clave_orden`) USING BTREE,
  INDEX `FK_clave_solicitud_cotizacion`(`clave_orden`) USING BTREE,
  CONSTRAINT `fk_clave_orden_trabajo_cotizacion` FOREIGN KEY (`clave_orden`) REFERENCES `orden_trabajo` (`id_orden`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 46 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of empleado
-- ----------------------------
INSERT INTO `empleado` VALUES (2, ' indefinido', 'asignar', ' ', 'Sin', '0000000000');
INSERT INTO `empleado` VALUES (3, 'Encargado', 'Arroyo', 'Chávez', 'Brayan Alberto', '3121438840');
INSERT INTO `empleado` VALUES (4, 'Monitoreo', 'Ochoa', 'Sandoval', 'Rafael Alejandro', '1234567890');
INSERT INTO `empleado` VALUES (5, 'Tecnico', 'Figueroa', 'Campos', 'Diego Aaron', '1234567890');

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
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for login
-- ----------------------------
DROP TABLE IF EXISTS `login`;
CREATE TABLE `login`  (
  `id_login` int(11) NOT NULL AUTO_INCREMENT,
  `usuario` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `contraseña` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `clave_permiso` tinyint(4) NOT NULL,
  `clave_empleado` int(11) NOT NULL,
  PRIMARY KEY (`id_login`) USING BTREE,
  INDEX `fk_clave_empleado_login`(`clave_empleado`) USING BTREE,
  INDEX `fk_clave_permiso_login`(`clave_permiso`) USING BTREE,
  CONSTRAINT `fk_clave_empleado_login` FOREIGN KEY (`clave_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_permiso_login` FOREIGN KEY (`clave_permiso`) REFERENCES `permiso` (`id_permiso`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of login
-- ----------------------------
INSERT INTO `login` VALUES (1, 'brayan@hotmail.com', '123', 1, 3);
INSERT INTO `login` VALUES (2, 'rafa@hotmail.com', '123', 3, 4);
INSERT INTO `login` VALUES (3, 'diego@hotmail.com', '123', 2, 5);

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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material
-- ----------------------------
INSERT INTO `material` VALUES (1, 'Camara', 'mat', 150, 300, 2);
INSERT INTO `material` VALUES (2, 'Sensor de movimiento', 'mat', 100, 200, 2);
INSERT INTO `material` VALUES (3, 'Sensor termico', 'mat', 70, 100, 2);

-- ----------------------------
-- Table structure for orden_trabajo
-- ----------------------------
DROP TABLE IF EXISTS `orden_trabajo`;
CREATE TABLE `orden_trabajo`  (
  `id_orden` int(11) NOT NULL AUTO_INCREMENT,
  `observaciones` varchar(255) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `estatus` varchar(15) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `clave_solicitud` int(11) NOT NULL,
  `clave_empleado` int(11) NOT NULL,
  PRIMARY KEY (`id_orden`) USING BTREE,
  UNIQUE INDEX `clave_solicitud`(`clave_solicitud`) USING BTREE,
  INDEX `Fk_clave_cotizacion_orden_trabajo`(`clave_solicitud`) USING BTREE,
  INDEX `fk_clave_empleado_orden_trabajo`(`clave_empleado`) USING BTREE,
  CONSTRAINT `fk_clave_empleado_orden_trabajo` FOREIGN KEY (`clave_empleado`) REFERENCES `empleado` (`id_empleado`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_solicitud_orden_trabajo` FOREIGN KEY (`clave_solicitud`) REFERENCES `solicitud` (`id_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 59 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for permiso
-- ----------------------------
DROP TABLE IF EXISTS `permiso`;
CREATE TABLE `permiso`  (
  `id_permiso` tinyint(4) NOT NULL AUTO_INCREMENT,
  `valor` tinyint(4) NOT NULL,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_permiso`) USING BTREE,
  INDEX `valor`(`valor`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of permiso
-- ----------------------------
INSERT INTO `permiso` VALUES (1, 1, 'gerente');
INSERT INTO `permiso` VALUES (2, 2, 'tecnico');
INSERT INTO `permiso` VALUES (3, 3, 'monitoreo');

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
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for señal_robo
-- ----------------------------
DROP TABLE IF EXISTS `señal_robo`;
CREATE TABLE `señal_robo`  (
  `id_señal_robo` int(11) NOT NULL,
  `clave_zona` tinyint(4) NOT NULL,
  `clave_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_señal_robo`) USING BTREE,
  INDEX `FK_clave_zona_señal_robo`(`clave_zona`) USING BTREE,
  INDEX `FK_clave_señal_señal_robo`(`id_señal_robo`) USING BTREE,
  INDEX `fk_clave_tipo_señal_robo`(`clave_tipo`) USING BTREE,
  CONSTRAINT `fk_clave_señal_señal_robo` FOREIGN KEY (`id_señal_robo`) REFERENCES `señal` (`id_señal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_tipo_señal_robo` FOREIGN KEY (`clave_tipo`) REFERENCES `tipo_señal_robo` (`id_tipo_señal_robo`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_zona_señal_robo` FOREIGN KEY (`clave_zona`) REFERENCES `zona` (`id_zona`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for señal_rutinaria
-- ----------------------------
DROP TABLE IF EXISTS `señal_rutinaria`;
CREATE TABLE `señal_rutinaria`  (
  `id_señal_rutinaria` int(11) NOT NULL,
  `clave_usuario` int(11) NOT NULL,
  `clave_tipo` int(11) NOT NULL,
  PRIMARY KEY (`id_señal_rutinaria`) USING BTREE,
  INDEX `FK_clave_usuario_señal_rutinaria`(`clave_usuario`) USING BTREE,
  INDEX `FK_clave_señalseñal_rutinaria`(`id_señal_rutinaria`) USING BTREE,
  INDEX `fk_clave_tipo_señal_rutinaria`(`clave_tipo`) USING BTREE,
  CONSTRAINT `FK_clave_señalseñal_rutinaria` FOREIGN KEY (`id_señal_rutinaria`) REFERENCES `señal` (`id_señal`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_clave_usuario_señal_rutinaria` FOREIGN KEY (`clave_usuario`) REFERENCES `usuario` (`id_usuario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_clave_tipo_señal_rutinaria` FOREIGN KEY (`clave_tipo`) REFERENCES `tipo_señal_rutina` (`id_señal_rutina`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for señal_sistema
-- ----------------------------
DROP TABLE IF EXISTS `señal_sistema`;
CREATE TABLE `señal_sistema`  (
  `id_señal_sistema` int(11) NOT NULL,
  `clave_sistema` int(11) NOT NULL,
  PRIMARY KEY (`id_señal_sistema`) USING BTREE,
  INDEX `fk_clave_sistema_señal_sistema`(`clave_sistema`) USING BTREE,
  CONSTRAINT `fk_clave_sistema_señal_sistema` FOREIGN KEY (`clave_sistema`) REFERENCES `sistema` (`id_sistema`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_id_señal_sistema_señal_sistema` FOREIGN KEY (`id_señal_sistema`) REFERENCES `señal` (`id_señal`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for sistema
-- ----------------------------
DROP TABLE IF EXISTS `sistema`;
CREATE TABLE `sistema`  (
  `id_sistema` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_sistema`) USING BTREE,
  INDEX `nombre`(`nombre`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of sistema
-- ----------------------------
INSERT INTO `sistema` VALUES (5, 'Alarma médica');
INSERT INTO `sistema` VALUES (2, 'alimentación CA');
INSERT INTO `sistema` VALUES (3, 'Alimentación encendida');
INSERT INTO `sistema` VALUES (1, 'batería del sistema');
INSERT INTO `sistema` VALUES (4, 'Restitución de la comunicación');

-- ----------------------------
-- Table structure for solicitud
-- ----------------------------
DROP TABLE IF EXISTS `solicitud`;
CREATE TABLE `solicitud`  (
  `id_solicitud` int(11) NOT NULL AUTO_INCREMENT,
  `fecha_solicitud` date NOT NULL,
  `fecha_visita` date NULL DEFAULT NULL,
  `hora` time(0) NOT NULL,
  `estatus` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NULL DEFAULT NULL,
  `tipo_solicitud` tinyint(4) NOT NULL,
  `tipo_servicio` tinyint(4) NOT NULL,
  PRIMARY KEY (`id_solicitud`) USING BTREE,
  INDEX `FK_tipo_solicitud_solicitud`(`tipo_solicitud`) USING BTREE,
  INDEX `fk_tipo_servicio_solicitud`(`tipo_servicio`) USING BTREE,
  CONSTRAINT `fk_tipo_servicio_solicitud` FOREIGN KEY (`tipo_servicio`) REFERENCES `tipo_servicio` (`id_tipo_servicio`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `fk_tipo_solicitud_solicitud` FOREIGN KEY (`tipo_solicitud`) REFERENCES `tipo_solicitud` (`clave_solicitud`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB AUTO_INCREMENT = 135 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

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
-- Table structure for tipo_evento
-- ----------------------------
DROP TABLE IF EXISTS `tipo_evento`;
CREATE TABLE `tipo_evento`  (
  `clave_tipp` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`clave_tipp`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_evento
-- ----------------------------
INSERT INTO `tipo_evento` VALUES (1, 'robo');
INSERT INTO `tipo_evento` VALUES (2, 'rutina');
INSERT INTO `tipo_evento` VALUES (3, 'sistema');

-- ----------------------------
-- Table structure for tipo_inmueble
-- ----------------------------
DROP TABLE IF EXISTS `tipo_inmueble`;
CREATE TABLE `tipo_inmueble`  (
  `clave_tipo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`clave_tipo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_inmueble
-- ----------------------------
INSERT INTO `tipo_inmueble` VALUES (1, 'Casa');
INSERT INTO `tipo_inmueble` VALUES (2, 'Empresa');

-- ----------------------------
-- Table structure for tipo_material
-- ----------------------------
DROP TABLE IF EXISTS `tipo_material`;
CREATE TABLE `tipo_material`  (
  `id_tipo` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_tipo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_material
-- ----------------------------
INSERT INTO `tipo_material` VALUES (2, 'mat');

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
-- Table structure for tipo_señal_robo
-- ----------------------------
DROP TABLE IF EXISTS `tipo_señal_robo`;
CREATE TABLE `tipo_señal_robo`  (
  `id_tipo_señal_robo` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_tipo_señal_robo`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_señal_robo
-- ----------------------------
INSERT INTO `tipo_señal_robo` VALUES (1, 'Alarma por robo');
INSERT INTO `tipo_señal_robo` VALUES (2, 'Restitución por robo');

-- ----------------------------
-- Table structure for tipo_señal_rutina
-- ----------------------------
DROP TABLE IF EXISTS `tipo_señal_rutina`;
CREATE TABLE `tipo_señal_rutina`  (
  `id_señal_rutina` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`id_señal_rutina`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of tipo_señal_rutina
-- ----------------------------
INSERT INTO `tipo_señal_rutina` VALUES (1, 'Apertura');
INSERT INTO `tipo_señal_rutina` VALUES (2, 'Cierre');
INSERT INTO `tipo_señal_rutina` VALUES (3, 'Reajustar apertura');

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
  `relacion` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  `id_mueble` int(10) UNSIGNED NOT NULL,
  `telefono` varchar(12) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_usuario`) USING BTREE,
  INDEX `fk_idmueble`(`id_mueble`) USING BTREE,
  CONSTRAINT `fk_idmueble_usuario` FOREIGN KEY (`id_mueble`) REFERENCES `inmueble` (`clave_inm`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for zona
-- ----------------------------
DROP TABLE IF EXISTS `zona`;
CREATE TABLE `zona`  (
  `id_zona` tinyint(4) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(30) CHARACTER SET latin1 COLLATE latin1_swedish_ci NOT NULL,
  PRIMARY KEY (`id_zona`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 27 CHARACTER SET = latin1 COLLATE = latin1_swedish_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- View structure for q
-- ----------------------------
DROP VIEW IF EXISTS `q`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `q` AS (SELECT ot.id_orden,i.clave_inm,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_cliente sc
on sc.id_solicitud_cliente = ot.clave_solicitud INNER JOIN cliente c
on sc.clave_cliente = c.id_cliente INNER JOIN inmueble i
on c.id_cliente = i.clave_cliente WHERE ot.id_orden = 4)
UNION
(SELECT ot.id_orden,i.clave_inm,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_inmueble si
on si.id_solicitud_inmueble = ot.clave_solicitud INNER JOIN cliente c
on si.clave_cliente = c.id_cliente INNER JOIN inmueble i
on c.id_cliente = i.clave_cliente WHERE ot.id_orden = 4) 
UNION
(SELECT ot.id_orden,"Sin asignar",sp.nombre_completo as nombre, sp.domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_pendiente sp
on sp.id_solicitud_pendiente = ot.clave_solicitud WHERE ot.id_orden = 4) ;

-- ----------------------------
-- View structure for view_cobranza_clientes
-- ----------------------------
DROP VIEW IF EXISTS `view_cobranza_clientes`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_cobranza_clientes` AS SELECT CONCAT(u.nombre," ",u.apellido_p," ",u.apellido_m) as nombre
FROM usuario u ;

-- ----------------------------
-- View structure for view_cobranza_inmueble
-- ----------------------------
DROP VIEW IF EXISTS `view_cobranza_inmueble`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_cobranza_inmueble` AS SELECT i.clave_inm,i.calle,i.numero_exterior,i.colonia
FROM inmueble i ;

-- ----------------------------
-- View structure for view_detalle_solicitud_cliente
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_cliente`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_cliente` AS SELECT c.id_cliente,s.tipo_solicitud as id_tipo_solicitud,s.tipo_servicio as id_tipo_servicio,s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, c.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado, tso.nombre as tipo_solicitud, tse.nombre as tipo_servicio
FROM solicitud s INNER JOIN solicitud_cliente sc 
on s.id_solicitud = sc.id_solicitud_cliente INNER JOIN cliente c
on sc.clave_cliente = c.id_cliente INNER JOIN inmueble i
on sc.clave_inmueble = i.clave_inm INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN tipo_servicio tse
on s.tipo_servicio = tse.id_tipo_servicio INNER JOIN tipo_solicitud tso
on s.tipo_solicitud = tso.clave_solicitud ;

-- ----------------------------
-- View structure for view_detalle_solicitud_cliente_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_cliente_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_cliente_nuevo` AS SELECT "sin asignar" as id_cliente, s.tipo_solicitud as id_tipo_solicitud,s.tipo_servicio as id_tipo_servicio,s.id_solicitud,sp.nombre_completo as nombre, sp.domicilio, sp.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado, tso.nombre as tipo_solicitud, tse.nombre as tipo_servicio
FROM solicitud s INNER JOIN solicitud_pendiente sp
on s.id_solicitud=sp.id_solicitud_pendiente INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN tipo_servicio tse
on s.tipo_servicio = tse.id_tipo_servicio INNER JOIN tipo_solicitud tso
on s.tipo_solicitud = tso.clave_solicitud ;

-- ----------------------------
-- View structure for view_detalle_solicitud_inmueble_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_detalle_solicitud_inmueble_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_detalle_solicitud_inmueble_nuevo` AS SELECT c.id_cliente,s.tipo_solicitud as id_tipo_solicitud,s.tipo_servicio as id_tipo_servicio,s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, si.domicilio, c.telefono, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado, tso.nombre as tipo_solicitud, tse.nombre as tipo_servicio
FROM solicitud s INNER JOIN solicitud_inmueble si
on s.id_solicitud=si.id_solicitud_inmueble INNER JOIN cliente c
on si.clave_cliente = c.id_cliente INNER JOIN orden_trabajo ot
on ot.clave_solicitud=s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN tipo_servicio tse
on s.tipo_servicio = tse.id_tipo_servicio INNER JOIN tipo_solicitud tso
on s.tipo_solicitud = tso.clave_solicitud ;

-- ----------------------------
-- View structure for view_orden_empleados
-- ----------------------------
DROP VIEW IF EXISTS `view_orden_empleados`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_orden_empleados` AS SELECT CONCAT(nombre," ",apellido_p," ",apellido_m) as nombre 
FROM empleado
where id_empleado not in (2) ;

-- ----------------------------
-- View structure for view_orden_trabajo
-- ----------------------------
DROP VIEW IF EXISTS `view_orden_trabajo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_orden_trabajo` AS SELECT ot.id_orden,ts.nombre,
date_format(s.fecha_visita,'%d/%m/%Y') AS fecha_visita,s.hora,CONCAT(e.nombre," ",e.apellido_p," ",e.apellido_m) as empleado
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN tipo_servicio ts 
on s.tipo_servicio = ts.id_tipo_servicio INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado ;

-- ----------------------------
-- View structure for view_señales
-- ----------------------------
DROP VIEW IF EXISTS `view_señales`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_señales` AS select `s`.`id_señal` AS `id_señal`,`i`.`clave_inm` AS `clave_inm`,`te`.`nombre` AS `nombre`,date_format(`s`.`fecha`,'%d/%m/%Y') AS `fecha`,time_format(`s`.`hora`,'%H:%i') AS `hora` from ((`señal` `s` join `tipo_evento` `te` on(`s`.`clave_tipo_evento` = `te`.`clave_tipp`)) join `inmueble` `i` on(`s`.`clave_inmueble` = `i`.`clave_inm`));

-- ----------------------------
-- View structure for view_solicitud_cliente
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_cliente`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_cliente` AS SELECT s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus,o.clave_empleado
FROM solicitud s INNER JOIN solicitud_cliente sc 
on s.id_solicitud=sc.id_solicitud_cliente INNER JOIN cliente c 
on sc.clave_cliente = c.id_cliente INNER JOIN orden_trabajo o
on s.id_solicitud = o.clave_solicitud ;

-- ----------------------------
-- View structure for view_solicitud_inmueble
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_inmueble`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_inmueble` AS SELECT s.id_solicitud,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m)as nombre, DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita,s.estatus, o.clave_empleado
FROM solicitud s INNER JOIN solicitud_inmueble si
on s.id_solicitud = si.id_solicitud_inmueble INNER JOIN cliente c
on c.id_cliente=si.clave_cliente INNER JOIN orden_trabajo o
on s.id_solicitud = o.clave_empleado ;

-- ----------------------------
-- View structure for view_solicitud_nuevo
-- ----------------------------
DROP VIEW IF EXISTS `view_solicitud_nuevo`;
CREATE ALGORITHM = UNDEFINED SQL SECURITY DEFINER VIEW `view_solicitud_nuevo` AS SELECT s.id_solicitud,sp.nombre_completo,DATE_FORMAT(s.fecha_visita,'%d/%m/%Y') AS fecha, TIME_FORMAT(s.hora, "%H:%i") AS hora_visita, s.estatus, o.clave_empleado
FROM solicitud s INNER JOIN solicitud_pendiente sp 
on s .id_solicitud = sp.id_solicitud_pendiente INNER JOIN orden_trabajo o
on s.id_solicitud = o.clave_solicitud ;

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
-- Function structure for f_zona_inmueble_robo
-- ----------------------------
DROP FUNCTION IF EXISTS `f_zona_inmueble_robo`;
delimiter ;;
CREATE FUNCTION `f_zona_inmueble_robo`(clave int)
 RETURNS int(11)
BEGIN
	RETURN (SELECT z.nombre FROM inmueble inm INNER JOIN instalacion i 
	on i.clave_inmueble = inm.clave_inm INNER JOIN inmueble_zona iz
	on i.id_instalacion = iz.clave_instalacion INNER JOIN zona z
	on iz.clave_zona=z.id_zona WHERE inm.clave_inm = clave);


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
-- Procedure structure for sp_agregar_ciz
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_ciz`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_ciz`(nombre_fc_ciz varchar(40), apellido_p_fc_ciz varchar(30), apellido_m_fc_ciz varchar(30), correo_fc_ciz varchar(40), telefono_fc_ciz varchar(10), firma_fc_ciz varchar(10),calle_fi_ciz varchar(30), num_ext_fi_ciz varchar(6), colonia_fi_ciz varchar(30), codigo_fi_ciz varchar(5), tipo_inmueble_ciz varchar(30) , estado_fi_ciz varchar(20), municipio_fi_ciz varchar(20), id_solicitud int, clave_fc_ciz int)
BEGIN

	SELECT ti.clave_tipo INTO @inm
	FROM tipo_inmueble ti
	WHERE ti.nombre	= tipo_inmueble_ciz;
	
	SELECT c.id_cotizacion INTO @clave_cot
	FROM orden_trabajo ot INNER JOIN cotizacion c
	on ot.id_orden = c.clave_orden
	WHERE ot.clave_solicitud = id_solicitud;
	
	INSERT INTO cliente (apellido_p,apellido_m,nombre,telefono,correo,firma)
	VALUES(apellido_p_fc_ciz,apellido_m_fc_ciz,nombre_fc_ciz,telefono_fc_ciz,correo_fc_ciz,firma_fc_ciz);
	
	INSERT INTO inmueble (clave_inm,estado_republica,municipio,codigo_postal,colonia,calle,numero_exterior,monitoreo,id_tipo, clave_cliente)
	VALUES(clave_fc_ciz,estado_fi_ciz,municipio_fi_ciz,codigo_fi_ciz,colonia_fi_ciz,calle_fi_ciz,num_ext_fi_ciz,"no",@inm,LAST_INSERT_ID());
	
	INSERT INTO instalacion (fecha,clave_cotizacion,clave_inmueble)
	VALUES(CURDATE(),@clave_cot,clave_fc_ciz);

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
-- Procedure structure for sp_agregar_cobranza
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_cobranza`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_cobranza`(nombre varchar(100),monto float,firma varchar(10))
BEGIN
	SELECT m.clave_inm INTO @inm
	FROM usuario u INNER JOIN inmueble m 
	on u.id_mueble = m.clave_inm INNER JOIN cliente c
	on m.clave_cliente = c.id_cliente 
	WHERE c.firma = firma and CONCAT(u.nombre," ",u.apellido_p," ",u.apellido_m) = nombre;
	
	INSERT INTO cobranza (monto,fecha_cobro,clave_inmueble,clave_empleado)
	VALUES (monto,CURRENT_DATE,@inm,3);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_cobranza_mantenimiento
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_cobranza_mantenimiento`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_cobranza_mantenimiento`(nombre varchar(100),monto float,firma varchar(10), observaciones varchar(255))
BEGIN
	SELECT m.clave_inm INTO @inm
	FROM usuario u INNER JOIN inmueble m 
	on u.id_mueble = m.clave_inm INNER JOIN cliente c
	on m.clave_cliente = c.id_cliente 
	WHERE c.firma = firma and CONCAT(u.nombre," ",u.apellido_p," ",u.apellido_m) = nombre;
	
	INSERT INTO cobranza (monto,fecha_cobro,clave_inmueble,clave_empleado)
	VALUES (monto,CURRENT_DATE,@inm,3);
	
	INSERT INTO cobranza_mantenimiento (observaciones,clave_cobranza)
	VALUES (observaciones, LAST_INSERT_ID());

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_contacto
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_contacto`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_contacto`(solicitud int, num_contacto int ,nombre_completo varchar(100),relacion varchar(30),telefono varchar(10))
BEGIN
	
	SELECT i.clave_inm INTO @inm
	FROM solicitud s INNER JOIN orden_trabajo ot 
	on s.id_solicitud = ot.clave_solicitud INNER JOIN cotizacion co
	on ot.id_orden = co.clave_orden INNER JOIN instalacion i
	on co.id_cotizacion = i.clave_cotizacion INNER JOIN inmueble inm
	on i.clave_inmueble = inm.clave_inm
	WHERE s.id_solicitud = solicitud;
	
	INSERT INTO contacto (num_contacto,nombre_completo,relacion,id_inmueble,telefono)
	VALUES (num_contacto,nombre_completo,relacion,@inm,telefono);
	
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
	FROM orden_trabajo ot 
	WHERE ot.clave_solicitud = clave_solicitud;
	
	SELECT c.id_cotizacion INTO @clave
	FROM orden_trabajo ot INNER JOIN cotizacion c 
	on ot.id_orden = c.clave_orden
	WHERE ot.clave_solicitud = clave_solicitud;
	
	UPDATE cotizacion c
	set c.fecha_cotizacion = CURDATE(),c.costo_material=costo_material,c.mano_obra=mano_obra,c.precio_total=(costo_material+mano_obra),c.clave_orden =@id_ot
	WHERE c.id_cotizacion = @clave;
	
	UPDATE solicitud s
	SET s.estatus = "cotizado"
	WHERE s.id_solicitud = clave_solicitud;

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
	
	SELECT c.id_cotizacion INTO @clave
	FROM orden_trabajo ot INNER JOIN cotizacion c
	on ot.id_orden = c.clave_orden
	WHERE ot.clave_solicitud = clave_cotizacion;
	
	INSERT INTO cotizacion_material (clave_material,clave_cotizacion)
	VALUES (@cod,@clave);

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
CREATE PROCEDURE `sp_agregar_orden_trabajo`(observaciones varchar(255),id_orden int, nombre_empleado varchar(100))
BEGIN
	
	SELECT id_empleado INTO @id_e FROM empleado 
	WHERE CONCAT(nombre," ",apellido_p," ",apellido_m) = nombre_empleado;
	
	UPDATE orden_trabajo ot
	SET ot.observaciones = observaciones, ot.clave_empleado=@id_e
	WHERE ot.id_orden = id_orden;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_señal_robo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_señal_robo`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_señal_robo`(clave_inmueble int, tipo_evento varchar(20), nombre_zona varchar(30), evento varchar(30))
BEGIN
	START TRANSACTION;
	
	SELECT clave_tipp INTO @tipo
	FROM tipo_evento 
	WHERE nombre = tipo_evento;
	
	INSERT INTO señal (fecha,hora,clave_inmueble,clave_tipo_evento)
	VALUES (CURDATE(),DATE_FORMAT(NOW( ), "%H:%i:%S" ),clave_inmueble,@tipo);
	
	SELECT id_zona INTO @sr
	FROM zona z INNER JOIN inmueble_zona iz
	on z.id_zona = iz.clave_zona INNER JOIN instalacion i
	on iz.clave_instalacion = i.id_instalacion
	WHERE z.nombre = nombre_zona and i.clave_inmueble = clave_inmueble;
	
	SELECT id_tipo_señal_robo INTO @eve
	FROM tipo_señal_robo
	WHERE nombre = evento;
	
	INSERT INTO señal_robo (id_señal_robo,clave_zona,clave_tipo)
	VALUES (LAST_INSERT_ID(),@sr,@eve);
	
	COMMIT;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_señal_rutina
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_señal_rutina`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_señal_rutina`(clave_inmueble int, tipo_evento varchar(20), usuario varchar(30), evento varchar(30))
BEGIN
	START TRANSACTION;
	
	SELECT clave_tipp INTO @tipo
	FROM tipo_evento 
	WHERE nombre = tipo_evento;
	
	INSERT INTO señal (fecha,hora,clave_inmueble,clave_tipo_evento)
	VALUES (CURDATE(),DATE_FORMAT(NOW( ), "%H:%i:%S" ),clave_inmueble,@tipo);
	
	SELECT u.id_usuario INTO @sr
	FROM usuario u INNER JOIN inmueble i
	on u.id_mueble = i.clave_inm
	WHERE u.num_usuario = usuario and i.clave_inm = clave_inmueble;
	
	SELECT id_señal_rutina INTO @eve
	FROM tipo_señal_rutina
	WHERE nombre = evento;
	
	INSERT INTO señal_rutinaria (id_señal_rutinaria,clave_usuario,clave_tipo)
	VALUES (LAST_INSERT_ID(),@sr,@eve);
	
	COMMIT;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_agregar_señal_sistema
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_agregar_señal_sistema`;
delimiter ;;
CREATE PROCEDURE `sp_agregar_señal_sistema`(clave_inmueble int, tipo_evento varchar(20), evento varchar(30))
BEGIN
	START TRANSACTION;
	
	SELECT clave_tipp INTO @tipo
	FROM tipo_evento 
	WHERE nombre = tipo_evento;
	
	INSERT INTO señal (fecha,hora,clave_inmueble,clave_tipo_evento)
	VALUES (CURDATE(),DATE_FORMAT(NOW( ), "%H:%i:%S" ),clave_inmueble,@tipo);
	
	SELECT id_sistema INTO @eve
	FROM sistema
	WHERE nombre = evento;
	
	INSERT INTO señal_sistema (id_señal_sistema,clave_sistema)
	VALUES (LAST_INSERT_ID(),@eve);
	
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
    WHEN "2" THEN SET @estatus="pendiente de monitoreo";
		WHEN "3" THEN SET @estatus="pendiente de mantenimiento";
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
	
	INSERT INTO orden_trabajo (estatus,clave_solicitud,clave_empleado)
	VALUES("pendiente",LAST_INSERT_ID(),2);

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
	
	INSERT INTO orden_trabajo (estatus,clave_solicitud,clave_empleado)
	VALUES("pendiente",LAST_INSERT_ID(),2);

	
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
	
	INSERT INTO orden_trabajo (estatus,clave_solicitud,clave_empleado)
	VALUES("pendiente",LAST_INSERT_ID(),2);

	
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
CREATE PROCEDURE `sp_agregar_usuario`(solicitud int,num_usuario int,nombre varchar(40),apellido_p varchar(30),apellido_m varchar(30), relacion varchar(30),telefono varchar(10))
BEGIN

	SELECT i.clave_inm INTO @inm
	FROM solicitud s INNER JOIN orden_trabajo ot 
	on s.id_solicitud = ot.clave_solicitud INNER JOIN cotizacion co
	on ot.id_orden = co.clave_orden INNER JOIN instalacion i
	on co.id_cotizacion = i.clave_cotizacion INNER JOIN inmueble inm
	on i.clave_inmueble = inm.clave_inm
	WHERE s.id_solicitud = solicitud;
	
	INSERT INTO contacto (num_usuario,apellido_p,apellido_m,nombre,relacion,id_inmueble,telefono)
	VALUES (num_usuario,apellido_p,apellido_m,nombre,relacion,@inm,telefono);

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
-- Procedure structure for sp_finalizar_ciz
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_finalizar_ciz`;
delimiter ;;
CREATE PROCEDURE `sp_finalizar_ciz`(material_zona_ciz varchar(30), zona_zona_ciz varchar(30),solicitud int)
BEGIN

	SELECT codigo_dis INTO @cod
	FROM material 
	WHERE nombre = material_zona_ciz;
	
	SELECT i.id_instalacion INTO @inst
	FROM orden_trabajo ot INNER JOIN cotizacion c
	on ot.id_orden = c.clave_orden INNER JOIN instalacion i 
	on i.clave_cotizacion = c.id_cotizacion
	WHERE ot.clave_solicitud = solicitud;
	
	INSERT INTO zona (nombre)
	VALUES (zona_zona_ciz);
	
	INSERT INTO inmueble_zona (clave_zona,clave_material,clave_instalacion)
	VALUES (LAST_INSERT_ID(), @cod,@inst);
	
	UPDATE solicitud
	set estatus = "finalizada"
	WHERE id_solicitud=solicitud;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_generar_cotizacion
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_generar_cotizacion`;
delimiter ;;
CREATE PROCEDURE `sp_generar_cotizacion`(clave_solicitud int)
BEGIN

	SELECT ot.id_orden INTO @id_o
	FROM orden_trabajo ot
	WHERE ot.clave_solicitud = clave_solicitud;
	
	INSERT INTO cotizacion (clave_orden)
	VALUES (@id_o);
	

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
-- Procedure structure for sp_mostrar_detalle_orden_trabajo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_mostrar_detalle_orden_trabajo`;
delimiter ;;
CREATE PROCEDURE `sp_mostrar_detalle_orden_trabajo`(inmueble int)
BEGIN
	(SELECT ot.id_orden,i.clave_inm,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_cliente sc
on sc.id_solicitud_cliente = ot.clave_solicitud INNER JOIN cliente c
on sc.clave_cliente = c.id_cliente INNER JOIN inmueble i
on c.id_cliente = i.clave_cliente WHERE ot.id_orden = inmueble)
UNION
(SELECT ot.id_orden,i.clave_inm,CONCAT(c.nombre," ",c.apellido_p," ",c.apellido_m) as nombre,CONCAT(i.calle," ",i.numero_exterior," ",i.colonia) as domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_inmueble si
on si.id_solicitud_inmueble = ot.clave_solicitud INNER JOIN cliente c
on si.clave_cliente = c.id_cliente INNER JOIN inmueble i
on c.id_cliente = i.clave_cliente WHERE ot.id_orden = inmueble) 
UNION
(SELECT ot.id_orden,"Sin asignar",sp.nombre_completo as nombre, sp.domicilio, s.fecha_visita, s.hora, ot.observaciones
FROM orden_trabajo ot INNER JOIN solicitud s
on ot.clave_solicitud = s.id_solicitud INNER JOIN empleado e
on ot.clave_empleado = e.id_empleado INNER JOIN solicitud_pendiente sp
on sp.id_solicitud_pendiente = ot.clave_solicitud WHERE ot.id_orden = inmueble);

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for sp_zona_inmueble_robo
-- ----------------------------
DROP PROCEDURE IF EXISTS `sp_zona_inmueble_robo`;
delimiter ;;
CREATE PROCEDURE `sp_zona_inmueble_robo`(clave int)
BEGIN

	SELECT z.nombre FROM inmueble inm INNER JOIN instalacion i 
	on i.clave_inmueble = inm.clave_inm INNER JOIN inmueble_zona iz
	on i.id_instalacion = iz.clave_instalacion INNER JOIN zona z
	on iz.clave_zona=z.id_zona WHERE inm.clave_inm = clave;

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

SET FOREIGN_KEY_CHECKS = 1;
