<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<c:if test="${empty currentAdmin}">
    <c:redirect url="${pageContext.request.contextPath}/admin/login"/>
</c:if>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>发布公告 - Movie-Muse</title>
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
        }

        .content-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .content-header p {
            color: var(--text-secondary);
            font-size: 1.05rem;
        }

        /* Form */
        .form-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            max-width: 800px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            font-family: inherit;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(147, 51, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 200px;
        }

        .btn-submit {
            padding: 14px 32px;
            background: linear-gradient(135deg, var(--primary-color), #a855f7);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(147, 51, 234, 0.3);
        }

        .btn-submit:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(147, 51, 234, 0.4);
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .alert-success {
            background: #d1fae5;
            color: #065f46;
            border: 1px solid #a7f3d0;
        }

        .alert-error {
            background: #fee2e2;
            color: #991b1b;
            border: 1px solid #fecaca;
        }

        .btn-back {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 10px 20px;
            background: white;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            color: var(--text-primary);
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            margin-bottom: 1.5rem;
        }

        .btn-back:hover {
            border-color: var(--primary-color);
            color: var(--primary-color);
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
                <h1>发布公告</h1>
                <p>在此发布新的系统公告，所有用户都将在首页看到。</p>
            </div>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <i class="fas fa-check-circle"></i> ${success}
                </div>
            </c:if>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <i class="fas fa-exclamation-circle"></i> ${error}
                </div>
            </c:if>

            <div class="form-card">
                <form action="${pageContext.request.contextPath}/admin/announcement-edit" method="post">
                    <div class="form-group">
                        <label for="title">公告标题</label>
                        <input type="text" id="title" name="title" placeholder="请输入公告标题" required>
                    </div>

                    <div class="form-group">
                        <label for="content">公告内容</label>
                        <textarea id="content" name="content" placeholder="请输入公告内容" required></textarea>
                    </div>

                    <button type="submit" class="btn-submit">
                        <i class="fas fa-paper-plane"></i> 发布公告
                    </button>
                </form>
            </div>
        </main>
    </div>
</body>
</html>