/*
Navicat MySQL Data Transfer

Source Server         : benj
Source Server Version : 50628
Source Host           : localhost:3306
Source Database       : jfinal_admin

Target Server Type    : MYSQL
Target Server Version : 50628
File Encoding         : 65001

Date: 2017-05-09 15:30:05
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `sys_department`
-- ----------------------------
DROP TABLE IF EXISTS `sys_department`;
CREATE TABLE `sys_department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) DEFAULT '0' COMMENT '上级机构',
  `name` varchar(32) NOT NULL COMMENT '部门/11111',
  `code` varchar(128) DEFAULT NULL COMMENT '机构编码',
  `sort` int(11) DEFAULT '0' COMMENT '序号',
  `linkman` varchar(64) DEFAULT NULL COMMENT '联系人',
  `linkman_no` varchar(32) DEFAULT NULL COMMENT '联系人电话',
  `remark` varchar(128) DEFAULT NULL COMMENT '机构描述',
  `update_time` varchar(64) DEFAULT NULL COMMENT '更新时间',
  `update_id` int(11) DEFAULT '0' COMMENT '更新者',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COMMENT='部门';

-- ----------------------------
-- Records of sys_department
-- ----------------------------
INSERT INTO `sys_department` VALUES ('1', '0', '系统承建单位', null, '99', 'system', '15888888888', null, '2016-06-06 06:06:06', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_department` VALUES ('2', '0', '注册用户', null, '97', '无人', '15888888888', null, '2015-04-28 22:39:34', '1', '2015-04-28 22:39:34', '1');
INSERT INTO `sys_department` VALUES ('3', '0', '第三方用户', null, '90', '无人', '15888888888', null, '2015-06-01 12:39:41', '1', '2015-06-01 12:39:41', '1');
INSERT INTO `sys_department` VALUES ('4', '0', 'FLY的狐狸', 'ABC000', '100', null, null, null, '2016-07-31 18:12:30', '1', '2016-07-31 18:12:30', '1');
INSERT INTO `sys_department` VALUES ('5', '4', '开发部', 'ABC001', '101', null, null, null, '2016-07-31 18:15:29', '1', '2016-07-31 18:15:29', '1');
INSERT INTO `sys_department` VALUES ('6', '4', '财务部', 'ABC003', '103', null, null, null, '2016-07-31 18:16:06', '1', '2016-07-31 18:16:06', '1');
INSERT INTO `sys_department` VALUES ('7', '4', '人事部', 'ABC004', '104', null, null, null, '2016-07-31 18:16:30', '1', '2016-07-31 18:16:30', '1');
INSERT INTO `sys_department` VALUES ('8', '5', '测试部', 'ABC0011', '101', null, null, null, '2016-07-31 18:16:52', '1', '2016-07-31 18:16:52', '1');

-- ----------------------------
-- Table structure for `sys_dict`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict`;
CREATE TABLE `sys_dict` (
  `dict_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_name` varchar(256) NOT NULL COMMENT '名称',
  `dict_type` varchar(64) NOT NULL COMMENT '类型',
  `dict_remark` varchar(256) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`dict_id`),
  UNIQUE KEY `UK_SYS_DICT_TYPE` (`dict_type`)
) ENGINE=InnoDB AUTO_INCREMENT=103 DEFAULT CHARSET=utf8 COMMENT='数据字典主表';

-- ----------------------------
-- Records of sys_dict
-- ----------------------------
INSERT INTO `sys_dict` VALUES ('1', '日志配置', 'systemLog', null);
INSERT INTO `sys_dict` VALUES ('2', '目录类型', 'articleType', null);
INSERT INTO `sys_dict` VALUES ('11', '目录类型', 'folderType', null);
INSERT INTO `sys_dict` VALUES ('100', '系统参数', 'systemParam', null);
INSERT INTO `sys_dict` VALUES ('101', '友情链接类型', 'friendlyLinkType', null);
INSERT INTO `sys_dict` VALUES ('102', '栏目类型', 'materialType', null);

-- ----------------------------
-- Table structure for `sys_dict_detail`
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_detail`;
CREATE TABLE `sys_dict_detail` (
  `detail_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `dict_type` varchar(64) NOT NULL COMMENT '数据字典类型',
  `detail_name` varchar(256) DEFAULT NULL COMMENT '名称',
  `detail_code` varchar(32) DEFAULT NULL COMMENT '代码',
  `detail_sort` varchar(32) DEFAULT NULL COMMENT '排序号',
  `detail_type` varchar(32) DEFAULT NULL COMMENT '类型',
  `detail_state` varchar(32) DEFAULT NULL COMMENT '状态',
  `detail_content` varchar(256) DEFAULT NULL COMMENT '内容',
  `detail_remark` varchar(256) DEFAULT NULL COMMENT '备注',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`detail_id`)
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=utf8 COMMENT='数据字典';

-- ----------------------------
-- Records of sys_dict_detail
-- ----------------------------
INSERT INTO `sys_dict_detail` VALUES ('1', 'folderType', '目录', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('2', 'folderType', 'a标签', '2', '2', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('3', 'folderType', 'a标签target', '3', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('4', 'folderType', 'html标签', '4', '4', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('11', 'articleType', '正常', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('12', 'articleType', '预览', '2', '2', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('13', 'articleType', '程序', '3', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('21', 'friendlyLinkType', '友情链接', null, '1', null, null, null, null, '2015-05-06 15:18:59', '1');
INSERT INTO `sys_dict_detail` VALUES ('22', 'friendlyLinkType', '关于我们', null, '2', null, null, null, null, '2015-05-06 15:19:20', '1');
INSERT INTO `sys_dict_detail` VALUES ('51', 'systemLog', 'sys_dict', '数据字典主表', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('52', 'systemLog', 'sys_dict_detail', '数据字典', '2', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('53', 'systemLog', 'sys_menu', '菜单管理', '3', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('54', 'systemLog', 'sys_department', '组织机构', '4', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('55', 'systemLog', 'sys_user', '用户管理', '5', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('56', 'systemLog', 'sys_user_role', '用户角色授权', '6', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('57', 'systemLog', 'sys_role', '角色管理', '7', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('58', 'systemLog', 'sys_role_folder', '角色目录授权', '8', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('59', 'systemLog', 'sys_role_menu', '角色菜单授权', '9', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('60', 'systemLog', 'tb_folder', '目录管理', '10', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('61', 'systemLog', 'tb_article', '文章管理', '11', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('62', 'systemLog', 'tb_articlelike', '喜欢的文章管理', '12', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('63', 'systemLog', 'tb_comment', '评论管理', '13', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('64', 'systemLog', 'tb_tags', '标签管理', '14', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('65', 'systemLog', 'tb_contact', '联系人', '15', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('66', 'systemLog', 'tb_error', '错误管理', '16', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('67', 'systemLog', 'tb_friendlylink', '友情链接', '17', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('68', 'systemLog', 'tb_pageview', '访问量统计', '18', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('101', 'systemParam', '门头沟信息网', '1', '1', null, null, null, null, '2015-01-30', '1');
INSERT INTO `sys_dict_detail` VALUES ('102', 'materialType', '文章', '1', '1', null, null, null, null, '2016-03-31 22:35:05', '1');
INSERT INTO `sys_dict_detail` VALUES ('103', 'materialType', '图片', '2', '2', null, null, null, null, '2016-03-31 22:35:17', '1');
INSERT INTO `sys_dict_detail` VALUES ('104', 'materialType', '视频', '3', '3', null, null, null, null, '2016-03-31 22:35:28', '1');
INSERT INTO `sys_dict_detail` VALUES ('105', 'materialType', '其他', '9', '9', null, null, null, null, '2016-03-31 22:35:39', '1');
INSERT INTO `sys_dict_detail` VALUES ('106', 'materialType', '栏目', '6', '6', null, null, null, null, '2016-03-31 23:46:27', '1');
INSERT INTO `sys_dict_detail` VALUES ('107', 'systemLog', 'tb_site', '站点管理', '19', null, null, null, null, '2016-04-14 00:02:45', '1');

-- ----------------------------
-- Table structure for `sys_log`
-- ----------------------------
DROP TABLE IF EXISTS `sys_log`;
CREATE TABLE `sys_log` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `log_type` int(11) NOT NULL COMMENT '类型',
  `oper_object` varchar(64) DEFAULT NULL COMMENT '操作对象',
  `oper_table` varchar(64) NOT NULL COMMENT '操作表',
  `oper_id` int(11) DEFAULT '0' COMMENT '操作主键',
  `oper_type` varchar(64) DEFAULT NULL COMMENT '操作类型',
  `oper_remark` varchar(100) DEFAULT NULL COMMENT '操作备注',
  `create_time` varchar(64) NOT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8 COMMENT='日志';

-- ----------------------------
-- Records of sys_log
-- ----------------------------
INSERT INTO `sys_log` VALUES ('1', '1', '访问量统计', 'tb_pageview', '111', '添加', '', '2017-05-08 14:23:28', '0');
INSERT INTO `sys_log` VALUES ('2', '2', '用户管理', 'sys_user', '1', '登入', '', '2017-05-08 14:26:43', '1');
INSERT INTO `sys_log` VALUES ('3', '1', null, 'tb_pageview', '112', '添加', '', '2017-05-08 15:47:39', '0');
INSERT INTO `sys_log` VALUES ('4', '1', null, 'tb_pageview', '113', '添加', '', '2017-05-08 15:49:18', '0');
INSERT INTO `sys_log` VALUES ('5', '1', null, 'tb_pageview', '114', '添加', '', '2017-05-08 16:00:51', '0');
INSERT INTO `sys_log` VALUES ('6', '1', null, 'tb_pageview', '115', '添加', '', '2017-05-08 16:23:17', '0');
INSERT INTO `sys_log` VALUES ('7', '1', null, 'tb_pageview', '116', '添加', '', '2017-05-08 16:52:22', '0');
INSERT INTO `sys_log` VALUES ('8', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:24:33', '1');
INSERT INTO `sys_log` VALUES ('9', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:54:16', '1');
INSERT INTO `sys_log` VALUES ('10', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 17:55:14', '1');
INSERT INTO `sys_log` VALUES ('11', '1', null, 'sys_menu', '21', '更新', '', '2017-05-08 18:08:31', '1');
INSERT INTO `sys_log` VALUES ('12', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:08:41', '1');
INSERT INTO `sys_log` VALUES ('13', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:08:55', '1');
INSERT INTO `sys_log` VALUES ('14', '1', null, 'sys_menu', '18', '删除', '', '2017-05-08 18:11:35', '1');
INSERT INTO `sys_log` VALUES ('15', '1', null, 'sys_menu', '8', '删除', '', '2017-05-08 18:11:43', '1');
INSERT INTO `sys_log` VALUES ('16', '1', null, 'sys_menu', '16', '删除', '', '2017-05-08 18:11:52', '1');
INSERT INTO `sys_log` VALUES ('17', '1', null, 'sys_menu', '17', '删除', '', '2017-05-08 18:11:56', '1');
INSERT INTO `sys_log` VALUES ('18', '1', null, 'sys_menu', '9', '删除', '', '2017-05-08 18:12:00', '1');
INSERT INTO `sys_log` VALUES ('19', '1', null, 'sys_menu', '29', '删除', '', '2017-05-08 18:12:05', '1');
INSERT INTO `sys_log` VALUES ('20', '1', null, 'sys_menu', '25', '删除', '', '2017-05-08 18:12:09', '1');
INSERT INTO `sys_log` VALUES ('21', '1', null, 'sys_menu', '22', '删除', '', '2017-05-08 18:12:13', '1');
INSERT INTO `sys_log` VALUES ('22', '1', null, 'sys_menu', '24', '删除', '', '2017-05-08 18:12:17', '1');
INSERT INTO `sys_log` VALUES ('23', '1', null, 'sys_menu', '23', '删除', '', '2017-05-08 18:12:21', '1');
INSERT INTO `sys_log` VALUES ('24', '1', null, 'sys_menu', '26', '删除', '', '2017-05-08 18:12:25', '1');
INSERT INTO `sys_log` VALUES ('25', '1', null, 'sys_menu', '27', '删除', '', '2017-05-08 18:12:28', '1');
INSERT INTO `sys_log` VALUES ('26', '1', null, 'sys_menu', '19', '删除', '', '2017-05-08 18:12:32', '1');
INSERT INTO `sys_log` VALUES ('27', '1', null, 'sys_menu', '12', '删除', '', '2017-05-08 18:12:35', '1');
INSERT INTO `sys_log` VALUES ('28', '1', null, 'sys_menu', '15', '删除', '', '2017-05-08 18:12:38', '1');
INSERT INTO `sys_log` VALUES ('29', '1', null, 'sys_menu', '20', '删除', '', '2017-05-08 18:12:42', '1');
INSERT INTO `sys_log` VALUES ('30', '1', null, 'sys_menu', '30', '删除', '', '2017-05-08 18:12:54', '1');
INSERT INTO `sys_log` VALUES ('31', '1', null, 'sys_menu', '13', '删除', '', '2017-05-08 18:12:58', '1');
INSERT INTO `sys_log` VALUES ('32', '1', null, 'sys_menu', '10', '删除', '', '2017-05-08 18:13:01', '1');
INSERT INTO `sys_log` VALUES ('33', '1', null, 'sys_menu', '11', '删除', '', '2017-05-08 18:13:04', '1');
INSERT INTO `sys_log` VALUES ('34', '1', null, 'sys_menu', '7', '删除', '', '2017-05-08 18:13:08', '1');
INSERT INTO `sys_log` VALUES ('35', '1', null, 'sys_menu', '28', '删除', '', '2017-05-08 18:13:16', '1');
INSERT INTO `sys_log` VALUES ('36', '1', null, 'sys_menu', '28', '删除', '', '2017-05-08 18:13:25', '1');
INSERT INTO `sys_log` VALUES ('37', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:13:30', '1');
INSERT INTO `sys_log` VALUES ('38', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:13:46', '1');
INSERT INTO `sys_log` VALUES ('39', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:32:46', '1');
INSERT INTO `sys_log` VALUES ('40', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:33:30', '1');
INSERT INTO `sys_log` VALUES ('41', '1', null, 'sys_menu', '31', '删除', '', '2017-05-08 18:39:38', '1');
INSERT INTO `sys_log` VALUES ('42', '2', null, 'sys_user', '1', '登出', '', '2017-05-08 18:39:52', '1');
INSERT INTO `sys_log` VALUES ('43', '2', null, 'sys_user', '1', '登入', '', '2017-05-08 18:40:03', '1');
INSERT INTO `sys_log` VALUES ('44', '2', null, 'sys_user', '1', '登入', '', '2017-05-09 09:28:39', '1');
INSERT INTO `sys_log` VALUES ('45', '2', null, 'sys_user', '1', '登入', '', '2017-05-09 11:26:06', '1');

-- ----------------------------
-- Table structure for `sys_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `parentid` int(11) NOT NULL DEFAULT '0' COMMENT '父id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '名称/11111',
  `urlkey` varchar(256) DEFAULT NULL COMMENT '菜单key',
  `url` varchar(256) DEFAULT NULL COMMENT '链接地址',
  `status` int(11) DEFAULT '1' COMMENT '状态//radio/2,隐藏,1,显示',
  `type` int(11) DEFAULT '1' COMMENT '类型//select/1,根目录,2,a标签,3,a标签_blank,4,外部url',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `level` int(11) DEFAULT '1' COMMENT '级别',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COMMENT='菜单';

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES ('1', '0', '系统管理', 'system_root', null, '1', '1', '90', '1', '2015-04-27 17:28:06', '1');
INSERT INTO `sys_menu` VALUES ('2', '1', '组织机构', 'department', 'system/department', '1', '1', '91', '2', '2015-04-27 17:28:25', '1');
INSERT INTO `sys_menu` VALUES ('3', '1', '用户管理', 'user', 'system/user', '1', '1', '92', '2', '2015-04-27 17:28:46', '1');
INSERT INTO `sys_menu` VALUES ('4', '1', '角色管理', 'role', 'system/role', '1', '1', '94', '2', '2015-04-27 17:29:13', '1');
INSERT INTO `sys_menu` VALUES ('5', '1', '菜单管理', 'menu', 'system/menu', '1', '1', '96', '2', '2015-04-27 17:29:43', '1');
INSERT INTO `sys_menu` VALUES ('6', '1', '数据字典', 'dict', 'system/dict', '1', '1', '97', '2', '2015-04-27 17:30:05', '1');
INSERT INTO `sys_menu` VALUES ('14', '1', '日志管理', 'log', 'system/log/list', '1', '1', '98', '2', '2016-01-03 18:09:18', '1');
INSERT INTO `sys_menu` VALUES ('21', '0', '首页', 'home', 'home', '1', '1', '2', '1', '2015-04-27 17:28:06', '1');

-- ----------------------------
-- Table structure for `sys_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `name` varchar(200) NOT NULL DEFAULT '' COMMENT '名称/11111/',
  `status` int(11) DEFAULT '1' COMMENT '状态//radio/2,隐藏,1,显示',
  `sort` int(11) DEFAULT '1' COMMENT '排序',
  `remark` text COMMENT '说明//textarea',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8 COMMENT='角色';

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES ('1', '测试角色', '1', '1', null, '2016-03-31 23:41:59', '1');

-- ----------------------------
-- Table structure for `sys_role_menu`
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  `menuid` int(11) NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='角色和菜单关联';

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------

-- ----------------------------
-- Table structure for `sys_user`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `userid` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `username` varchar(32) NOT NULL COMMENT '用户名/11111',
  `password` varchar(32) NOT NULL COMMENT '密码',
  `realname` varchar(32) DEFAULT NULL COMMENT '真实姓名',
  `departid` int(11) DEFAULT '0' COMMENT '部门/11111/dict',
  `usertype` int(11) DEFAULT '2' COMMENT '类型//select/1,管理员,2,普通用户,3,前台用户,4,第三方用户,5,API用户',
  `state` int(11) DEFAULT '10' COMMENT '状态',
  `thirdid` varchar(200) DEFAULT NULL COMMENT '第三方ID',
  `endtime` varchar(32) DEFAULT NULL COMMENT '结束时间',
  `email` varchar(64) DEFAULT NULL COMMENT 'email',
  `tel` varchar(32) DEFAULT NULL COMMENT '手机号',
  `address` varchar(32) DEFAULT NULL COMMENT '地址',
  `title_url` varchar(200) DEFAULT NULL COMMENT '头像地址',
  `remark` varchar(1000) DEFAULT NULL COMMENT '说明',
  `theme` varchar(64) DEFAULT 'default' COMMENT '主题',
  `back_site_id` int(11) DEFAULT '0' COMMENT '后台选择站点ID',
  `create_site_id` int(11) DEFAULT '1' COMMENT '创建站点ID',
  `create_time` varchar(64) DEFAULT NULL COMMENT '创建时间',
  `create_id` int(11) DEFAULT '0' COMMENT '创建者',
  PRIMARY KEY (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COMMENT='用户';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', 'admin', 'EY3JNDE7nu8=', '系统管理员', '1', '1', '10', null, null, 'zcool321@sina.com', '123', null, null, '时间是最好的老师，但遗憾的是——最后他把所有的学生都弄死了', 'flat', '5', '1', '2016-06-06 06:06:06', '1');
INSERT INTO `sys_user` VALUES ('2', 'testapi', 'EY3JNDE7nu8=', 'api测试', '1', '5', '10', null, null, null, null, null, null, null, 'default', '0', '1', '2017-03-19 20:41:25', '1');
INSERT INTO `sys_user` VALUES ('3', 'test2', 'EY3JNDE7nu8=', '测试', '2', '2', '10', null, null, null, null, null, null, null, 'flat', '0', '1', '2017-05-08 18:10:16', '1');

-- ----------------------------
-- Table structure for `sys_user_role`
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'id',
  `userid` int(11) NOT NULL COMMENT '用户id',
  `roleid` int(11) NOT NULL COMMENT '角色id',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户和角色关联';

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
