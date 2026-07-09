<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>分类管理 - Movie-Muse</title>
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

        .action-bar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border-radius: 8px;
            font-weight: 500;
            text-decoration: none;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            font-size: 0.875rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, #9333ea, #a855f7);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(147, 51, 234, 0.4);
        }

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
        }

        .btn-edit {
            background: #dbeafe;
            color: #1e40af;
        }

        .btn-edit:hover {
            background: #bfdbfe;
        }

        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }

        .btn-delete:hover {
            background: #fecaca;
        }

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

        .badge-inactive {
            background: #fee2e2;
            color: #991b1b;
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
                    <a href="${pageContext.request.contextPath}/admin/categories" class="active">
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
            <h1 class="page-title"><i class="fas fa-tags" style="margin-right: 12px; color: #9333ea;"></i>分类管理</h1>
            <p class="page-subtitle">管理电影分类，包括添加、编辑和删除分类</p>
        </div>

        <!-- Action Bar -->
        <div class="action-bar">
            <a href="${pageContext.request.contextPath}/admin/category-edit" class="btn btn-primary">
                <i class="fas fa-plus"></i> 添加分类
            </a>
        </div>

        <!-- Table -->
        <div class="table-container">
            <table>
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>分类名称</th>
                        <th>图标</th>
                        <th>描述</th>
                        <th>排序</th>
                        <th>状态</th>
                        <th>操作</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach items="${categories}" var="cat">
                        <tr>
                            <td>${cat.id}</td>
                            <td>
                                <div style="display: flex; align-items: center; gap: 10px;">
                                    <c:choose>
                                        <c:when test="${not empty cat.icon}">
                                            <i class="${cat.icon}" style="color: #9333ea; width: 20px; text-align: center;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-tag" style="color: #9333ea;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span><c:out value="${cat.name}"/></span>
                                </div>
                            </td>
                            <td><code style="font-size: 0.75rem; color: var(--text-secondary);"><c:out value="${cat.icon}"/></code></td>
                            <td><c:out value="${cat.description}"/></td>
                            <td>${cat.sortOrder}</td>
                            <td>
                                <c:choose>
                                    <c:when test="${cat.status == 1}">
                                        <span class="badge badge-active">启用</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge badge-inactive">禁用</span>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <div class="action-buttons">
                                    <a href="${pageContext.request.contextPath}/admin/category-edit?id=${cat.id}" class="btn btn-sm btn-edit">
                                        <i class="fas fa-edit"></i> 编辑
                                    </a>
                                    <a href="${pageContext.request.contextPath}/admin/category-delete?id=${cat.id}"
                                       class="btn btn-sm btn-delete"
                                       onclick="return confirm('确定要删除分类「${cat.name}」吗？');">
                                        <i class="fas fa-trash"></i> 删除
                                    </a>
                                </div>
                            </td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty categories}">
                        <tr>
                            <td colspan="7">
                                <div class="empty-state">
                                    <i class="fas fa-inbox"></i>
                                    <p>暂无分类数据</p>
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
