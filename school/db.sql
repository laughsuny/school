/*
Navicat MySQL Data Transfer

Source Server         : localMysql
Source Server Version : 50624
Source Host           : localhost:3306
Source Database       : mydb

Target Server Type    : MYSQL
Target Server Version : 50624
File Encoding         : 65001

Date: 2016-06-21 11:20:31
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for dictionary
-- ----------------------------
DROP TABLE IF EXISTS `dictionary`;
CREATE TABLE `dictionary` (
  `dict_name` varchar(50) NOT NULL COMMENT '字典名字',
  `dict_value` int(11) NOT NULL COMMENT '固定不变的'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionary
-- ----------------------------
INSERT INTO `dictionary` VALUES ('gender', '1');
INSERT INTO `dictionary` VALUES ('requirement_type', '2');

-- ----------------------------
-- Table structure for dictionarydata
-- ----------------------------
DROP TABLE IF EXISTS `dictionarydata`;
CREATE TABLE `dictionarydata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `dict_value` int(11) NOT NULL COMMENT 'dicttionary中的值',
  `dictdata_name` varchar(50) NOT NULL,
  `dictdata_value` varchar(5) NOT NULL,
  `isfixed` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dictionarydata
-- ----------------------------
INSERT INTO `dictionarydata` VALUES ('1', '1', '男', '0', '0');
INSERT INTO `dictionarydata` VALUES ('2', '1', '女', '1', '0');
INSERT INTO `dictionarydata` VALUES ('3', '1', '不限', '2', '0');
INSERT INTO `dictionarydata` VALUES ('4', '2', '舞者', '0', '0');
INSERT INTO `dictionarydata` VALUES ('5', '2', '歌手', '1', '0');
INSERT INTO `dictionarydata` VALUES ('6', '2', '主持', '2', '0');
INSERT INTO `dictionarydata` VALUES ('7', '2', '演员', '3', '0');

-- ----------------------------
-- Table structure for fs_article
-- ----------------------------
DROP TABLE IF EXISTS `fs_article`;
CREATE TABLE `fs_article` (
  `ID` int(11) NOT NULL,
  `TITLE` varchar(255) DEFAULT NULL,
  `SROUCE` varchar(100) DEFAULT NULL,
  `KEYWORD` varchar(100) DEFAULT NULL,
  `SUMMARY` text,
  `CONTEXT` text,
  `LOGO` varchar(100) DEFAULT NULL,
  `VIEW_COUNT` int(11) DEFAULT NULL,
  `CREATE_USER` int(11) DEFAULT NULL,
  `CREATE_TIME` date DEFAULT NULL,
  `ISCHECH` int(11) DEFAULT NULL,
  `ISTOP` int(11) DEFAULT NULL,
  `ISRECOMMEND` int(11) DEFAULT NULL,
  `ORDER_NUM` int(11) DEFAULT NULL,
  `MENU_ID` varchar(100) DEFAULT NULL,
  `ISDISPLAY` int(11) DEFAULT NULL,
  `UNPASSREASON` varchar(300) DEFAULT NULL,
  `EDITTPE` int(11) DEFAULT NULL,
  `STATUS` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `FK_Reference_6` (`MENU_ID`),
  KEY `FK_Reference_7` (`CREATE_USER`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文章表';

-- ----------------------------
-- Records of fs_article
-- ----------------------------

-- ----------------------------
-- Table structure for fs_attachment
-- ----------------------------
DROP TABLE IF EXISTS `fs_attachment`;
CREATE TABLE `fs_attachment` (
  `ID` int(11) NOT NULL,
  `NAME` varchar(50) DEFAULT NULL,
  `URL` varchar(100) DEFAULT NULL,
  `EXT` varchar(20) DEFAULT NULL,
  `TYPE` int(11) DEFAULT NULL,
  `FKID` int(11) DEFAULT NULL,
  `CREATE_TIME` date DEFAULT NULL,
  `CREATE_USER` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='文件附件';

-- ----------------------------
-- Records of fs_attachment
-- ----------------------------

-- ----------------------------
-- Table structure for sysbutton
-- ----------------------------
DROP TABLE IF EXISTS `sysbutton`;
CREATE TABLE `sysbutton` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(255) DEFAULT NULL COMMENT '按钮名称',
  `menu_id` int(11) DEFAULT NULL COMMENT '菜单id 表sysmenu:id',
  `sec` varchar(255) DEFAULT NULL COMMENT '排序 ASC升序 数值小的在前',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='按钮定义表';

-- ----------------------------
-- Records of sysbutton
-- ----------------------------

-- ----------------------------
-- Table structure for sysdepartment
-- ----------------------------
DROP TABLE IF EXISTS `sysdepartment`;
CREATE TABLE `sysdepartment` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) DEFAULT NULL COMMENT '部门名称',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `status` int(11) DEFAULT NULL,
  `create_user` int(11) DEFAULT NULL COMMENT '创建人id 表sysuser:id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_4` (`create_user`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='部门表';

-- ----------------------------
-- Records of sysdepartment
-- ----------------------------
INSERT INTO `sysdepartment` VALUES ('1', '开发部门', '开发', '2016-06-03 12:32:59', null, '1');

-- ----------------------------
-- Table structure for sysmenu
-- ----------------------------
DROP TABLE IF EXISTS `sysmenu`;
CREATE TABLE `sysmenu` (
  `id` int(20) NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `pid` varchar(20) DEFAULT NULL COMMENT '所属菜单id  pid为0表示1级菜单',
  `name` varchar(150) DEFAULT NULL,
  `url` varchar(100) DEFAULT NULL COMMENT '菜单跳转地址',
  `seq` int(11) DEFAULT NULL COMMENT '同级菜单排序 ASC升序 值小的在前',
  `desctxt` varchar(500) DEFAULT NULL,
  `pic_url` varchar(100) DEFAULT NULL COMMENT '菜单图片地址',
  `layer_id` int(11) DEFAULT NULL COMMENT '菜单层级 如 1 1级菜单 2 2级菜单',
  `root_id` int(11) DEFAULT NULL COMMENT '当前菜单根目录',
  `status` int(11) DEFAULT NULL,
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` int(11) DEFAULT NULL COMMENT '创建用户id 表sysuser:id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_5` (`create_user`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='系统菜单表';

-- ----------------------------
-- Records of sysmenu
-- ----------------------------
INSERT INTO `sysmenu` VALUES ('1', '0', '系统管理', null, '1', '系统管理菜单', null, '1', '0', '1', '2016-06-01 20:17:40', '1');
INSERT INTO `sysmenu` VALUES ('2', '1', '角色管理', '/admin/role/list.do', '1', '角色管理菜单', null, '2', '1', '1', '2016-06-01 20:36:59', '1');
INSERT INTO `sysmenu` VALUES ('3', '1', '用户管理', '/admin/user/list.do', '2', '用户管理菜单', null, '2', '1', '1', '2016-06-01 20:38:40', '1');
INSERT INTO `sysmenu` VALUES ('4', '1', '菜单管理', null, '3', '菜单管理菜单', null, '2', '1', '1', '2016-06-01 20:41:06', '1');
INSERT INTO `sysmenu` VALUES ('5', '1', '部门管理', '/admin/department/list.do', '4', '部门管理菜单', null, '2', '1', '1', '2016-06-01 20:42:25', '1');
INSERT INTO `sysmenu` VALUES ('6', '1', '修改密码', null, '5', '修改密码菜单', null, '2', '1', '1', '2016-06-01 20:42:49', '1');
INSERT INTO `sysmenu` VALUES ('7', '0', '数据统计', null, '2', '数据统计此单', null, '1', '0', '1', '2016-06-01 20:44:13', '1');
INSERT INTO `sysmenu` VALUES ('8', '7', '操作日志', null, '1', '操作日志菜单', null, '2', '7', '1', '2016-06-01 20:45:12', '1');

-- ----------------------------
-- Table structure for sysrole
-- ----------------------------
DROP TABLE IF EXISTS `sysrole`;
CREATE TABLE `sysrole` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `rolename` varchar(255) DEFAULT NULL COMMENT '角色名',
  `desctxt` varchar(255) DEFAULT NULL COMMENT '角色描述',
  `buttons` varchar(255) DEFAULT NULL COMMENT '该角色所拥有的按钮id集合，以逗号为分隔',
  `status` int(11) DEFAULT NULL COMMENT '角色状态 0删除 1正常',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` int(11) DEFAULT NULL COMMENT '创建人id 表sysuer:id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_1` (`create_user`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8 COMMENT='角色表';

-- ----------------------------
-- Records of sysrole
-- ----------------------------
INSERT INTO `sysrole` VALUES ('1', '系统管理员', '后台系统管理员', '', '1', '2016-06-02 10:00:08', '2016-06-02 10:00:10', '1');
INSERT INTO `sysrole` VALUES ('29', '测试角色', '12321', null, '1', '2016-06-03 12:37:47', '2016-06-03 12:37:47', '1');

-- ----------------------------
-- Table structure for sysrolemenu
-- ----------------------------
DROP TABLE IF EXISTS `sysrolemenu`;
CREATE TABLE `sysrolemenu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id主键',
  `role_id` int(11) NOT NULL COMMENT '角色id 表sysrole:id',
  `menu_id` int(11) NOT NULL COMMENT '菜单id 表sysmenu:id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色菜单中间表';

-- ----------------------------
-- Records of sysrolemenu
-- ----------------------------

-- ----------------------------
-- Table structure for sysroleuser
-- ----------------------------
DROP TABLE IF EXISTS `sysroleuser`;
CREATE TABLE `sysroleuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `user_id` int(11) DEFAULT NULL COMMENT '用户id 表sysuser:id',
  `role_id` int(11) DEFAULT NULL COMMENT '角色id 表sysrole:id',
  PRIMARY KEY (`id`),
  KEY `FK_Reference_2` (`user_id`),
  KEY `FK_Reference_3` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='系统角色用户表';

-- ----------------------------
-- Records of sysroleuser
-- ----------------------------
INSERT INTO `sysroleuser` VALUES ('1', '15', '29');
INSERT INTO `sysroleuser` VALUES ('2', '16', '1');
INSERT INTO `sysroleuser` VALUES ('3', '16', '29');

-- ----------------------------
-- Table structure for sysuser
-- ----------------------------
DROP TABLE IF EXISTS `sysuser`;
CREATE TABLE `sysuser` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `username` varchar(50) DEFAULT NULL COMMENT '用户名称',
  `account` varchar(150) DEFAULT NULL COMMENT '登陆账号',
  `password` varchar(50) DEFAULT NULL COMMENT '登陆密码 MD5加密',
  `user_type` int(11) DEFAULT NULL COMMENT '用户类型  0超级管理员 1普通用户',
  `desctxt` varchar(200) DEFAULT NULL COMMENT '用户描述备注',
  `isedit` int(11) DEFAULT NULL COMMENT '是否可编辑 0否 1是',
  `department_id` int(11) DEFAULT NULL COMMENT '部门id',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(15) DEFAULT NULL COMMENT '手机号码',
  `status` int(11) DEFAULT NULL COMMENT '用户状态 0逻辑删除 1 正常 2锁定登陆',
  `last_login_ip` varchar(50) DEFAULT NULL COMMENT '最后登陆ip地址',
  `last_login_time` datetime DEFAULT NULL COMMENT '最后登陆时间',
  `update_time` datetime DEFAULT NULL COMMENT '修改时间',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `create_user` int(11) DEFAULT NULL COMMENT '创建人id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8 COMMENT='后台用户表';

-- ----------------------------
-- Records of sysuser
-- ----------------------------
INSERT INTO `sysuser` VALUES ('1', '系统管理员', 'admin', 'admin', '0', null, '0', null, null, null, '1', null, '2016-06-02 15:02:28', '2016-06-02 15:02:31', '2016-06-03 14:07:48', null);
INSERT INTO `sysuser` VALUES ('13', '张旭333', 'suny', null, '0', null, '1', null, null, null, '1', null, null, null, '2016-06-01 22:00:00', null);
INSERT INTO `sysuser` VALUES ('15', '随便啊', '随便', 'A5D420FBC2491416', '1', null, '1', '0', '', null, '1', null, null, null, null, null);
INSERT INTO `sysuser` VALUES ('16', '测试人员', 'test', 'A5D420FBC2491416', '1', null, '1', '1', '123@163.com', '13511445554', '1', null, null, null, '2016-06-03 16:54:16', '1');
INSERT INTO `sysuser` VALUES ('17', 'hehe', 'hehe', 'A5D420FBC2491416', '0', null, '0', '0', '', '', '0', null, null, null, '2016-06-03 18:08:18', '1');
