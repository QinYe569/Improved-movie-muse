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
    <title>公告列表 - Movie-Muse</title>
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
            background: url('../images/pawel-czerwinski-SawCLzAiew8-unsplash.jpg') center center / cover no-repeat;
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
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .sidebar-nav a:hover {
            background: var(--sidebar-hover);
            color: white;
        }

        .sidebar-nav a.active {
            background: rgba(147, 51, 234, 0.2);
            color: #a855f7;
            border-left: 3px solid var(--primary-color);
        }

        .sidebar-nav a.active i {
            color: #a855f7;
        }

        /* Main Content */
        .main-content {
            flex: 1;
            margin-left: 250px;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        /* Top Navbar */
        .top-nav {
            background: white;
            padding: 1rem 2rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.05);
            position: sticky;
            top: 0;
            z-index: 50;
        }

        .top-nav .nav-left {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .top-nav .nav-left a {
            color: var(--text-secondary);
            text-decoration: none;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 6px;
            transition: color 0.3s ease;
        }

        .top-nav .nav-left a:hover {
            color: var(--primary-color);
        }

        .top-nav .nav-right {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .top-nav .user-info {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 8px 16px;
            background: rgba(147, 51, 234, 0.08);
            border-radius: 25px;
        }

        .top-nav .user-avatar {
            width: 36px;
            height: 36px;
            border-radius: 50%;
            background: linear-gradient(135deg, var(--primary-color), #a855f7);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-weight: 600;
            font-size: 0.85rem;
        }

        .top-nav .user-name {
            font-weight: 600;
            color: var(--text-primary);
        }

        /* Content */
        .content {
            padding: 2rem;
        }

        .content-header {
            margin-bottom: 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .content-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .btn-add {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            background: linear-gradient(135deg, var(--primary-color), #a855f7);
            color: white;
            text-decoration: none;
            border-radius: 10px;
            font-weight: 600;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(147, 51, 234, 0.3);
        }

        .btn-add:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(147, 51, 234, 0.4);
        }

        /* Table */
        .table-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        table {
            width: 100%;
            border-collapse: collapse;
        }

        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid var(--border-color);
        }

        th {
            color: var(--text-primary);
            font-weight: 600;
            background: #f9fafb;
        }

        td {
            color: var(--text-secondary);
        }

        .announcement-title {
            color: var(--text-primary);
            font-weight: 500;
        }

        .announcement-content {
            max-width: 400px;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }

        .btn-delete {
            padding: 6px 12px;
            background: #fee2e2;
            color: #dc2626;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            font-size: 0.875rem;
            transition: all 0.3s ease;
        }

        .btn-delete:hover {
            background: #fecaca;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            display: block;
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
                    <a href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/comments">
                        <i class="fas fa-comments"></i> 评论管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/announcements" class="active">
                        <i class="fas fa-bullhorn"></i> 公告管理
                    </a>
                </li>
            </ul>
        </nav>
    </aside>

    <!-- Main Content -->
    <div class="main-content">
        <!-- Top Navbar -->
        <header class="top-nav">
            <div class="nav-left">
                <a href="${pageContext.request.contextPath}/admin/dashboard">
                    <i class="fas fa-arrow-left"></i> 返回控制台
                </a>
            </div>
            <div class="nav-right">
                <div class="user-info">
                    <div class="user-avatar">${currentAdmin.username.substring(0, 1).toUpperCase()}</div>
                    <span class="user-name">${currentAdmin.username}</span>
                </div>
            </div>
        </header>

        <!-- Content -->
        <main class="content">
            <div class="content-header">
                <h1>公告列表</h1>
                <a href="${pageContext.request.contextPath}/admin/announcement-edit" class="btn-add">
                    <i class="fas fa-plus"></i> 发布公告
                </a>
            </div>

            <div class="table-card">
                <c:if test="${empty announcements}">
                    <div class="empty-state">
                        <i class="fas fa-inbox"></i>
                        <p>暂无公告</p>
                    </div>
                </c:if>

                <c:if test="${not empty announcements}">
                    <table>
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>标题</th>
                                <th>内容</th>
                                <th>发布人</th>
                                <th>发布时间</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${announcements}" var="announcement">
                                <tr>
                                    <td>${announcement.id}</td>
                                    <td class="announcement-title">${announcement.title}</td>
                                    <td class="announcement-content">${announcement.content}</td>
                                    <td>${announcement.author.username}</td>
                                    <td>
                                        <fmt:formatDate value="${announcement.publishTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>