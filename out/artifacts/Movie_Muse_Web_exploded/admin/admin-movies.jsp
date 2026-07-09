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
    <title>电影管理 - Movie-Muse</title>
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
            background: url('../images/pawel-czerwinski-VWVO0g9A3rg-unsplash.jpg') center center / cover no-repeat;
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
            background: rgba(243, 244, 246, 0.7);
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

        .main-content {
            flex: 1;
            margin-left: 250px;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

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

        .page-content {
            padding: 2rem;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1.5rem;
        }

        .page-header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 0.95rem;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--primary-color), #a855f7);
            color: white;
            box-shadow: 0 4px 12px rgba(147, 51, 234, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(147, 51, 234, 0.4);
        }

        .btn-edit {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
            padding: 6px 12px;
            font-size: 0.85rem;
        }

        .btn-edit:hover {
            background: rgba(59, 130, 246, 0.2);
        }

        .btn-delete {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
            padding: 6px 12px;
            font-size: 0.85rem;
        }

        .btn-delete:hover {
            background: rgba(239, 68, 68, 0.2);
        }

        .table-container {
            background: white;
            border-radius: 12px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            overflow: hidden;
        }

        .data-table {
            width: 100%;
            border-collapse: collapse;
        }

        .data-table thead {
            background: #f9fafb;
        }

        .data-table th {
            padding: 14px 16px;
            text-align: left;
            font-weight: 600;
            color: var(--text-primary);
            font-size: 0.9rem;
            border-bottom: 2px solid var(--border-color);
        }

        .data-table tbody tr {
            border-bottom: 1px solid var(--border-color);
            transition: background 0.2s ease;
        }

        .data-table tbody tr:hover {
            background: #f9fafb;
        }

        .data-table tbody tr:nth-child(even) {
            background: #f9fafb;
        }

        .data-table tbody tr:nth-child(even):hover {
            background: #f3f4f6;
        }

        .data-table td {
            padding: 14px 16px;
            color: var(--text-secondary);
            font-size: 0.9rem;
        }

        .data-table td:first-child {
            font-weight: 600;
            color: var(--text-primary);
        }

        .poster-thumbnail {
            width: 50px;
            height: 70px;
            object-fit: cover;
            border-radius: 6px;
        }

        .movie-title {
            font-weight: 600;
            color: var(--text-primary);
        }

        .actions {
            display: flex;
            gap: 8px;
        }

        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            padding: 1rem;
            border-top: 1px solid var(--border-color);
        }

        .pagination a {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            min-width: 36px;
            height: 36px;
            padding: 0 8px;
            border-radius: 8px;
            text-decoration: none;
            color: var(--text-secondary);
            font-weight: 500;
            transition: all 0.2s ease;
        }

        .pagination a:hover {
            background: rgba(147, 51, 234, 0.1);
            color: var(--primary-color);
        }

        .pagination a.active {
            background: var(--primary-color);
            color: white;
        }

        .pagination .info {
            color: var(--text-secondary);
            font-size: 0.85rem;
            margin-right: 1rem;
        }

        .status-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .status-online {
            background: rgba(34, 197, 94, 0.1);
            color: #22c55e;
        }

        .status-offline {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .free-badge {
            display: inline-block;
            padding: 4px 10px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
        }

        .free-yes {
            background: rgba(34, 197, 94, 0.1);
            color: #22c55e;
        }

        .free-no {
            background: rgba(239, 68, 68, 0.1);
            color: #ef4444;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            color: var(--text-secondary);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 100%;
                height: auto;
                position: relative;
            }

            .sidebar-nav ul {
                display: flex;
                flex-wrap: wrap;
                gap: 8px;
            }

            .main-content {
                margin-left: 0;
            }

            .page-content {
                padding: 1rem;
            }

            .table-container {
                overflow-x: auto;
            }

            .data-table {
                min-width: 800px;
            }
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
                    <a href="${pageContext.request.contextPath}/admin/movies" class="active">
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
                    <a href="${pageContext.request.contextPath}/admin/announcements">
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
            <div class="nav-right">
                <div class="user-info">
                    <div class="user-avatar">${currentAdmin.username.substring(0, 1).toUpperCase()}</div>
                    <span class="user-name">${currentAdmin.username}</span>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <main class="page-content">
            <div class="page-header">
                <h1>电影管理 <span style="font-size: 1rem; color: var(--text-secondary); font-weight: 400;">(共 ${totalCount} 部)</span></h1>
                <a href="${pageContext.request.contextPath}/admin/movie-edit" class="btn btn-primary">
                    <i class="fas fa-plus"></i> 添加新电影
                </a>
            </div>

            <!-- Table Container -->
            <div class="table-container">
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>海报</th>
                            <th>电影名</th>
                            <th>导演</th>
                            <th>上映年份</th>
                            <th>评分</th>
                            <th>免费</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:choose>
                            <c:when test="${empty movies}">
                                <tr>
                                    <td colspan="9">
                                        <div class="empty-state">
                                            <i class="fas fa-film"></i>
                                            <p>暂无电影数据</p>
                                        </div>
                                    </td>
                                </tr>
                            </c:when>
                            <c:otherwise>
                                <c:forEach var="movie" items="${movies}">
                                    <tr>
                                        <td>${movie.id}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${not empty movie.poster}">
                                                    <img src="${movie.poster}" alt="海报" class="poster-thumbnail"
                                                         onerror="this.src='https://via.placeholder.com/50x70?text=N/A'">
                                                </c:when>
                                                <c:otherwise>
                                                    <img src="https://via.placeholder.com/50x70?text=N/A" alt="无海报" class="poster-thumbnail">
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td><span class="movie-title">${movie.title}</span></td>
                                        <td>${movie.director}</td>
                                        <td>${movie.releaseYear}</td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${movie.rating != null}">
                                                    <i class="fas fa-star" style="color: #f59e0b;"></i> ${movie.rating}
                                                </c:when>
                                                <c:otherwise>-</c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${movie.isFree == 1}">
                                                    <span class="free-badge free-yes">免费</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="free-badge free-no">付费</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <c:choose>
                                                <c:when test="${movie.status == 1}">
                                                    <span class="status-badge status-online">上架</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="status-badge status-offline">下架</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </td>
                                        <td>
                                            <div class="actions">
                                                <a href="${pageContext.request.contextPath}/admin/movie-edit?id=${movie.id}" class="btn btn-edit">
                                                    <i class="fas fa-edit"></i> 编辑
                                                </a>
                                                <a href="${pageContext.request.contextPath}/admin/movie-delete?id=${movie.id}"
                                                   class="btn btn-delete"
                                                   onclick="return confirm('确定要删除电影「${movie.title}」吗？');">
                                                    <i class="fas fa-trash"></i> 删除
                                                </a>
                                            </div>
                                        </td>
                                    </tr>
                                </c:forEach>
                            </c:otherwise>
                        </c:choose>
                    </tbody>
                </table>

                <!-- Pagination -->
                <c:if test="${totalPages > 1}">
                    <div class="pagination">
                        <span class="info">第 ${currentPage} / ${totalPages} 页</span>
                        <c:choose>
                            <c:when test="${currentPage > 1}">
                                <a href="${pageContext.request.contextPath}/admin/movies?page=${currentPage - 1}">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" style="opacity: 0.3; pointer-events: none;">
                                    <i class="fas fa-chevron-left"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>

                        <c:forEach var="i" begin="1" end="${totalPages}">
                            <c:choose>
                                <c:when test="${i == currentPage}">
                                    <a href="javascript:void(0)" class="active">${i}</a>
                                </c:when>
                                <c:otherwise>
                                    <a href="${pageContext.request.contextPath}/admin/movies?page=${i}">${i}</a>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>

                        <c:choose>
                            <c:when test="${currentPage < totalPages}">
                                <a href="${pageContext.request.contextPath}/admin/movies?page=${currentPage + 1}">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:when>
                            <c:otherwise>
                                <a href="javascript:void(0)" style="opacity: 0.3; pointer-events: none;">
                                    <i class="fas fa-chevron-right"></i>
                                </a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:if>
            </div>
        </main>
    </div>
</body>
</html>
