# 游戏服务端后端开发 · 自学计划

> 面向大二软件工程专业学生，以寒假实习为目标，从 Java Web 基础到游戏服务端 Netty 架构的完整学习路线
>
> **总周期**：约 22 周 | **每日投入**：2-3 小时 | **目标岗位**：游戏服务端开发实习

---

## 一、写在最前面

你已经具备 Java、Web、MySQL 和 C 语言基础，这是非常好的起点。游戏服务端后端开发不需要美术功底，也不需要学习 Unity 或 C++，核心是把 **Java 后端技术、网络编程、并发编程和数据库** 练扎实。

**这份计划的核心原则：**

- **先深后广**：先把 Java 服务端技术栈做深，再考虑 Go 等第二语言
- **项目驱动**：每学完一个技术就用项目验证，不要只看视频
- **循序渐进**：从 Spring Boot 现代后端入手，再进入 Netty 和游戏服务端
- **面试导向**：每个技术都明确「学到什么程度能过面试」

---

## 二、整体学习路线图

| 阶段 | 周期 | 核心技术 | 目标产出 |
|------|------|----------|----------|
| **阶段一：现代后端基础** | 第 1-10 周 | Git、Spring Boot、MyBatis-Plus、MySQL、Redis、Linux | 一个完整的 Spring Boot + Redis 用户管理系统 |
| **阶段二：并发与网络** | 第 11-18 周 | Java 并发、JUC、Netty、网络协议 | Netty 聊天室 + 简易游戏服务端 Demo |
| **阶段三：游戏架构与求职** | 第 19-22 周 | 游戏服务端架构、项目完善、面试准备 | 可写在简历上的完整项目 + 面试八股 |

---

## 三、阶段一：现代后端基础（第 1-10 周）

这一阶段的目标是把你的 Java Web 能力升级到现代 Java 后端水准，同时补齐版本控制、缓存、Linux 部署等必备技能。所有学习内容都围绕一个核心项目：**用户中心系统**。

### 3.1 Git 版本控制 `P0`

**学习目标**：掌握日常开发所需的 Git 命令，能够把本地项目推送到远程仓库，并理解分支协作流程。

**学习周期**：1 周（每天 1-2 小时即可，建议与 Spring Boot 第 1 周并行）

**核心知识点：**

1. **基础命令**：`git init`、`git clone`、`git add`、`git commit`、`git push`、`git pull`
2. **分支管理**：`git branch`、`git checkout`、`git merge`、`git switch`、分支命名规范
3. **撤销与回退**：`git reset`、`git revert`、`git stash`、`.gitignore` 配置
4. **远程协作**：GitHub / Gitee 仓库创建、SSH 密钥配置、PR / Merge Request 流程
5. **冲突解决**：理解冲突产生原因，手动解决冲突的方法

**学习顺序：**

Day 1-2：本地仓库基本操作 → Day 3-4：分支与合并 → Day 5：远程仓库与推送 → Day 6-7：冲突解决与 .gitignore。

**实践任务：**

- 在 GitHub 上创建仓库，把现有的 Movie-Muse 项目推送上去
- 创建 `dev` 分支，修改代码后合并回 `main`
- 配置合理的 `.gitignore` 文件，忽略 `.idea/`、`target/`、日志文件等

**检验标准：**

- 能够不查资料完成：克隆、修改、提交、推送、拉取、分支合并
- 能解释 `git reset --hard` 和 `git revert` 的区别

**推荐资源：**

- 视频：B站「Git 教程」入门版（搜 Git 廖雪峰或尚硅谷）
- 文档：[Pro Git 中文文档](https://git-scm.com/book/zh/v2)
- 练习：[Learn Git Branching 交互式教程](https://learngitbranching.js.org/?locale=zh_CN)

---

### 3.2 Spring Boot `P0`

**学习目标**：掌握 Spring Boot 核心特性，能够独立开发 RESTful API，理解自动配置原理和分层架构。

**学习周期**：3 周

**核心知识点：**

1. **项目搭建**：Spring Initializr、Maven 依赖管理、项目结构
2. **注解与控制器**：`@RestController`、`@RequestMapping`、`@GetMapping`、`@PostMapping`、`@RequestBody`、`@PathVariable`、`@RequestParam`
3. **依赖注入**：`@Component`、`@Service`、`@Repository`、`@Autowired`、`@Resource`、作用域
4. **配置文件**：`application.properties` / `application.yml`、多环境配置、配置优先级
5. **数据访问**：Spring Boot 整合 MyBatis / MyBatis-Plus、数据源配置
6. **统一返回与异常**：统一响应体、全局异常处理 `@ControllerAdvice`、自定义异常
7. **拦截器与过滤器**：`HandlerInterceptor`、`Filter`、登录校验实现
8. **自动配置原理**：`@SpringBootApplication`、`@EnableAutoConfiguration`、Starter 机制（面试重点）

**学习顺序：**

Week 1：项目搭建 + 控制器 + 依赖注入 + 配置文件 → Week 2：整合 MyBatis-Plus + 统一返回与异常 → Week 3：拦截器/过滤器 + 自动配置原理。

**实践任务：**

- 用 Spring Boot 重写 Movie-Muse 的用户管理、电影管理接口
- 实现用户注册、登录、JWT/Session 会话管理
- 添加统一返回格式 `{"code": 0, "msg": "ok", "data": {}}`
- 添加全局异常处理，统一捕获参数校验异常和业务异常

**检验标准：**

- 能独立搭建 Spring Boot 项目并完成 CRUD
- 能解释 Spring Boot 自动配置原理
- 能手写拦截器实现登录校验

**推荐资源：**

- 视频：尚硅谷 Spring Boot 3 教程 / 黑马程序员 Spring Boot
- 文档：[Spring Boot 官方文档](https://spring.io/projects/spring-boot)、[Baeldung Spring Boot](https://www.baeldung.com/spring-boot)
- 书籍：《Spring Boot 实战》

---

### 3.3 MyBatis-Plus `P0`

**学习目标**：用 MyBatis-Plus 替代手写 SQL，掌握 CRUD、条件构造器、分页插件，提升开发效率。

**学习周期**：2 周（与 Spring Boot 第二、三周结合学习）

**核心知识点：**

1. **基础 CRUD**：`BaseMapper` 的 insert、deleteById、updateById、selectById、selectList
2. **条件构造器**：`QueryWrapper`、`UpdateWrapper`、`LambdaQueryWrapper`、`LambdaUpdateWrapper`
3. **分页插件**：`Page` 对象、分页配置、分页查询
4. **代码生成器**：MyBatis-Plus Generator 快速生成 Entity、Mapper、Service、Controller
5. **多表查询**：自定义 XML SQL、`@Select` 注解、关联查询
6. **逻辑删除**：`@TableLogic` 注解配置

**学习顺序：**

Week 1：BaseMapper CRUD + 条件构造器 → Week 2：分页插件 + 代码生成器 + 逻辑删除。

**实践任务：**

- 用 MyBatis-Plus 重写 Movie-Muse 的所有数据库操作
- 实现电影列表分页查询、按条件筛选
- 使用代码生成器生成用户、电影、评论模块的骨架代码

**检验标准：**

- 能不写 XML 完成 90% 的单表查询
- 能手写分页查询代码
- 能解释 MyBatis-Plus 和 MyBatis 的关系

**推荐资源：**

- 文档：[MyBatis-Plus 官方文档](https://baomidou.com/)
- 视频：B站「MyBatis-Plus 快速入门」

---

### 3.4 MySQL 进阶 `P0`

**学习目标**：从「会写 SQL」提升到「能设计表、会优化查询、理解事务和锁」，达到实习面试要求。

**学习周期**：3 周

**核心知识点：**

1. **索引**：B+树索引原理、聚簇索引/非聚簇索引、覆盖索引、最左前缀原则、索引失效场景
2. **执行计划**：`EXPLAIN` 各字段含义、`type`、`key`、`rows`、`Extra`
3. **事务**：ACID、事务隔离级别、脏读/不可重复读/幻读、MVCC 机制
4. **锁**：行锁、表锁、间隙锁、死锁排查
5. **SQL 优化**：慢查询日志、分页优化、批量插入、避免 SELECT *
6. **表设计**：三范式与反范式设计、字段类型选择、分库分表概念

**学习顺序：**

Week 1：索引原理与执行计划 → Week 2：事务与 MVCC → Week 3：锁、慢查询优化与表设计。

**实践任务：**

- 为 Movie-Muse 项目设计合理的索引，用 EXPLAIN 验证查询优化效果
- 模拟高并发下的事务问题，验证不同隔离级别的表现
- 开启慢查询日志，找出并优化慢 SQL

**检验标准：**

- 能手写一条 SQL 并用 EXPLAIN 分析是否走索引
- 能解释 MVCC 如何解决不可重复读
- 能说出 5 个以上索引失效场景

**推荐资源：**

- 视频：尚硅谷 MySQL 高级 / 黑马 MySQL 优化
- 书籍：《MySQL 技术内幕：InnoDB 存储引擎》
- 文档：[MySQL 官方文档](https://dev.mysql.com/doc/refman/8.0/en/)

---

### 3.5 Redis `P1`

**学习目标**：掌握 Redis 常见数据类型和应用场景，能够在项目中使用缓存，理解缓存穿透、击穿、雪崩问题。

**学习周期**：2 周

**核心知识点：**

1. **数据类型**：String、Hash、List、Set、Sorted Set、Bitmap、HyperLogLog
2. **常用命令**：`SET/GET`、`HSET/HGET`、`LPUSH/RPOP`、`SADD/SMEMBERS`、`ZADD/ZRANGE`
3. **持久化**：RDB 快照、AOF 日志、混合持久化
4. **Spring Boot 整合**：Spring Data Redis、RedisTemplate、StringRedisTemplate
5. **缓存问题**：缓存穿透、缓存击穿、缓存雪崩及解决方案
6. **应用场景**：Session 共享、排行榜、计数器、分布式锁（初步了解）

**学习顺序：**

Week 1：数据类型与命令 + 安装配置 → Week 2：Spring Boot 整合 + 缓存问题 + 应用场景实现。

**实践任务：**

- 在 Spring Boot 项目中引入 Redis 缓存电影详情、用户 Session
- 实现一个基于 Redis 的排行榜功能
- 实现简单的接口限流（如 1 分钟最多 10 次请求）

**检验标准：**

- 能手写 5 种数据类型的典型命令
- 能解释缓存穿透、击穿、雪崩的区别和解决方案
- 能在 Spring Boot 中配置并使用 Redis

**推荐资源：**

- 视频：黑马程序员 Redis 入门到实战
- 文档：[Redis 官方文档](https://redis.io/docs/)
- 书籍：《Redis 设计与实现》

---

### 3.6 Linux 基础 `P1`

**学习目标**：能在 Linux 环境下部署和排查 Spring Boot 项目，掌握常用命令和服务器基础操作。

**学习周期**：1 周

**核心知识点：**

1. **文件操作**：`ls`、`cd`、`pwd`、`cp`、`mv`、`rm`、`mkdir`、`find`、`grep`
2. **权限与用户**：`chmod`、`chown`、`useradd`、`sudo`
3. **进程与网络**：`ps`、`top`、`netstat`、`ss`、`kill`、`lsof`
4. **文本处理**：`cat`、`less`、`tail -f`、`awk`、`sed`
5. **软件安装**：yum/apt、tar、systemctl 服务管理
6. **项目部署**：打包 jar、nohup 启动、查看日志、开放端口

**学习顺序：**

Day 1-2：文件与权限 → Day 3-4：进程、网络与文本处理 → Day 5-7：部署 Spring Boot 项目。

**实践任务：**

- 在本地或云服务器（阿里云/腾讯云学生机）上安装 JDK、MySQL、Redis
- 把 Spring Boot 项目打成 jar 包，用 `nohup java -jar` 部署运行
- 用 `tail -f` 查看日志，用 `ps` 查看进程

**检验标准：**

- 能不依赖图形界面完成项目部署
- 能使用 grep + tail 快速定位日志错误

**推荐资源：**

- 视频：韩顺平 Linux 教程
- 文档：[The Linux Command Line](https://linuxcommand.org/tlcl.php)

> **阶段一结束时的目标项目**：完成一个 **用户中心系统**：Spring Boot + MyBatis-Plus + MySQL + Redis + Linux 部署，包含用户注册登录、个人信息管理、接口缓存、统一异常处理、日志记录。

---

## 四、阶段二：并发与网络编程（第 11-18 周）

这一阶段是游戏服务端的核心。你必须先理解 Java 并发，再学习 Netty，否则只能停留在 API 调用层面。

### 4.1 Java 并发编程（JUC）`P0`

**学习目标**：理解多线程、锁、线程池、并发工具类，能够写出线程安全的代码，这是面试必考内容。

**学习周期**：4 周

**核心知识点：**

1. **线程基础**：`Thread`、`Runnable`、线程状态、线程中断
2. **线程同步**：`synchronized`、`volatile`、`ReentrantLock`、`ReadWriteLock`
3. **线程安全**：原子性、可见性、有序性；CAS、ABA 问题
4. **JUC 工具类**：`CountDownLatch`、`CyclicBarrier`、`Semaphore`、`Exchanger`
5. **线程池**：`ThreadPoolExecutor` 参数、拒绝策略、线程池状态、Executors 工厂方法及坑
6. **并发集合**：`ConcurrentHashMap`、`CopyOnWriteArrayList`、`BlockingQueue`
7. **原子类**：`AtomicInteger`、`AtomicReference`、LongAdder
8. **锁优化**：偏向锁、轻量级锁、自旋锁、锁粗化、锁消除（JVM 层面）
9. **JMM 内存模型**：happens-before 规则、重排序

**学习顺序：**

Week 1：线程基础 + synchronized/volatile → Week 2：Lock + CAS + JMM → Week 3：线程池 + JUC 工具类 → Week 4：并发集合 + 实战练习。

**实践任务：**

- 手写一个线程安全的计数器，分别用 synchronized、AtomicInteger、ReentrantLock 实现
- 实现一个简单线程池（可选，加深理解）
- 用 CountDownLatch 模拟多线程批量处理任务
- 实现生产者-消费者模型（用 BlockingQueue）

**检验标准：**

- 能解释 synchronized 和 ReentrantLock 的区别
- 能手写线程池 7 个参数及含义
- 能解释 volatile 为什么不能保证原子性
- 能说出 ConcurrentHashMap 的线程安全机制

**推荐资源：**

- 视频：尚硅谷 JUC 并发编程 / 黑马 JUC
- 书籍：《Java 并发编程实战》《Java 并发编程的艺术》
- 博客：美团技术博客「Java 线程池实现原理」

---

### 4.2 Netty 网络编程 `P0`

**学习目标**：掌握 Netty 核心组件和编程模型，能够开发基于 TCP/WebSocket 的网络服务，为游戏服务端打下基础。

**学习周期**：4 周

**前置要求**：必须先学完 Java 并发和计算机网络基础（TCP/UDP/Socket），否则难以理解 Netty 的 EventLoop 和线程模型。

**核心知识点：**

1. **IO 模型**：BIO、NIO、AIO 的区别；NIO 三大组件：Channel、Buffer、Selector
2. **Netty 核心组件**：Channel、EventLoop、ChannelPipeline、ChannelHandler、ByteBuf
3. **编解码**：粘包/拆包问题、LengthFieldBasedFrameDecoder、自定义协议、Protobuf 序列化
4. **启动流程**：Bootstrap、ServerBootstrap、ChannelInitializer、绑定端口
5. **Handler 编写**：inbound/outbound 事件、心跳机制、异常处理
6. **WebSocket**：Netty 实现 WebSocket 服务器，与前端联调
7. **性能优化**：内存池、零拷贝、线程模型优化

**学习顺序：**

Week 1：IO 模型与 NIO 基础 → Week 2：Netty 核心组件与 Echo 服务器 → Week 3：编解码与自定义协议 → Week 4：WebSocket + 聊天室实战。

**实践任务：**

- 用 Netty 实现 Echo 服务器
- 实现基于 Netty 的聊天室，支持私聊、群聊、在线列表
- 设计一个简单游戏通信协议（如登录、移动、聊天），用 Protobuf 实现编解码
- 实现心跳检测与断线重连机制

**检验标准：**

- 能画出 Netty 的线程模型图
- 能解释 ChannelPipeline 的事件传播机制
- 能解决粘包/拆包问题
- 能独立搭建一个 Netty WebSocket 服务

**推荐资源：**

- 视频：尚硅谷 Netty 教程 / 黑马 Netty
- 书籍：《Netty 权威指南》《Netty 实战》
- 文档：[Netty Wiki](https://netty.io/wiki/)

---

### 4.3 计算机网络基础 `P1`

**学习目标**：理解 TCP/IP、HTTP、WebSocket、Socket 编程，为 Netty 和游戏通信协议打基础。

**学习周期**：穿插在 Netty 学习前 1 周内完成

**核心知识点：**

1. **OSI 七层 / TCP/IP 四层模型**
2. **TCP**：三次握手、四次挥手、滑动窗口、拥塞控制、粘包/拆包
3. **UDP**：无连接、不可靠、低延迟、适用场景
4. **HTTP**：请求方法、状态码、Header、Cookie/Session、HTTPS 原理
5. **WebSocket**：全双工通信、与 HTTP 的关系、适用场景
6. **Socket 编程**：Java Socket、ServerSocket、NIO Selector

**实践任务：**

- 用 Java Socket 实现一个最简单的客户端-服务端通信
- 用 Wireshark 抓包观察 TCP 三次握手

**推荐资源：**

- 视频：韩立刚计算机网络 / 湖科大教书匠（B站）
- 书籍：《图解 HTTP》《TCP/IP 详解 卷一》

> **阶段二结束时的目标项目**：完成一个 **Netty 聊天室**：支持用户登录、多房间、私聊、群聊、在线状态、心跳检测、Protobuf 协议通信。

---

## 五、阶段三：游戏服务端架构与求职（第 19-22 周）

这一阶段要把前面学的内容整合成一个完整的游戏服务端项目，并开始准备面试。

### 5.1 游戏服务端架构 `P1`

**学习目标**：了解常见游戏服务端架构，理解登录服、网关服、游戏服、匹配服、数据库层的职责。

**学习周期**：2 周

**核心知识点：**

1. **服架构类型**：单服、多服、大世界、房间服
2. **核心服务**：登录服、网关服（Gateway）、游戏服、匹配服、数据库代理服
3. **同步方案**：状态同步 vs 帧同步、适用游戏类型
4. **通信协议**：Protobuf、FlatBuffers、JSON 在游戏中的选择
5. **数据持久化**：玩家数据缓存、存档、数据库写入策略
6. **常用中间件**：消息队列（RocketMQ/Kafka）、注册中心（Nacos）、RPC（Dubbo/gRPC）初步了解

**实践任务：**

- 设计一个简易棋牌/卡牌游戏服务端架构图
- 实现登录认证、房间管理、出牌/结算逻辑
- 用 Redis 做玩家在线状态缓存

**推荐资源：**

- 文章：搜索「游戏服务端架构」「状态同步 帧同步」
- 开源项目：kbengine、skynet、pomelo（阅读架构设计）

---

### 5.2 项目实战：简易棋牌/卡牌游戏服务端 `P0`

**项目目标**：综合运用 Spring Boot、Netty、Redis、MySQL，完成一个可写在简历上的游戏服务端项目。

**技术栈**：Spring Boot + Netty + MyBatis-Plus + MySQL + Redis + Protobuf + WebSocket

**功能模块：**

1. **用户模块**：注册、登录、JWT 认证、玩家信息
2. **大厅模块**：房间列表、创建房间、加入房间、离开房间
3. **游戏模块**：准备、发牌、出牌、结算、战绩记录
4. **聊天模块**：房间内文字聊天
5. **匹配模块**（可选）：简单匹配机制
6. **数据模块**：MySQL 持久化玩家数据、Redis 缓存在线状态

**开发周期**：3-4 周，边做边补充知识点。

**注意事项：**

- 代码结构要清晰，Controller/Service/Mapper 分层，Netty Handler 单独管理
- 写 README，包含项目介绍、技术栈、启动方式、接口文档
- 整理项目亮点：高并发处理、协议设计、数据一致性、异常处理

---

### 5.3 面试准备 `P0`

**准备方向**：游戏服务端实习面试通常考察：Java 基础、并发、数据库、Redis、网络、项目经历。

**算法：**

- LeetCode 刷题 150 道左右，重点：数组、字符串、哈希表、链表、栈队列、二叉树、DFS/BFS、动态规划
- 每天 1-2 题，保持手感

**八股文：**

- Java 基础：集合、泛型、反射、IO、异常
- JVM：内存模型、垃圾回收、类加载
- 并发：synchronized、volatile、JUC、线程池
- MySQL：索引、事务、锁、优化
- Redis：数据类型、持久化、缓存问题
- 网络：TCP/UDP、HTTP、WebSocket
- 框架：Spring Boot 自动配置、Spring IOC/AOP

**项目复盘：**

- 准备 3 分钟项目介绍：背景、技术栈、你的职责、难点、成果
- 每个项目准备 5 个以上可能被问到的技术问题

---

## 六、22 周详细周计划

| 周次 | 主题 | 核心任务 | 产出物 |
|------|------|----------|--------|
| 第 1 周 | Git + 环境 | Git 基础、创建 GitHub 仓库、推送项目 | Movie-Muse 在 GitHub 上线 |
| 第 2 周 | Spring Boot 入门 | 项目搭建、控制器、依赖注入、配置文件 | Hello Spring Boot 项目 |
| 第 3 周 | Spring Boot 进阶 | 整合 MyBatis-Plus、统一返回、异常处理 | 用户 CRUD 接口 |
| 第 4 周 | Spring Boot 实战 | 拦截器、登录校验、项目重构 | 带登录的 Spring Boot 项目 |
| 第 5 周 | MySQL 索引与优化 | 索引原理、EXPLAIN、慢查询 | 优化后的数据库查询 |
| 第 6 周 | MySQL 事务与锁 | 事务隔离、MVCC、锁机制 | 事务测试用例 |
| 第 7 周 | Redis 基础 | 数据类型、命令、Spring Boot 整合 | Redis 缓存用户 Session |
| 第 8 周 | Redis 应用 | 排行榜、限流、缓存问题 | 排行榜 + 限流功能 |
| 第 9 周 | Linux 部署 | Linux 命令、jar 部署、日志查看 | 项目部署到 Linux |
| 第 10 周 | 用户中心项目收尾 | 完善功能、写 README、整理代码 | 用户中心系统 v1.0 |
| 第 11 周 | Java 线程基础 | Thread、Runnable、线程状态、synchronized | 多线程计数器 Demo |
| 第 12 周 | 锁与 JMM | volatile、ReentrantLock、CAS、JMM | 线程安全工具类 |
| 第 13 周 | 线程池与 JUC | ThreadPoolExecutor、CountDownLatch、Semaphore | 批量任务处理 Demo |
| 第 14 周 | 并发集合与实战 | ConcurrentHashMap、BlockingQueue、生产者消费者 | 并发编程练习集 |
| 第 15 周 | IO 与 Netty 基础 | BIO/NIO/AIO、Netty 组件、Echo 服务器 | Netty Echo Server |
| 第 16 周 | Netty 进阶 | Pipeline、Handler、编解码、粘包拆包 | 自定义协议通信 |
| 第 17 周 | Netty WebSocket | WebSocket 服务器、心跳检测 | Netty 聊天室后端 |
| 第 18 周 | 聊天室项目完善 | 私聊、群聊、在线列表、Protobuf | 完整聊天室项目 |
| 第 19 周 | 游戏服务端架构 | 登录服、网关、游戏服、同步方案 | 架构设计文档 |
| 第 20 周 | 棋牌游戏服务端 | 用户、大厅、房间、游戏逻辑 | 游戏服务端骨架 |
| 第 21 周 | 项目完善 | Redis 缓存、数据持久化、异常处理 | 可运行的游戏服务端 |
| 第 22 周 | 面试准备 | 整理项目、刷题、八股文 | 简历 + 面试题库 |

---

## 七、项目演进路线

项目是学习效果最好的检验方式。建议你按照下面路线，逐步升级项目复杂度。

| 项目 | 技术栈 | 适合阶段 | 简历价值 |
|------|--------|----------|----------|
| 用户中心系统 | Spring Boot + MyBatis-Plus + MySQL + Redis | 阶段一结束 | 证明现代 Java 后端能力 |
| Netty 聊天室 | Netty + WebSocket + Protobuf + Redis | 阶段二结束 | 证明网络编程能力 |
| 简易棋牌/卡牌游戏服务端 | Spring Boot + Netty + Redis + MySQL + Protobuf | 阶段三结束 | 直接对口游戏服务端岗位 |

---

## 八、推荐资源汇总

| 技术 | 视频 | 书籍/文档 | 练习平台 |
|------|------|-----------|----------|
| Git | 尚硅谷 Git 教程 | Pro Git | Learn Git Branching |
| Spring Boot | 尚硅谷 / 黑马 | Spring Boot 实战、官方文档 | 官方 Guides |
| MyBatis-Plus | B站入门 | 官方文档 | 官方示例 |
| MySQL | 尚硅谷 MySQL 高级 | 《MySQL 技术内幕：InnoDB》 | LeetCode Database |
| Redis | 黑马 Redis | 《Redis 设计与实现》、官方文档 | Try Redis |
| Linux | 韩顺平 Linux | The Linux Command Line | 自己的服务器 |
| Java 并发 | 尚硅谷 JUC | 《Java 并发编程的艺术》 | 自己写 Demo |
| Netty | 尚硅谷 Netty | 《Netty 权威指南》 | 聊天室项目 |
| 算法 | 代码随想录 | 《剑指 Offer》 | LeetCode |

---

## 九、常见误区提醒

**避开这些坑：**

- **贪多嚼不烂**：不要同时学 Go、Python、C#，先把 Java 做深
- **只看视频不动手**：每看 1 小时视频，至少写 2 小时代码
- **过早追求源码**：先会用，再研究原理，不要一开始就看 Spring 源码
- **忽视项目完整性**：一个跑通的项目比十个半成品有价值
- **不做笔记**：建立自己的知识库，面试前复习效率更高

---

## 十、给你的最后建议

这份计划看起来很满，但每天保持 2-3 小时有效学习，22 周完全可以完成。最关键的是**坚持**和**动手**。

如果你在某个阶段卡住了，不要停太久，先跳过难点继续往后走，后面做项目时会自然理解前面的概念。寒假实习不是终点，而是你进入游戏行业的起点。

> **下一步行动**：今天就做三件事：注册 GitHub、创建仓库、把 Movie-Muse 项目推上去。然后明天开始学习 Spring Boot。

---

*本计划结合你的 Java/Web/MySQL 基础定制。建议每 2 周回顾一次进度，根据实际情况调整节奏。*
