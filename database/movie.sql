/*
 Navicat Premium Dump SQL

 Source Server         : 2026-SE3
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : movie

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 08/07/2026 16:40:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for actor
-- ----------------------------
DROP TABLE IF EXISTS `actor`;
CREATE TABLE `actor`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '演员 ID',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '演员姓名',
  `name_en` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '英文名',
  `gender` tinyint NULL DEFAULT 0 COMMENT '性别 0-未知 1-男 2-女',
  `birth_date` date NULL DEFAULT NULL COMMENT '出生日期',
  `nationality` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '国籍',
  `filmography` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '参演作品列表（逗号分隔）',
  `description` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '简介',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_name_en`(`name_en` ASC) USING BTREE,
  INDEX `idx_nationality`(`nationality` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '演员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of actor
-- ----------------------------
INSERT INTO `actor` VALUES (1, '马修·麦康纳', 'Matthew McConaughey', 1, '1969-11-04', '美国', '星际穿越, 达拉斯买家俱乐部, 真探, 林肯律师', '美国男演员，代表作星际穿越', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (2, '安妮·海瑟薇', 'Anne Hathaway', 2, '1982-11-12', '美国', '星际穿越, 悲惨世界, 穿普拉达的女王, 爱丽丝梦游仙境', '美国女演员，代表作悲惨世界', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (3, '莱昂纳多·迪卡普里奥', 'Leonardo DiCaprio', 1, '1974-11-11', '美国', '泰坦尼克号, 盗梦空间, 荒野猎人, 华尔街之狼', '美国男演员，代表作泰坦尼克号', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (4, '凯特·温丝莱特', 'Kate Winslet', 2, '1975-10-05', '英国', '泰坦尼克号, 朗读者, 革命之路', '英国女演员，代表作泰坦尼克号', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (5, '布拉德·皮特', 'Brad Pitt', 1, '1963-12-18', '美国', '搏击俱乐部, 七宗罪, 好莱坞往事', '美国男演员，代表作搏击俱乐部', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (6, '蒂姆·罗宾斯', 'Tim Robbins', 1, '1958-10-16', '美国', '肖申克的救赎, 神秘河', '美国男演员，代表作肖申克的救赎', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (7, '摩根·弗里曼', 'Morgan Freeman', 1, '1937-06-01', '美国', '肖申克的救赎, 七宗罪, 蝙蝠侠', '美国男演员，代表作肖申克的救赎', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (8, '刘昊然', 'Liu Haoran', 1, '1997-10-10', '中国', '唐人街探案, 北京爱情故事, 最好的我们', '中国男演员，代表作唐人街探案', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (9, '沈腾', 'Shen Teng', 1, '1979-10-23', '中国', '西虹市首富, 夏洛特烦恼, 飞驰人生', '中国男演员，代表作西虹市首富', '2026-06-12 17:01:56');
INSERT INTO `actor` VALUES (10, '吴京', 'Wu Jing', 1, '1974-04-03', '中国', '战狼2, 流浪地球, 长津湖', '中国男演员，代表作战狼', '2026-06-12 17:01:56');

-- ----------------------------
-- Table structure for admin
-- ----------------------------
DROP TABLE IF EXISTS `admin`;
CREATE TABLE `admin`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '管理员 ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '管理员用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（MD5 加密）',
  `role` tinyint NULL DEFAULT 1 COMMENT '角色 1-普通管理员 2-超级管理员',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '管理员表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of admin
-- ----------------------------
INSERT INTO `admin` VALUES (1, 'admin', '0192023a7bbd73250516f069df18b500', 2, 1, '2026-06-12 17:01:56');
INSERT INTO `admin` VALUES (2, 'admin1', 'e10adc3949ba59abbe56e057f20f883e', 2, 1, '2026-06-15 13:22:45');

-- ----------------------------
-- Table structure for announcement
-- ----------------------------
DROP TABLE IF EXISTS `announcement`;
CREATE TABLE `announcement`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '公告 ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告内容',
  `publish_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '发布时间',
  `author_id` int NULL DEFAULT NULL COMMENT '发布管理员 ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_author_id`(`author_id` ASC) USING BTREE,
  CONSTRAINT `announcement_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `admin` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '公告表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of announcement
-- ----------------------------
INSERT INTO `announcement` VALUES (1, '欢迎来到 Movie-Muse！', '感谢您使用 Movie-Muse 电影平台！我们致力于为您提供最优质的观影体验。', '2026-06-11 15:26:55', 1);
INSERT INTO `announcement` VALUES (2, 'VIP 会员说明', '累计在线观影达到 100 小时即可自动升级为 VIP 会员，享受更多特权！', '2026-06-11 15:26:55', 1);
INSERT INTO `announcement` VALUES (3, '限时免费活动', '本月精选 5 部高分电影限时免费观看，快来体验吧！', '2026-06-12 10:00:00', 1);
INSERT INTO `announcement` VALUES (4, '修复一些问题和BUG', '修复了网站更新时存在的一些问题与BUG', '2026-07-08 09:17:56', 1);

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '分类 ID',
  `name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名称',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '分类描述',
  `sort_order` int NULL DEFAULT 0 COMMENT '排序',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `name`(`name` ASC) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '分类表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES (1, '科幻', 'fa-rocket', '探索未来世界', 1, 1);
INSERT INTO `category` VALUES (2, '动作', 'fa-explosion', '惊险刺激', 2, 1);
INSERT INTO `category` VALUES (3, '爱情', 'fa-heart', '浪漫爱情', 3, 1);
INSERT INTO `category` VALUES (4, '喜剧', 'fa-laugh', '轻松幽默', 4, 1);
INSERT INTO `category` VALUES (5, '悬疑', 'fa-search', '扣人心弦', 5, 1);
INSERT INTO `category` VALUES (6, '恐怖', 'fa-ghost', '紧张刺激', 6, 1);
INSERT INTO `category` VALUES (7, '动画', 'fa-film', '精美画面', 7, 1);
INSERT INTO `category` VALUES (8, '剧情', 'fa-theater-masks', '深刻情感', 8, 1);
INSERT INTO `category` VALUES (9, '奇幻', 'fas fa-rocket', '奇幻的世界冒险', 9, 1);

-- ----------------------------
-- Table structure for comment
-- ----------------------------
DROP TABLE IF EXISTS `comment`;
CREATE TABLE `comment`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '评论 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `movie_id` int NOT NULL COMMENT '电影 ID',
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '评论时间',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-删除 1-正常',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_movie_id`(`movie_id` ASC) USING BTREE,
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '评论表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of comment
-- ----------------------------
INSERT INTO `comment` VALUES (1, 1, 1, '太震撼了！诺兰的电影永远让人回味无穷，父女之间的情感太动人了。', '2026-05-01 10:00:00', 1);
INSERT INTO `comment` VALUES (2, 1, 3, '肖申克的救赎，人生必看系列，自由与希望的主题永恒。', '2026-05-02 14:30:00', 1);
INSERT INTO `comment` VALUES (3, 2, 2, '杰克和露丝的爱情故事让我每次看都流泪，经典中的经典。', '2026-05-03 09:00:00', 1);
INSERT INTO `comment` VALUES (4, 2, 9, '千与千寻是宫崎骏最好的作品，每次看都有新的感受。', '2026-05-04 16:00:00', 1);
INSERT INTO `comment` VALUES (5, 3, 4, '盗梦空间的梦境设定太精妙了，多层梦境的构思令人叹为观止。', '2026-05-05 20:00:00', 1);
INSERT INTO `comment` VALUES (6, 3, 13, '楚门的世界，我们是否也活在别人的剧本里？深刻的哲学思考。', '2026-05-06 11:00:00', 1);
INSERT INTO `comment` VALUES (7, 4, 7, '复仇者联盟终局之战，十年漫威的完美收官！钢铁侠牺牲的那一刻哭了。', '2026-05-07 15:00:00', 1);
INSERT INTO `comment` VALUES (8, 4, 8, '中国科幻电影的里程碑！流浪地球让世界看到了中国的想象力。', '2026-05-08 08:00:00', 1);
INSERT INTO `comment` VALUES (9, 5, 10, '唐人街探案太搞笑了，刘昊然和王宝强的组合绝了！', '2026-05-09 19:00:00', 1);
INSERT INTO `comment` VALUES (10, 5, 11, '战狼2看得热血沸腾，吴京的打戏真的很精彩。', '2026-05-10 22:00:00', 1);
INSERT INTO `comment` VALUES (11, 7, 9, '最好的动漫', '2026-07-07 14:25:43', 1);
INSERT INTO `comment` VALUES (12, 7, 16, '齐天大圣！！', '2026-07-08 10:23:28', 1);

-- ----------------------------
-- Table structure for favorite
-- ----------------------------
DROP TABLE IF EXISTS `favorite`;
CREATE TABLE `favorite`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '收藏 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `movie_id` int NOT NULL COMMENT '电影 ID',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '收藏时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_user_movie`(`user_id` ASC, `movie_id` ASC) USING BTREE,
  INDEX `movie_id`(`movie_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  CONSTRAINT `favorite_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `favorite_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 16 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '收藏表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of favorite
-- ----------------------------
INSERT INTO `favorite` VALUES (1, 1, 1, '2026-06-10 10:05:00');
INSERT INTO `favorite` VALUES (2, 1, 3, '2026-06-10 14:35:00');
INSERT INTO `favorite` VALUES (3, 1, 4, '2026-06-11 09:10:00');
INSERT INTO `favorite` VALUES (4, 2, 2, '2026-06-11 09:05:00');
INSERT INTO `favorite` VALUES (5, 2, 9, '2026-06-11 16:05:00');
INSERT INTO `favorite` VALUES (6, 3, 13, '2026-06-12 11:05:00');
INSERT INTO `favorite` VALUES (7, 3, 4, '2026-06-12 20:05:00');
INSERT INTO `favorite` VALUES (8, 3, 7, '2026-06-12 15:10:00');
INSERT INTO `favorite` VALUES (9, 4, 8, '2026-06-12 08:05:00');
INSERT INTO `favorite` VALUES (10, 4, 11, '2026-06-12 22:05:00');
INSERT INTO `favorite` VALUES (11, 5, 10, '2026-06-12 19:05:00');
INSERT INTO `favorite` VALUES (12, 5, 12, '2026-06-12 20:00:00');
INSERT INTO `favorite` VALUES (14, 7, 9, '2026-07-07 14:26:34');
INSERT INTO `favorite` VALUES (15, 7, 16, '2026-07-08 10:23:33');

-- ----------------------------
-- Table structure for movie
-- ----------------------------
DROP TABLE IF EXISTS `movie`;
CREATE TABLE `movie`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '电影 ID',
  `title` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '电影标题',
  `poster` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '海报 URL',
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '剧情简介',
  `director` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '导演',
  `release_year` int NULL DEFAULT NULL COMMENT '上映年份',
  `runtime` int NULL DEFAULT NULL COMMENT '片长（分钟）',
  `rating` decimal(3, 1) NULL DEFAULT 0.0 COMMENT '评分',
  `view_count` int NULL DEFAULT 0 COMMENT '播放次数',
  `video_url` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '视频 URL 或嵌入代码',
  `is_free` tinyint NULL DEFAULT 0 COMMENT '是否免费 0-否 1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-下架 1-上架',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_title`(`title` ASC) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '电影表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie
-- ----------------------------
INSERT INTO `movie` VALUES (1, '星际穿越', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '在不远的未来，地球环境恶化，农作物相继灭绝，人类面临生存危机。前宇航员库珀在女儿墨菲的书房中发现了奇怪的重力异常，从而发现了一个通往未知宇宙的虫洞。为了拯救人类，库珀告别女儿，与布兰德教授、艾米莉亚·布兰德等队员一起穿越虫洞，前往遥远的星系寻找适合人类居住的新家园。在探索过程中，他们经历了时间膨胀、黑洞引力等一系列挑战，库珀更是为了队友牺牲自己，最终通过五维空间向女儿传递了关键信息，帮助人类找到了新家园。', '克里斯托弗·诺兰', 2014, 169, 9.4, 50004, '//player.bilibili.com/player.html?isOutside=true&aid=114290942017570&bvid=BV1tdRqYaEtW&cid=29267070098&p=1', 1, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (2, '泰坦尼克号', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '穷画家杰克和贵族女露丝在泰坦尼克号上相遇并相爱。然而，这艘被誉为\"永不沉没\"的豪华邮轮在处女航中撞上冰山，两人必须在灾难面前做出艰难的选择。', '詹姆斯·卡梅隆', 1997, 194, 9.5, 80004, '//player.bilibili.com/player.html?isOutside=true&aid=114449939697914&bvid=BV16CVAzoEWW&cid=29790506200&p=1', 1, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (3, '肖申克的救赎', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '银行家安迪因被误判为杀妻而入狱，在肖申克监狱中，他与老囚犯瑞德成为好友。安迪用二十年的时间，通过自己的知识和毅力，不仅帮助狱友获得教育，还揭露了监狱长的腐败行为，最终成功越狱并重获自由。', '弗兰克·德拉邦特', 1994, 142, 9.7, 120005, '//player.bilibili.com/player.html?isOutside=true&aid=15527484&bvid=BV1Lx411M7f7&cid=25269260&p=1', 1, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (4, '盗梦空间', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '多姆·柯布是一名能进入他人梦境窃取商业机密的特工。为了回家与孩子团聚，他接受了一项特殊任务：不是窃取想法，而是在目标人物的潜意识中植入一个想法。然而，这次任务充满了危险和不确定性。', '克里斯托弗·诺兰', 2010, 148, 9.3, 60002, '//player.bilibili.com/player.html?isOutside=true&aid=114900609274834&bvid=BV1xobZzhEdk&cid=31291804012&p=1', 1, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (5, '阿凡达', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '在遥远的潘多拉星球，残疾士兵杰克通过阿凡达化身融入了纳美人的世界。', '詹姆斯·卡梅隆', 2009, 162, 8.8, 90002, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (6, '哈利·波特与魔法石', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '孤儿哈利·波特发现自己是一名巫师，并进入霍格沃茨魔法学校学习。', '克里斯·哥伦布', 2001, 152, 9.1, 70001, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (7, '复仇者联盟4：终局之战', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '在灭霸消灭宇宙一半的生命后，复仇者联盟必须团结起来逆转灭霸的行动。', '安东尼·罗素', 2019, 181, 8.5, 100003, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (8, '流浪地球', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '太阳即将毁灭，人类启动流浪地球计划，推动地球离开太阳系寻找新家园。', '郭帆', 2019, 125, 8.9, 55000, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (9, '千与千寻', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '10岁的小女孩千寻与父母搬家途中误入神灵世界，父母因贪吃变成猪。千寻在神秘少年白龙的帮助下，进入汤屋工作，经历各种奇幻冒险，最终救出父母并回到人类世界。', '宫崎骏', 2001, 125, 9.4, 85009, '//player.bilibili.com/player.html?isOutside=true&aid=714288765&bvid=BV1TX4y1L7An&cid=302952333&p=1', 1, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (10, '唐人街探案', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '天赋异禀的少年秦风警校考场失利，被远房表舅唐仁强行拉去泰国破案。', '陈思诚', 2015, 135, 7.7, 45004, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (11, '战狼2', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '退役特种兵冷锋在非洲卷入一场叛乱，为了保护同胞和当地人民展开殊死战斗。', '吴京', 2017, 123, 7.1, 65001, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (12, '西虹市首富', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '困顿的守门员王多鱼意外获得10亿元遗产继承权，但必须在一个月内花光。', '闫非', 2018, 118, 6.6, 40000, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (13, '楚门的世界', 'https://img3.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '楚门发现自己生活了三十多年的世界竟然是一个巨大的摄影棚。', '彼得·威尔', 1998, 103, 9.4, 75002, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (14, '疯狂动物城', 'https://img1.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '在一个所有动物和平共处的城市里，兔警官朱迪和狐狸尼克一起破获失踪案。', '拜伦·霍华德', 2016, 108, 9.2, 70004, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (15, '寄生虫', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '基宇一家四口全是无业游民，通过伪造身份进入朴社长家工作，引发一系列故事。', '奉俊昊', 2019, 132, 8.8, 50000, NULL, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `movie` VALUES (16, '西游记之大圣归来', 'https://img2.doubanio.com/view/photo/s_ratio_poster/public/p2614949805.webp', '《西游记之大圣归来》（2015）是田晓鹏执导的3D动画电影。故事讲述五百年前大闹天宫的孙悟空被小和尚江流儿误打误撞解开封印，被迫护送其回长安。途中历经磨难，孙悟空在江流儿的感染下找回初心，最终战胜妖王，完成自我救赎。影片被誉为国产动画里程碑之作。', '田晓鹏', 2005, NULL, 9.8, 9, '//player.bilibili.com/player.html?isOutside=true&aid=114736712654706&bvid=BV1rGKuzoEKR&cid=30668556909&p=1', 1, 1, '2026-07-08 10:22:07');

-- ----------------------------
-- Table structure for movie_actor
-- ----------------------------
DROP TABLE IF EXISTS `movie_actor`;
CREATE TABLE `movie_actor`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联 ID',
  `movie_id` int NOT NULL COMMENT '电影 ID',
  `actor_id` int NOT NULL COMMENT '演员 ID',
  `role_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '饰演角色',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_movie_actor`(`movie_id` ASC, `actor_id` ASC) USING BTREE,
  INDEX `actor_id`(`actor_id` ASC) USING BTREE,
  CONSTRAINT `movie_actor_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movie_actor_ibfk_2` FOREIGN KEY (`actor_id`) REFERENCES `actor` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '电影演员关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_actor
-- ----------------------------
INSERT INTO `movie_actor` VALUES (1, 1, 1, '库珀');
INSERT INTO `movie_actor` VALUES (2, 1, 2, '布兰德博士');
INSERT INTO `movie_actor` VALUES (3, 2, 3, '杰克');
INSERT INTO `movie_actor` VALUES (4, 2, 4, '露丝');
INSERT INTO `movie_actor` VALUES (5, 3, 6, '安迪');
INSERT INTO `movie_actor` VALUES (6, 3, 7, '瑞德');
INSERT INTO `movie_actor` VALUES (7, 4, 3, '道姆·柯布');
INSERT INTO `movie_actor` VALUES (8, 7, 5, '托尼·斯塔克');
INSERT INTO `movie_actor` VALUES (9, 10, 8, '秦风');
INSERT INTO `movie_actor` VALUES (10, 10, 9, '唐仁');
INSERT INTO `movie_actor` VALUES (11, 11, 10, '冷锋');
INSERT INTO `movie_actor` VALUES (12, 12, 9, '王多鱼');

-- ----------------------------
-- Table structure for movie_category
-- ----------------------------
DROP TABLE IF EXISTS `movie_category`;
CREATE TABLE `movie_category`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '关联 ID',
  `movie_id` int NOT NULL COMMENT '电影 ID',
  `category_id` int NOT NULL COMMENT '分类 ID',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `uk_movie_category`(`movie_id` ASC, `category_id` ASC) USING BTREE,
  INDEX `category_id`(`category_id` ASC) USING BTREE,
  CONSTRAINT `movie_category_ibfk_1` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `movie_category_ibfk_2` FOREIGN KEY (`category_id`) REFERENCES `category` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 29 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '电影分类关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of movie_category
-- ----------------------------
INSERT INTO `movie_category` VALUES (1, 1, 1);
INSERT INTO `movie_category` VALUES (2, 1, 8);
INSERT INTO `movie_category` VALUES (3, 2, 3);
INSERT INTO `movie_category` VALUES (4, 2, 8);
INSERT INTO `movie_category` VALUES (5, 3, 8);
INSERT INTO `movie_category` VALUES (6, 4, 1);
INSERT INTO `movie_category` VALUES (7, 4, 5);
INSERT INTO `movie_category` VALUES (8, 5, 1);
INSERT INTO `movie_category` VALUES (9, 5, 2);
INSERT INTO `movie_category` VALUES (11, 6, 1);
INSERT INTO `movie_category` VALUES (10, 6, 7);
INSERT INTO `movie_category` VALUES (13, 7, 1);
INSERT INTO `movie_category` VALUES (12, 7, 2);
INSERT INTO `movie_category` VALUES (14, 8, 1);
INSERT INTO `movie_category` VALUES (15, 8, 2);
INSERT INTO `movie_category` VALUES (16, 9, 7);
INSERT INTO `movie_category` VALUES (18, 10, 4);
INSERT INTO `movie_category` VALUES (17, 10, 5);
INSERT INTO `movie_category` VALUES (19, 11, 2);
INSERT INTO `movie_category` VALUES (20, 11, 8);
INSERT INTO `movie_category` VALUES (21, 12, 4);
INSERT INTO `movie_category` VALUES (22, 13, 5);
INSERT INTO `movie_category` VALUES (23, 13, 8);
INSERT INTO `movie_category` VALUES (25, 14, 4);
INSERT INTO `movie_category` VALUES (24, 14, 7);
INSERT INTO `movie_category` VALUES (27, 15, 5);
INSERT INTO `movie_category` VALUES (26, 15, 8);
INSERT INTO `movie_category` VALUES (28, 16, 9);

-- ----------------------------
-- Table structure for search_history
-- ----------------------------
DROP TABLE IF EXISTS `search_history`;
CREATE TABLE `search_history`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '搜索历史 ID',
  `user_id` int NULL DEFAULT NULL COMMENT '用户 ID（未登录可为 NULL）',
  `keyword` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '搜索关键词',
  `search_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '搜索时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_keyword`(`keyword` ASC) USING BTREE,
  CONSTRAINT `search_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE SET NULL ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '搜索历史表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of search_history
-- ----------------------------
INSERT INTO `search_history` VALUES (1, 1, '诺兰', '2026-06-10 09:50:00');
INSERT INTO `search_history` VALUES (2, 1, '科幻电影', '2026-06-10 10:30:00');
INSERT INTO `search_history` VALUES (3, 1, '星际穿越', '2026-06-11 08:30:00');
INSERT INTO `search_history` VALUES (4, 2, '爱情电影', '2026-06-09 19:00:00');
INSERT INTO `search_history` VALUES (5, 2, '宫崎骏', '2026-06-10 14:00:00');
INSERT INTO `search_history` VALUES (6, 3, '悬疑', '2026-06-08 21:00:00');
INSERT INTO `search_history` VALUES (7, 3, '楚门的世界', '2026-06-09 09:00:00');
INSERT INTO `search_history` VALUES (8, 4, '中国科幻', '2026-06-10 07:30:00');
INSERT INTO `search_history` VALUES (9, 4, '吴京', '2026-06-11 15:00:00');
INSERT INTO `search_history` VALUES (10, 5, '喜剧', '2026-06-09 11:00:00');
INSERT INTO `search_history` VALUES (11, 5, '唐人街探案', '2026-06-10 18:00:00');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '用户 ID',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码（MD5 加密）',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '邮箱',
  `avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像 URL',
  `gender` tinyint NULL DEFAULT 0 COMMENT '性别 0-未知 1-男 2-女',
  `is_vip` tinyint NULL DEFAULT 0 COMMENT '是否 VIP 0-否 1-是',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-正常',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '注册时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username` ASC) USING BTREE,
  INDEX `idx_username`(`username` ASC) USING BTREE,
  INDEX `idx_email`(`email` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 8 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, 'zhangsan', 'e10adc3949ba59abbe56e057f20f883e', 'zhangsan@example.com', NULL, 1, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `user` VALUES (2, 'lisi', 'e10adc3949ba59abbe56e057f20f883e', 'lisi@example.com', NULL, 2, 1, 1, '2026-06-12 17:01:56');
INSERT INTO `user` VALUES (3, 'wangwu', 'e10adc3949ba59abbe56e057f20f883e', 'wangwu@example.com', NULL, 1, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `user` VALUES (4, 'movie_fan', 'e10adc3949ba59abbe56e057f20f883e', 'moviefan@example.com', NULL, 0, 1, 1, '2026-06-12 17:01:56');
INSERT INTO `user` VALUES (5, 'test_user', 'e10adc3949ba59abbe56e057f20f883e', 'test@example.com', NULL, 1, 0, 1, '2026-06-12 17:01:56');
INSERT INTO `user` VALUES (7, 'xiaoming', 'e10adc3949ba59abbe56e057f20f883e', 'xiaoming@qq.com', NULL, 0, 0, 1, '2026-07-07 08:44:29');

-- ----------------------------
-- Table structure for view_history
-- ----------------------------
DROP TABLE IF EXISTS `view_history`;
CREATE TABLE `view_history`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '历史记录 ID',
  `user_id` int NOT NULL COMMENT '用户 ID',
  `movie_id` int NOT NULL COMMENT '电影 ID',
  `view_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '观看时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `movie_id`(`movie_id` ASC) USING BTREE,
  INDEX `idx_user_id`(`user_id` ASC) USING BTREE,
  INDEX `idx_view_time`(`view_time` ASC) USING BTREE,
  CONSTRAINT `view_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT,
  CONSTRAINT `view_history_ibfk_2` FOREIGN KEY (`movie_id`) REFERENCES `movie` (`id`) ON DELETE CASCADE ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '观看历史表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of view_history
-- ----------------------------
INSERT INTO `view_history` VALUES (1, 1, 1, '2026-06-10 10:00:00');
INSERT INTO `view_history` VALUES (2, 1, 3, '2026-06-10 14:00:00');
INSERT INTO `view_history` VALUES (3, 1, 4, '2026-06-11 09:00:00');
INSERT INTO `view_history` VALUES (4, 2, 2, '2026-06-15 15:11:33');
INSERT INTO `view_history` VALUES (5, 2, 9, '2026-06-10 15:00:00');
INSERT INTO `view_history` VALUES (6, 2, 14, '2026-06-15 15:11:25');
INSERT INTO `view_history` VALUES (7, 3, 13, '2026-06-08 22:00:00');
INSERT INTO `view_history` VALUES (8, 3, 7, '2026-06-09 10:00:00');
INSERT INTO `view_history` VALUES (9, 4, 8, '2026-06-10 08:00:00');
INSERT INTO `view_history` VALUES (10, 4, 11, '2026-06-11 16:00:00');
INSERT INTO `view_history` VALUES (11, 5, 10, '2026-06-09 12:00:00');
INSERT INTO `view_history` VALUES (12, 5, 12, '2026-06-10 19:00:00');
INSERT INTO `view_history` VALUES (13, 5, 1, '2026-06-11 21:00:00');
INSERT INTO `view_history` VALUES (14, 2, 10, '2026-06-15 08:56:50');
INSERT INTO `view_history` VALUES (15, 2, 1, '2026-06-15 14:49:19');
INSERT INTO `view_history` VALUES (16, 2, 13, '2026-06-15 14:49:34');
INSERT INTO `view_history` VALUES (17, 7, 3, '2026-07-07 10:06:51');
INSERT INTO `view_history` VALUES (18, 7, 5, '2026-07-07 10:07:32');
INSERT INTO `view_history` VALUES (19, 7, 9, '2026-07-07 14:26:33');
INSERT INTO `view_history` VALUES (20, 7, 2, '2026-07-07 10:41:15');
INSERT INTO `view_history` VALUES (21, 7, 14, '2026-07-07 10:41:26');
INSERT INTO `view_history` VALUES (22, 7, 1, '2026-07-07 10:20:34');
INSERT INTO `view_history` VALUES (23, 7, 4, '2026-07-07 10:53:24');
INSERT INTO `view_history` VALUES (24, 7, 7, '2026-07-07 14:33:10');
INSERT INTO `view_history` VALUES (25, 7, 11, '2026-07-07 10:20:56');
INSERT INTO `view_history` VALUES (26, 7, 6, '2026-07-07 10:28:19');
INSERT INTO `view_history` VALUES (27, 7, 13, '2026-07-07 10:41:35');
INSERT INTO `view_history` VALUES (28, 7, 10, '2026-07-07 14:33:29');
INSERT INTO `view_history` VALUES (29, 7, 16, '2026-07-08 15:39:19');

-- ----------------------------
-- Table structure for vip_config
-- ----------------------------
DROP TABLE IF EXISTS `vip_config`;
CREATE TABLE `vip_config`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT '配置 ID',
  `vip_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'VIP 等级名称',
  `required_hours` int NOT NULL DEFAULT 100 COMMENT '所需在线时长（小时）',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配置描述',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态 0-禁用 1-启用',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_status`(`status` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统配置表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of vip_config
-- ----------------------------
INSERT INTO `vip_config` VALUES (1, 'VIP 会员', 100, '在线时长达到 100 小时自动获取 VIP 资格', 1, '2026-06-12 17:01:56');

SET FOREIGN_KEY_CHECKS = 1;
