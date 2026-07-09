<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${editMode ? '编辑分类' : '添加分类'} - Movie-Muse</title>
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

        .form-card {
            background: white;
            border-radius: 12px;
            padding: 2rem;
            box-shadow: 0 2px 8px rgba(0, 0, 0, 0.05);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: var(--text-primary);
            font-size: 0.875rem;
        }

        .form-group input,
        .form-group textarea,
        .form-group select {
            width: 100%;
            padding: 0.75rem 1rem;
            border: 1px solid var(--border-color);
            border-radius: 8px;
            font-size: 0.875rem;
            color: var(--text-primary);
            outline: none;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus,
        .form-group select:focus {
            border-color: var(--primary-color);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .form-row {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .form-actions {
            display: flex;
            justify-content: flex-end;
            gap: 1rem;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
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

        .btn-secondary {
            background: #f3f4f6;
            color: var(--text-primary);
        }

        .btn-secondary:hover {
            background: #e5e7eb;
        }

        .error-message {
            background: #fee2e2;
            color: #991b1b;
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        @media (max-width: 768px) {
            .form-row { grid-template-columns: 1fr; }
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
            <h1 class="page-title">
                <i class="fas fa-${editMode ? 'edit' : 'plus'}" style="margin-right: 12px; color: #9333ea;"></i>
                ${editMode ? '编辑分类' : '添加分类'}
            </h1>
            <p class="page-subtitle">${editMode ? '修改分类信息' : '创建一个新的电影分类'}</p>
        </div>

        <!-- Form -->
        <div class="form-card">
            <c:if test="${not empty errorMessage}">
                <div class="error-message">
                    <i class="fas fa-exclamation-circle"></i> <c:out value="${errorMessage}"/>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/category-edit" method="post">
                <c:if test="${editMode}">
                    <input type="hidden" name="id" value="${category.id}">
                </c:if>

                <div class="form-group">
                    <label for="name">分类名称 <span style="color: #dc2626;">*</span></label>
                    <input type="text" id="name" name="name"
                           placeholder="请输入分类名称"
                           value="<c:out value='${category.name}'/>" required>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label for="icon">图标</label>
                        <input type="text" id="icon" name="icon"
                               placeholder="例如：fas fa-rocket"
                               value="<c:out value='${category.icon}'/>">
                    </div>
                    <div class="form-group">
                        <label for="sortOrder">排序</label>
                        <input type="number" id="sortOrder" name="sortOrder"
                               placeholder="数字越小越靠前"
                               value="<c:out value='${category.sortOrder}'/>">
                    </div>
                </div>

                <div class="form-group">
                    <label for="description">描述</label>
                    <textarea id="description" name="description"
                              placeholder="请输入分类描述..."><c:out value="${category.description}"/></textarea>
                </div>

                <div class="form-group">
                    <label for="status">状态</label>
                    <select id="status" name="status">
                        <option value="1" <c:if test="${empty category || category.status == 1}">selected</c:if>>启用</option>
                        <option value="0" <c:if test="${category.status == 0}">selected</c:if>>禁用</option>
                    </select>
                </div>

                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/categories" class="btn btn-secondary">
                        <i class="fas fa-times"></i> 取消
                    </a>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-save"></i> 保存
                    </button>
                </div>
            </form>
        </div>
    </main>
</body>
</html>
