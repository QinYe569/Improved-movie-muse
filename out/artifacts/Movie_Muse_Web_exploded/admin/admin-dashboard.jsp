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
    <title>管理后台 - Movie-Muse</title>
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

        /* Dashboard Content */
        .dashboard-content {
            padding: 2rem;
        }

        .dashboard-content .welcome-section {
            margin-bottom: 2rem;
        }

        .dashboard-content .welcome-section h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .dashboard-content .welcome-section p {
            color: var(--text-secondary);
            font-size: 1.05rem;
        }

        /* Stats Cards */
        .stats-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .stat-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 8px 12px rgba(0, 0, 0, 0.08);
        }

        .stat-card .stat-icon {
            width: 50px;
            height: 50px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
            margin-bottom: 1rem;
        }

        .stat-card:nth-child(1) .stat-icon {
            background: rgba(147, 51, 234, 0.1);
            color: var(--primary-color);
        }

        .stat-card:nth-child(2) .stat-icon {
            background: rgba(34, 197, 94, 0.1);
            color: #22c55e;
        }

        .stat-card:nth-child(3) .stat-icon {
            background: rgba(59, 130, 246, 0.1);
            color: #3b82f6;
        }

        .stat-card .stat-value {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.25rem;
        }

        .stat-card .stat-label {
            color: var(--text-secondary);
            font-size: 0.95rem;
        }

        /* Quick Actions */
        .quick-actions {
            background: white;
            border-radius: 12px;
            padding: 1.5rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
        }

        .quick-actions h3 {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid var(--border-color);
        }

        .quick-actions .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(180px, 1fr));
            gap: 1rem;
        }

        .quick-actions .action-btn {
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 16px;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            background: white;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: left;
        }

        .quick-actions .action-btn:hover {
            border-color: var(--primary-color);
            background: rgba(147, 51, 234, 0.05);
            color: var(--primary-color);
        }

        .quick-actions .action-btn i {
            font-size: 1.2rem;
        }

        .quick-actions .action-btn span {
            font-weight: 500;
            color: var(--text-primary);
        }

        /* Responsive */
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

            .stats-grid {
                grid-template-columns: 1fr;
            }

            .top-nav {
                flex-wrap: wrap;
                gap: 1rem;
            }

            .top-nav .nav-left {
                width: 100%;
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
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="active">
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

        <!-- Dashboard Content -->
        <main class="dashboard-content">
            <div class="welcome-section">
                <h1>欢迎进入管理后台</h1>
                <p>这是您的管理控制台，您可以在这里管理电影、分类和用户。</p>
            </div>

            <!-- Stats Cards -->
            <div class="stats-grid">
                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-film"></i>
                    </div>
                    <div class="stat-value">${totalMovies}</div>
                    <div class="stat-label">总电影数</div>
                </div>

                <div class="stat-card">
                    <div class="stat-icon">
                        <i class="fas fa-users"></i>
                    </div>
                    <div class="stat-value">${totalUsers}</div>
                    <div class="stat-label">总用户数</div>
                </div>
            </div>

            <!-- Quick Actions -->
            <div class="quick-actions">
                <h3>快捷操作</h3>
                <div class="action-buttons">
                    <a href="${pageContext.request.contextPath}/admin/announcement-edit" class="action-btn">
                        <i class="fas fa-bullhorn"></i>
                        <span>发布公告</span>
                    </a>
                    <a href="#favorite-stats" class="action-btn">
                        <i class="fas fa-heart"></i>
                        <span>查看收藏统计</span>
                    </a>
                </div>
            </div>

            <!-- Favorite Stats -->
            <div class="quick-actions" id="favorite-stats" style="margin-top: 2rem;">
                <h3><i class="fas fa-heart" style="color: #ef4444;"></i> 电影收藏统计</h3>
                <div style="overflow-x: auto;">
                    <table style="width: 100%; border-collapse: collapse; margin-top: 1rem;">
                        <thead>
                            <tr style="border-bottom: 2px solid var(--border-color);">
                                <th style="padding: 12px; text-align: left; color: var(--text-primary); font-weight: 600;">排名</th>
                                <th style="padding: 12px; text-align: left; color: var(--text-primary); font-weight: 600;">电影名称</th>
                                <th style="padding: 12px; text-align: center; color: var(--text-primary); font-weight: 600;">收藏数量</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${favoriteStats}" var="stat" varStatus="status">
                                <tr style="border-bottom: 1px solid var(--border-color);">
                                    <td style="padding: 12px; color: var(--text-secondary);">${status.index + 1}</td>
                                    <td style="padding: 12px; color: var(--text-primary); font-weight: 500;">${stat.title}</td>
                                    <td style="padding: 12px; text-align: center;">
                                        <span style="background: rgba(147, 51, 234, 0.1); color: var(--primary-color); padding: 4px 12px; border-radius: 12px; font-weight: 600;">
                                            ${stat.favoriteCount}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                            <c:if test="${empty favoriteStats}">
                                <tr>
                                    <td colspan="3" style="padding: 2rem; text-align: center; color: var(--text-secondary);">
                                        <i class="fas fa-inbox" style="font-size: 2rem; margin-bottom: 0.5rem; display: block;"></i>
                                        暂无收藏数据
                                    </td>
                                </tr>
                            </c:if>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
    </div>
    <script>
        // 快捷操作按钮
        document.querySelectorAll('.action-btn').forEach(btn => {
            btn.addEventListener('click', function() {
                const action = this.querySelector('span').textContent;
                alert('快捷操作演示：' + action);
            });
        });
    </script>
</body>
</html>