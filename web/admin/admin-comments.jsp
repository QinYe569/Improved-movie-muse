<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>评论管理 - Movie-Muse</title>
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
        }

        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: url('${pageContext.request.contextPath}/images/pawel-czerwinski-VWVO0g9A3rg-unsplash.jpg') center center / cover no-repeat;
            min-height: 100vh;
            display: flex;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(243, 244, 246, 0.3);
            z-index: 0;
        }

        body > * { position: relative; z-index: 1; }

        .sidebar {
            width: 250px;
            background: var(--sidebar-bg);
            color: white;
            min-height: 100vh;
            position: fixed;
            left: 0; top: 0;
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

        .sidebar-nav { flex: 1; padding: 1rem; }
        .sidebar-nav ul { list-style: none; padding: 0; margin: 0; }
        .sidebar-nav li { margin-bottom: 4px; }
        .sidebar-nav a {
            display: flex; align-items: center; gap: 12px;
            padding: 12px 16px; border-radius: 8px;
            color: #9ca3af; text-decoration: none;
            transition: all 0.3s ease;
        }
        .sidebar-nav a:hover { background: var(--sidebar-hover); color: white; }
        .sidebar-nav a.active { background: var(--primary-color); color: white; }

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
            width: 40px; height: 40px;
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

        .stats-bar {
            display: flex;
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            flex: 1;
        }

        .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--primary-color);
        }

        .stat-label {
            color: var(--text-secondary);
            font-size: 0.875rem;
        }

        .movie-card {
            background: white;
            border-radius: 12px;
            overflow: hidden;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
            margin-bottom: 1.5rem;
        }

        .movie-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 1.25rem 1.5rem;
            background: #f9fafb;
            cursor: pointer;
            user-select: none;
            transition: background 0.3s ease;
        }

        .movie-header:hover {
            background: #f3f4f6;
        }

        .movie-info {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .movie-poster {
            width: 48px;
            height: 72px;
            border-radius: 6px;
            object-fit: cover;
        }

        .movie-title {
            font-weight: 600;
            color: var(--text-primary);
        }

        .movie-meta {
            font-size: 0.875rem;
            color: var(--text-secondary);
        }

        .movie-actions {
            display: flex;
            align-items: center;
            gap: 1rem;
        }

        .toggle-icon {
            transition: transform 0.3s ease;
            color: var(--text-secondary);
        }

        .toggle-icon.rotated {
            transform: rotate(180deg);
        }

        .comments-section {
            display: none;
            padding: 1rem 1.5rem;
        }

        .comments-section.expanded {
            display: block;
        }

        .comment-item {
            display: flex;
            gap: 1rem;
            padding: 1rem 0;
            border-bottom: 1px solid var(--border-color);
        }

        .comment-item:last-child {
            border-bottom: none;
        }

        .comment-avatar {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-weight: 600;
            flex-shrink: 0;
        }

        .comment-content {
            flex: 1;
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.5rem;
        }

        .comment-author {
            font-weight: 600;
            color: var(--text-primary);
        }

        .comment-time {
            font-size: 0.75rem;
            color: var(--text-secondary);
        }

        .comment-text {
            color: var(--text-secondary);
            line-height: 1.6;
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

        .btn-delete {
            background: #fee2e2;
            color: #991b1b;
        }

        .btn-delete:hover {
            background: #fecaca;
        }

        .btn-clear {
            background: #fef3c7;
            color: #92400e;
        }

        .btn-clear:hover {
            background: #fde68a;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: var(--text-secondary);
            background: white;
            border-radius: 12px;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
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
                    <a href="${pageContext.request.contextPath}/admin/users">
                        <i class="fas fa-users"></i> 用户管理
                    </a>
                </li>
                <li>
                    <a href="${pageContext.request.contextPath}/admin/comments" class="active">
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
            <h1 class="page-title"><i class="fas fa-comments" style="margin-right: 12px; color: #9333ea;"></i>评论管理</h1>
            <p class="page-subtitle">管理用户评论，按电影分组展示，支持删除单条评论和清空整部电影评论</p>
        </div>

        <!-- Stats -->
        <div class="stats-bar">
            <div class="stat-card">
                <div class="stat-value">${commentCount}</div>
                <div class="stat-label">评论总数</div>
            </div>
            <div class="stat-card">
                <div class="stat-value">${movieGroups.size()}</div>
                <div class="stat-label">涉及电影</div>
            </div>
        </div>

        <!-- Comments by Movie -->
        <c:choose>
            <c:when test="${empty movieGroups}">
                <div class="empty-state">
                    <i class="fas fa-inbox"></i>
                    <p>暂无评论数据</p>
                </div>
            </c:when>
            <c:otherwise>
                <c:forEach items="${movieGroups}" var="group" varStatus="status">
                    <c:set var="movie" value="${group.movie}"/>
                    <c:set var="movieComments" value="${group.comments}"/>
                    <div class="movie-card">
                        <div class="movie-header" onclick="toggleComments(${status.index})">
                            <div class="movie-info">
                                <img src="${not empty movie.poster ? movie.poster : pageContext.request.contextPath.concat('/images/default-movie.jpg')}"
                                     alt="${movie.title}" class="movie-poster"
                                     onerror="this.src='${pageContext.request.contextPath}/images/default-movie.jpg'">
                                <div>
                                    <div class="movie-title"><c:out value="${movie.title}"/></div>
                                    <div class="movie-meta">${movieComments.size()} 条评论</div>
                                </div>
                            </div>
                            <div class="movie-actions">
                                <a href="${pageContext.request.contextPath}/admin/comment-clear?movieId=${movie.id}"
                                   class="btn-sm btn-clear"
                                   onclick="return confirm('确定要清空《${movie.title}》的所有评论吗？'); event.stopPropagation();">
                                    <i class="fas fa-broom"></i> 清空
                                </a>
                                <i class="fas fa-chevron-down toggle-icon" id="icon-${status.index}"></i>
                            </div>
                        </div>
                        <div class="comments-section" id="comments-${status.index}">
                            <c:forEach items="${movieComments}" var="comment">
                                <div class="comment-item">
                                    <div class="comment-avatar">
                                        <c:out value="${comment.user.username.substring(0, 1).toUpperCase()}"/>
                                    </div>
                                    <div class="comment-content">
                                        <div class="comment-header">
                                            <div>
                                                <span class="comment-author"><c:out value="${comment.user.username}"/></span>
                                                <span class="comment-time">
                                                    <fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/>
                                                </span>
                                            </div>
                                            <a href="${pageContext.request.contextPath}/admin/comment-delete?id=${comment.id}"
                                               class="btn-sm btn-delete"
                                               onclick="return confirm('确定要删除这条评论吗？');">
                                                <i class="fas fa-trash"></i> 删除
                                            </a>
                                        </div>
                                        <div class="comment-text"><c:out value="${comment.content}"/></div>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </main>

    <script>
        function toggleComments(index) {
            const section = document.getElementById('comments-' + index);
            const icon = document.getElementById('icon-' + index);
            section.classList.toggle('expanded');
            icon.classList.toggle('rotated');
        }

        // 默认展开第一个
        if (document.querySelectorAll('.movie-card').length > 0) {
            toggleComments(0);
        }
    </script>
</body>
</html>
