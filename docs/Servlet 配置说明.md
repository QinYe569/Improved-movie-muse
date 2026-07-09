# Servlet 配置说明

## 📋 已创建的文件

### 1. IndexServlet.java
**路径：** `src/main/java/org/example/servlet/IndexServlet.java`

**功能：**
- 处理 `/index` 请求
- 重定向到 `index.html` 页面
- 支持 GET 和 POST 请求

**访问方式：**
```
http://localhost:8080/Movie-Muse/index
```

---

## 🔧 配置说明

### web.xml 配置
**路径：** `web/WEB-INF/web.xml`

```xml
<!-- 欢迎页面配置 -->
<welcome-file-list>
    <welcome-file>index</welcome-file>
</welcome-file-list>
```

**作用：**
- 项目启动时自动访问 `/index`
- 触发 IndexServlet
- 重定向到 index.html

---

## 🚀 使用方式

### 方式一：直接访问 Servlet
```
http://localhost:8080/Movie-Muse/index
```

### 方式二：访问项目根路径（推荐）
```
http://localhost:8080/Movie-Muse/
```
会自动跳转到 `/index` → `/index.html`

---

## 📁 项目结构

```
Movie-Muse/
├── src/
│   └── main/
│       └── java/
│           └── org/
│               └── example/
│                   ├── Main.java
│                   └── servlet/
│                       └── IndexServlet.java ⭐ 新增
└── web/
    ├── index.html
    ├── search.html
    └── WEB-INF/
        └── web.xml ⭐ 已更新
```

---

## 💡 Servlet 工作流程

```
1. 用户访问 http://localhost:8080/Movie-Muse/
         ↓
2. web.xml 配置欢迎页面为 index
         ↓
3. 访问 /index 路径
         ↓
4. IndexServlet 处理请求（@WebServlet("/index")）
         ↓
5. Servlet 执行重定向
         ↓
6. 浏览器跳转到 /index.html
         ↓
7. 显示首页内容
```

---

## 🔍 验证方法

### 1. 启动项目
- 在 IDEA 中配置 Tomcat
- 点击运行按钮

### 2. 访问页面
- 浏览器输入：`http://localhost:8080/Movie-Muse/`
- 应该自动跳转到 index.html 页面

### 3. 检查控制台
- 应该看到项目启动成功的日志
- 没有错误信息

---

## 📝 后续开发建议

### 可以添加的 Servlet：

1. **登录 Servlet**
   ```java
   @WebServlet("/login")
   public class LoginServlet extends HttpServlet { ... }
   ```

2. **注册 Servlet**
   ```java
   @WebServlet("/register")
   public class RegisterServlet extends HttpServlet { ... }
   ```

3. **电影列表 Servlet**
   ```java
   @WebServlet("/movie/list")
   public class MovieListServlet extends HttpServlet { ... }
   ```

4. **用户信息 Servlet**
   ```java
   @WebServlet("/user/profile")
   public class ProfileServlet extends HttpServlet { ... }
   ```

---

## ⚠️ 注意事项

1. **包路径**：确保 Servlet 在正确的包路径下
2. **注解配置**：`@WebServlet` 的 value 值要与 web.xml 中的 welcome-file 匹配
3. **重定向路径**：使用 `request.getContextPath()` 获取项目上下文路径
4. **字符编码**：如果有中文，需要设置字符编码过滤器

---

## 🎯 测试代码

IndexServlet 已创建，可以直接使用：

```java
@WebServlet(name = "IndexServlet", value = "/index")
public class IndexServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
```

---

祝项目开发顺利！🎉
