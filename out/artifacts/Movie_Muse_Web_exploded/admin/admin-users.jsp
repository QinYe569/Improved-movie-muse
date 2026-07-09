<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<c:if test="${empty currentAdmin}">
    <c:redirect url="${pageContext.request.contextPath}/admin/login"/>
</c:if>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户管理 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --sidebar-bg: #1a1a2e;
            --sidebar-hover: #16213e;
            --primary-color: #9333ea;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --border-color: #e5e7eb;
            --card-bg: #ffffff;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: url('${pageContext.request.contextPath}/images/pawel-czerwinski-VWVO0g9A3rg-unsplash.jpg') center center / cover no-repeat;
            min-height: 100vh;
            display: flex;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(243, 244, 246, 0.3);
            z-index: 0;
        }

        body > * {
            position: relative;
            z-index: 1;
        }

        /* Sidebar */
        .sidebar {
            width: 250px;
            background: var(--sidebar-bg);
            color: white;
            min-height: 100vh;
            position: fixed;
            left: 0;
            top: 0;
            display: flex;
            flex-direction: column;
            z-index: 100;
        }

        .sidebar .logo {
            padding: 1.5rem;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar .logo h1 {
            font-size: 40px;
            font-weight: 800;
            background: linear-gradient(135deg, #9333ea, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
            line-height: 1.2;
        }

        .sidebar-nav {
            flex: 1;
            padding: 1rem;
        }

        .sidebar-nav ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }

        .sidebar-nav li {
            margin-bottom: 4px;
        }

        .sidebar-nav a {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            border-radius: 8px;
            color: #9ca3af;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .sidebar-nav a:hover {
            background: var(--sidebar-hover);
            color: white;
        }

        .sidebar-nav a.active {
            background: var(--primary-color);
            color: white;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 250px;
            padding: 2rem 3rem;
        }

        .top-nav {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 2rem;
            background: white;
            padding: 1.5rem 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .user-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #9333ea, #a855f7);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
        }

        /* Page Header */
        .page-header {
            background: white;
            padding: 2rem;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 2rem;
        }

        .page-title {
            font-size: 1.875rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .page-subtitle {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        /* Table */
        .table-container {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        thead {
            background: #f9fafb;
        }

        th {
            padding: 1rem 1.5rem;
            text-align: left;
            font-weight: 600;
            color: var(--text-secondary);
            font-size: 0.75rem;
            text-transform: uppercase;
            letter-spacing: 0.05em;
        }

        td {
            padding: 1rem 1.5rem;
            border-top: 1px solid var(--border-color);
            color: var(--text-primary);
        }

        tr:hover {
            background: #f9fafb;
        }

        .action-buttons {
            display: flex;
            gap: 8px;
        }

        .btn-sm {
            padding: 6px 12px;
            font-size: 0.75rem;
            border-radius: 6px;
            border: none;
            cursor: pointer;
            transition: all 0.3s ease;
            display: inline-flex;
            align-items: center;
            gap: 6px;
            text-decoration: none;
        }

        .btn-ban {
            background: #fef3c7;
            color: #92400e;
        }

        .btn-ban:hover {
            background: #fde68a;
        }

        .btn-unban {
            background: #d1fae5;
            color: #065f46;
        }

        .btn-unban:hover {
            background: #a7f3d0;
        }

        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }

        .btn-delete:hover {
            background: #fecaca;
        }

        /* Badge */
        .badge {
            display: inline-block;
            padding: 4px 12px;
            border-radius: 12px;
            font-size: 0.75rem;
            font-weight: 500;
        }

        .badge-active {
            background: #d1fae5;
            color: #065f46;
        }

        .badge-banned {
            background: #fee2e2;
            color: #991b1b;
        }

        .user-avatar-small {
            width: 32px;
            height: 32px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            font-size: 0.875rem;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.5;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <aside class="sidebar">
        <div class="logo">
            <h1>Movie-Muse</h1>
        </div>
        <nav class="sidebar-nav">
            <ul>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/dashboard">
                        <i class="fas fa-tachometer-alt"></i> 控制台
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/movies">
                        <i class="fas fa-film"></i> 电影管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/categories">
                        <i class="fas fa-tags"></i> 分类管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/users" class="active">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/comments">
                        <i class="fas fa-comments"></i> 评论管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/announcements">
                        <i class="fas fa-bullhorn"></i> 公告管理
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <main class="main-content">
        <!-- Top Navbar -->
        <header class="top-nav">
            <div class="user-info">
                <div class="user-avatar">
                    <c:out value="${currentAdmin.username.substring(0, 1).toUpperCase()}"/>
                </div>
                <span style="font-weight: 500;"><c:out value="${currentAdmin.username}"/></span>
            </div>
        </header>

        <!-- Page Header -->
        <div class="page-header">
            <h1 class="page-title"><i class="fas fa-users" style="margin-right: 12px; color: #9333ea;"></i>用户管理</h1>
            <p class="page-subtitle">管理系统用户，包括用户信息查看、封禁和删除操作</p>
        </div>

        <!-- Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>用户</th>
                        <th>用户名</th>
                        <th>邮箱</th>
                        <th>注册时间</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${users}" var="user" varStatus="status">
                        <tr>
                            <td>${user.id}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${status.index % 5 == 0}">
                                        <div class="user-avatar-small" style="background: linear-gradient(135deg, #f093fb, #f5576c);">
                                            <c:out value="${user.username.substring(0, 1).toUpperCase()}"/>
                                        </div>
                                    </c:when>
                                    <c:when test="${status.index % 5 == 1}">
                                        <div class="user-avatar-small" style="background: linear-gradient(135deg, #4facfe, #00f2fe);">
                                            <c:out value="${user.username.substring(0, 1).toUpperCase()}"/>
                                        </div>
                                    </c:when>
                                    <c:when test="${status.index % 5 == 2}">
                                        <div class="user-avatar-small" style="background: linear-gradient(135deg, #fa709a, #fee140);">
                                            <c:out value="${user.username.substring(0, 1).toUpperCase()}"/>
                                        </div>
                                    </c:when>
                                    <c:when test="${status.index % 5 == 3}">
                                        <div class="user-avatar-small" style="background: linear-gradient(135deg, #a8edea, #fed6e3);">
                                            <c:out value="${user.username.substring(0, 1).toUpperCase()}"/>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="user-avatar-small" style="background: linear-gradient(135deg, #ffecd2, #fcb69f);">
                                            <c:out value="${user.username.substring(0, 1).toUpperCase()}"/>
                                        </div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><strong><c:out value="${user.username}"/></strong></td>
                            <td><c:out value="${user.email}"/></td>
                            <td><fmt:formatDate value="${user.createTime}" pattern="yyyy-MM-dd"/></td>
                            <td>
                                <c:choose>
                                    <c:when test="${user.status == 1}">
                                        <span class="badge badge-active">正常</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-banned">已封禁</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <c:choose>
                                        <c:when test="${user.status == 1}">
                                            <a href="${pageContext.request.contextPath}/admin/user-ban?id=${user.id}"
                                               class="btn-sm btn-ban"
                                               onclick="return confirm('确定要封禁用户「${user.username}」吗？');">
                                                <i class="fas fa-ban"></i> 封禁
                                            </a>
                                        </c:when>
                                        <c:otherwise>
                                            <a href="${pageContext.request.contextPath}/admin/user-ban?id=${user.id}"
                                               class="btn-sm btn-unban"
                                               onclick="return confirm('确定要解封用户「${user.username}」吗？');">
                                                <i class="fas fa-check"></i> 解封
                                            </a>
                                        </c:otherwise>
                                    </c:choose>
                                    <a href="${pageContext.request.contextPath}/admin/user-delete?id=${user.id}"
                                       class="btn-sm btn-delete"
                                       onclick="return confirm('确定要删除用户「${user.username}」吗？');">
                                        <i class="fas fa-trash"></i> 删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty users}">
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <p>暂无用户数据</p>
                                </div>
                            </td>
                        </tr>
                    </c:if>
                </tbody>
            </table>
        </div>
    </main>
</body>
</html>
