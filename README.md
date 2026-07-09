# Movie-Muse 项目文档

## 目录

1. [项目概述](#1-项目概述)
2. [技术栈](#2-技术栈)
3. [项目目录结构](#3-项目目录结构)
4. [数据库设计](#4-数据库设计)
5. [后端架构](#5-后端架构)
6. [前端结构](#6-前端结构)
7. [核心功能模块](#7-核心功能模块)
8. [URL 路由映射](#8-url-路由映射)
9. [部署与运行](#9-部署与运行)

---

## 1. 项目概述

Movie-Muse 是一个基于 **Servlet + JSP + MyBatis + MySQL** 的经典 Java Web 电影点播与管理平台。项目同时面向普通用户和管理员两角色，提供电影浏览、搜索、播放、评论、收藏、观看历史等用户端功能，以及电影、分类、用户、评论、公告等管理后台功能。

项目采用 Maven 构建，前后端未分离，JSP 页面通过 JSTL/EL 渲染后端数据，页面样式主要使用 Tailwind CSS 与 Font Awesome 实现。

---

## 2. 技术栈

| 层级 | 技术/工具 | 版本 |
|---|---|---|
| 后端框架 | Jakarta Servlet | 6.1.0 |
| 视图层 | JSP + JSTL | 4.0.0 / 3.0.1 |
| 持久层 | MyBatis | 3.5.19 |
| 数据库 | MySQL Connector/J | 9.5.0 |
| 构建工具 | Maven | — |
| JDK | Java | 24 |
| 工具库 | Gson / Lombok | 2.10.1 / 1.18.46 |
| 前端样式 | Tailwind CSS + Font Awesome | CDN |

---

## 3. 项目目录结构

```
Movie-Muse/
├── database/
│   └── movie.sql                 # 数据库初始化脚本（含表结构与示例数据）
├── src/
│   └── main/
│       ├── java/
│       │   └── org/example/
│       │       ├── dao/          # MyBatis Mapper 接口
│       │       ├── entity/       # 实体类（POJO）
│       │       ├── service/      # 业务逻辑层接口与实现
│       │       │   └── impl/
│       │       ├── servlet/      # Servlet 控制器
│       │       └── util/         # 工具类（MyBatis、MD5、JWT 等）
│       ├── resources/
│       │   ├── mapper/           # MyBatis XML 映射文件
│       │   └── mybatis-config.xml
│       └── web/
│           ├── admin/            # 管理后台 JSP/HTML 页面
│           ├── user/             # 用户端 JSP/HTML 页面
│           ├── images/           # 静态图片资源
│           ├── WEB-INF/
│           │   └── web.xml       # Web 应用配置
│           ├── index.html        # 欢迎页/静态首页
│           └── search.jsp        # 搜索结果页
├── pom.xml                       # Maven 依赖与构建配置
└── README.md                     # 项目说明（如存在）
```

---

## 4. 数据库设计

数据库名：`movie`，字符集 `utf8mb4`，存储引擎 `InnoDB`。整体采用关系型设计，通过外键维护数据一致性，部分关联表设置级联删除。

### 4.1 核心数据表

| 表名 | 说明 | 主要字段 |
|---|---|---|
| `user` | 普通用户表 | id, username, password, email, avatar, gender, is_vip, status, create_time |
| `admin` | 管理员表 | id, username, password, role, status, create_time |
| `movie` | 电影表 | id, title, poster, description, director, release_year, runtime, rating, view_count, video_url, is_free, status, create_time |
| `category` | 电影分类表 | id, name, icon, description, sort_order, status |
| `comment` | 评论表 | id, user_id, movie_id, content, create_time, status |
| `favorite` | 收藏表 | id, user_id, movie_id, create_time |
| `view_history` | 观看历史表 | id, user_id, movie_id, view_time |
| `search_history` | 搜索历史表 | id, user_id, keyword, search_time |
| `announcement` | 公告表 | id, title, content, publish_time, author_id |
| `actor` | 演员表 | id, name, name_en, gender, birth_date, nationality, filmography, description, create_time |
| `movie_actor` | 电影演员关联表 | id, movie_id, actor_id, role_name |
| `movie_category` | 电影分类关联表 | id, movie_id, category_id |
| `vip_config` | VIP 配置表 | id, vip_name, required_hours, description, status, create_time |

### 4.2 关联关系

- 一个用户可发布多条评论、收藏多部电影、拥有多条观看/搜索历史。
- 一部电影可属于多个分类（`movie_category`），可有多个演员（`movie_actor`）。
- 评论同时关联 `user` 与 `movie`，删除用户或电影会级联删除相关评论、收藏、历史记录。
- 公告关联发布管理员（`author_id`），管理员删除时设置为 NULL。

### 4.3 关键状态字段约定

| 表 | 字段 | 1 的含义 | 0 的含义 |
|---|---|---|---|
| user | status | 正常 | 禁用/封禁 |
| admin | status | 正常 | 禁用 |
| movie | status | 上架 | 下架 |
| movie | is_free | 免费 | 付费 |
| category | status | 启用 | 禁用 |
| comment | status | 正常 | 删除/禁用 |

---

## 5. 后端架构

项目采用经典三层架构：实体层（Entity）、数据访问层（DAO/Mapper）、业务逻辑层（Service）、控制层（Servlet）。

### 5.1 实体层（entity）

位于 `src/main/java/org/example/entity`，使用 Lombok 简化 Getter/Setter，部分实体包含关联对象。

| 类名 | 说明 | 主要字段 |
|---|---|---|
| `User` | 普通用户 | id, username, password, email, avatar, gender, isVip, status, createTime |
| `Admin` | 管理员 | id, username, password, role, status, createTime |
| `Movie` | 电影 | id, title, poster, description, director, releaseYear, runtime, rating, viewCount, videoUrl, isFree, status, createTime |
| `Category` | 分类 | id, name, icon, description, sortOrder, status |
| `Comment` | 评论 | id, userId, movieId, content, createTime, status；关联 `User`、`Movie` |
| `Favorite` | 收藏 | id, userId, movieId, createTime；关联 `User`、`Movie` |
| `ViewHistory` | 观看历史 | id, userId, movieId, viewTime；关联 `User`、`Movie` |
| `SearchHistory` | 搜索历史 | id, userId, keyword, searchTime；关联 `User` |
| `Announcement` | 公告 | id, title, content, publishTime, authorId；关联 `Admin` |
| `Actor` | 演员 | id, name, gender, description 等 |
| `MovieActor` | 电影演员关联 | id, movieId, actorId, roleName；关联 `Actor` |
| `MovieCategory` | 电影分类关联 | id, movieId, categoryId；关联 `Category` |
| `SystemConfig` | 系统配置 | id, configKey, configValue, description |

### 5.2 数据访问层（dao / mapper）

Mapper 接口位于 `src/main/java/org/example/dao`，对应 XML 位于 `src/main/resources/mapper`。

| Mapper | 核心方法 |
|---|---|
| `UserMapper` | 按 ID/用户名/邮箱查询、插入、更新、删除、查询全部、模糊搜索、统计总数 |
| `AdminMapper` | 按 ID/用户名查询、插入、更新、删除 |
| `MovieMapper` | 按 ID/标题查询、分页查询、分类查询、多字段模糊搜索、统计、增删改、分类关联维护、播放量递增、高分/免费/热门查询 |
| `CategoryMapper` | 按 ID/名称查询、全部查询（含后台全量版本）、增删改 |
| `CommentMapper` | 按 ID/电影 ID/用户 ID 查询、后台全量查询、插入、删除、统计评论数 |
| `FavoriteMapper` | 按 ID/用户 ID/用户+电影查询、插入、删除、统计、按电影分组统计 |
| `ViewHistoryMapper` | 按用户 ID 查询、插入、删除、清空、按用户+电影查询、更新观看时间 |
| `SearchHistoryMapper` | 按用户 ID 查询、插入、删除、清空 |
| `AnnouncementMapper` | 按 ID 查询、查询全部、插入、删除 |

### 5.3 业务逻辑层（service）

Service 接口位于 `src/main/java/org/example/service`，实现类位于 `src/main/java/org/example/service/impl`。每个 Service 通过 `MyBatisUtil` 获取 `SqlSession`，调用对应 Mapper 完成事务并关闭会话。

| Service | 职责 |
|---|---|
| `UserService` | 用户注册、登录、查询、更新、删除、封禁状态修改、密码修改、统计 |
| `AdminService` | 管理员登录、查询 |
| `MovieService` | 电影 CRUD、分页查询、分类查询、搜索、分类关联维护、播放量统计 |
| `CategoryService` | 分类 CRUD、全量查询 |
| `CommentService` | 评论查询、新增、删除、按电影清空、统计 |
| `FavoriteService` | 收藏查询、新增、取消、统计 |
| `ViewHistoryService` | 观看历史查询、新增、删除、清空 |
| `SearchHistoryService` | 搜索历史查询、新增、删除、清空 |
| `AnnouncementService` | 公告查询、新增、删除 |

### 5.4 控制层（servlet）

Servlet 使用 `@WebServlet` 注解配置 URL 映射，部分核心 Servlet 在 `web.xml` 中做了额外声明。所有 Servlet 均通过调用 Service 处理业务，JSP 负责视图渲染，JSON 接口使用 Gson 输出。

控制层大致分为四类：

1. **用户认证**：`LoginServlet`、`RegisterServlet`、`LogoutServlet`、`CheckAuthServlet`
2. **用户端业务**：首页、电影列表、详情、搜索、收藏、评论、历史、个人中心等
3. **管理后台**：`Admin*Servlet` 系列，覆盖电影、分类、用户、评论、公告管理
4. **JSON/API 接口**：电影详情、评论、收藏等 AJAX 接口

### 5.5 工具类（util）

| 类名 | 说明 |
|---|---|
| `MyBatisUtil` | 封装 SqlSessionFactory、SqlSession 的获取与关闭 |
| `MD5Util` | 密码 MD5 加密 |
| `JWTUtil` | JWT 生成与校验（如项目使用） |

---

## 6. 前端结构

### 6.1 管理后台页面（web/admin）

| 页面 | 用途 |
|---|---|
| `admin-login.jsp` | 管理员登录 |
| `admin-login-success.jsp` | 登录成功提示 |
| `admin-dashboard.jsp` | 控制台首页（统计卡片） |
| `admin-movies.jsp` | 电影列表（ID 排序） |
| `admin-movie-edit.jsp` | 电影新增/编辑（含分类选择） |
| `admin-categories.jsp` | 分类列表 |
| `admin-category-edit.jsp` | 分类新增/编辑 |
| `admin-users.jsp` | 用户列表（封禁/删除） |
| `admin-comments.jsp` | 评论管理（按电影分组） |
| `admin-announcement-list.jsp` | 公告列表 |
| `admin-announcement-edit.jsp` | 公告发布/编辑 |
| `*.html` | 早期静态原型页面，供样式参考 |

管理后台统一采用左侧固定侧边栏 + 顶部用户信息 + 白色内容卡片的布局，侧边栏固定为 6 个功能入口：控制台、电影管理、分类管理、用户管理、评论管理、公告管理。

### 6.2 用户端页面（web/user）

| 页面 | 用途 |
|---|---|
| `login.jsp` | 用户登录 |
| `register.jsp` | 用户注册 |
| `login-success.jsp` | 登录成功 |
| `index.jsp` | 首页（最新、热门、分类、公告弹窗） |
| `movie-list.jsp` | 全部电影列表 |
| `movie-detail.jsp` | 电影详情、播放、评论 |
| `category-movies.jsp` | 分类下电影列表 |
| `free-zone.jsp` | 免费电影专区 |
| `profile.jsp` | 个人中心（收藏、评论、历史、改密码） |
| `*.html` | 早期静态原型页面 |

### 6.3 其他页面

| 页面 | 用途 |
|---|---|
| `web/index.html` | 项目欢迎页/静态首页 |
| `web/search.jsp` | 搜索结果页（关键词、分类筛选、分页） |

---

## 7. 核心功能模块

### 7.1 用户系统

- 普通用户注册、登录、退出。
- 登录成功后写入 `HttpSession`：`currentUser`、`userId`、`username`、`isAdmin=false`。
- 密码使用 MD5 加密存储。
- 已登录用户可修改密码、查看个人中心。
- 管理员封禁用户后（`status=0`），用户再次登录会被拒绝。

### 7.2 电影浏览与播放

- 首页展示最新电影、热门电影、分类入口和系统公告弹窗。
- 电影列表页支持分页，默认按评分/创建时间排序。
- 电影详情页展示海报、简介、评分、导演、年份、评论列表，并提供 iframe 视频播放。
- 支持视频 URL 与 B 站 iframe 嵌入代码，后台保存时会自动提取 `src`。
- 电影有 `is_free` 标记，免费电影进入“免费专区”。

### 7.3 分类系统

- 分类由后台管理维护，一部电影可关联多个分类。
- 用户可浏览分类列表，点击分类查看该分类下的电影。
- 后台添加/编辑电影时可通过复选框选择所属分类。

### 7.4 评论系统

- 用户登录后可在电影详情页发表评论。
- 用户可删除自己的评论。
- 管理员可在后台按电影分组查看所有评论，支持删除单条评论或清空某电影全部评论。

### 7.5 收藏与观看历史

- 用户可收藏/取消收藏电影，收藏列表在个人中心展示。
- 用户观看电影后记录观看历史，支持查看、删除、清空。
- 搜索历史同样记录并支持管理。

### 7.6 公告系统

- 管理员发布公告，用户首页以弹窗形式展示。
- 公告表关联发布管理员。

### 7.7 管理后台

| 模块 | 功能 |
|---|---|
| 控制台 | 展示用户数、电影数、评论数、今日新增等统计 |
| 电影管理 | 电影的增删改查、分类绑定、免费/状态控制 |
| 分类管理 | 分类的增删改查、排序、启用/禁用 |
| 用户管理 | 用户列表、封禁/解封、删除 |
| 评论管理 | 按电影分组查看、删除单条、清空电影评论 |
| 公告管理 | 发布公告、查看列表 |

---

## 8. URL 路由映射

### 8.1 用户认证

| URL | Servlet | 说明 |
|---|---|---|
| `/api/login` | `LoginServlet` | 用户登录（表单/AJAX） |
| `/api/register` | `RegisterServlet` | 用户注册 |
| `/api/logout` | `LogoutServlet` | 用户退出 |
| `/api/check-auth` | `CheckAuthServlet` | 检查登录状态 |
| `/user/login` | `LoginPageServlet` | 登录页 |
| `/user/register` | `RegisterPageServlet` | 注册页 |

### 8.2 用户端功能

| URL | Servlet | 说明 |
|---|---|---|
| `/index` | `IndexServlet` | 重定向到 `index.html` |
| `/user/index` | `UserIndexServlet` | 用户首页 |
| `/user/movie-list` | `MovieListServlet` | 电影列表 |
| `/user/movie-detail` | `MovieDetailJspServlet` | 电影详情 JSP |
| `/api/movie-detail` | `MovieDetailServlet` | 电影详情 JSON |
| `/user/free-zone` | `FreeMoviesServlet` | 免费专区 |
| `/user/categories` | `CategoryListServlet` | 分类列表 |
| `/user/category-movies` | `CategoryMoviesServlet` | 分类电影 |
| `/search` | `SearchServlet` | 搜索 |
| `/user/search-history` | `SearchHistoryServlet` | 搜索历史 |
| `/user/view-history` | `ViewHistoryServlet` | 观看历史 |
| `/user/favorite` | `FavoriteListServlet` | 收藏列表 |
| `/api/favorite` | `FavoriteServlet` | 收藏操作 JSON |
| `/api/comments` | `CommentListServlet` | 评论列表 JSON |
| `/api/comment/add` | `AddCommentServlet` | 发表评论 |
| `/user/comment/delete` | `DeleteCommentServlet` | 删除自己的评论 |
| `/user/profile` | `ProfileServlet` | 个人中心 |
| `/user/change-password` | `ChangePasswordServlet` | 修改密码 |

### 8.3 管理后台

| URL | Servlet | 说明 |
|---|---|---|
| `/admin/login` | `AdminLoginServlet` | 管理员登录页/登录 |
| `/admin/logout` | `AdminLogoutServlet` | 管理员退出 |
| `/admin/dashboard` | `AdminDashboardServlet` | 控制台 |
| `/admin/movies` | `AdminMovieListServlet` | 电影列表 |
| `/admin/movie-edit` | `AdminMovieEditServlet` | 电影新增/编辑 |
| `/admin/movie-delete` | `AdminMovieDeleteServlet` | 删除电影 |
| `/admin/categories` | `AdminCategoryListServlet` | 分类列表 |
| `/admin/category-edit` | `AdminCategoryEditServlet` | 分类新增/编辑 |
| `/admin/category-delete` | `AdminCategoryDeleteServlet` | 删除分类 |
| `/admin/users` | `AdminUserListServlet` | 用户列表 |
| `/admin/user-ban` | `AdminUserBanServlet` | 封禁/解封用户 |
| `/admin/user-delete` | `AdminUserDeleteServlet` | 删除用户 |
| `/admin/comments` | `AdminCommentListServlet` | 评论列表 |
| `/admin/comment-delete` | `AdminCommentDeleteServlet` | 删除单条评论 |
| `/admin/comment-clear` | `AdminCommentClearServlet` | 清空电影评论 |
| `/admin/announcements` | `AdminAnnouncementListServlet` | 公告列表 |
| `/admin/announcement-edit` | `AdminAnnouncementEditServlet` | 公告发布/编辑 |

---

## 9. 部署与运行

### 9.1 环境要求

- JDK 24
- Maven 3.6+
- MySQL 8.0+
- Tomcat 10+（支持 Jakarta EE）

### 9.2 数据库初始化

1. 创建数据库 `movie`：

```sql
CREATE DATABASE movie CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci;
```

2. 导入 `database/movie.sql`：

```bash
mysql -u root -p movie < database/movie.sql
```

### 9.3 修改数据库配置

打开 `src/main/resources/mybatis-config.xml`，确认以下配置与实际环境一致：

```xml
<property name="driver" value="com.mysql.cj.jdbc.Driver"/>
<property name="url" value="jdbc:mysql://localhost:3306/movie?useSSL=false&amp;serverTimezone=Asia/Shanghai&amp;characterEncoding=UTF-8"/>
<property name="username" value="root"/>
<property name="password" value="060424"/>
```

### 9.4 编译与部署

在项目根目录执行：

```bash
mvn clean compile
```

将生成的 `target/Movie-Muse-1.0-SNAPSHOT` 目录或 WAR 包部署到 Tomcat 的 `webapps` 目录下。

### 9.5 访问地址

- 用户端：`http://localhost:8080/Movie-Muse/user/index`
- 管理后台：`http://localhost:8080/Movie-Muse/admin/login`

默认管理员账号：

- 用户名：`admin`
- 密码：`admin123`（MD5 存储后对应 `0192023a7bbd73250516f069df18b500`）

---

## 10. 补充说明

- 项目中存在部分早期静态 `.html` 原型页面，当前主要功能已迁移到 `.jsp` 动态页面。
- 管理后台所有页面均要求管理员登录，未登录访问会重定向到 `/admin/login`。
- 视频播放通过 iframe 嵌入实现，支持直接填写视频 URL 或粘贴 B 站等 iframe 嵌入代码，后台会自动提取 `src`。
- 用户端登录已加入封禁校验：被封禁用户（`status=0`）无法登录。
