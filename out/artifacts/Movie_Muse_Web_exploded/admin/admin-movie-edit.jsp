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
    <title><c:choose><c:when test="${editMode}">编辑电影</c:when><c:otherwise>添加电影</c:otherwise></c:choose> - Movie-Muse</title>
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
            background: url('../images/mark-basarab-1OtUkD_8svc-unsplash.jpg') center center / cover no-repeat;
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

        .sidebar-nav li { margin-bottom: 4px; }

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

        .sidebar-nav a.active i { color: #a855f7; }

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

        .top-nav .nav-left a:hover { color: var(--primary-color); }

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
            display: flex;
            justify-content: center;
            align-items: flex-start;
        }

        .form-card {
            width: 100%;
            max-width: 700px;
            background: white;
            border-radius: 16px;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
            padding: 2.5rem;
        }

        .form-card h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: var(--text-primary);
            margin-bottom: 2rem;
            padding-bottom: 1rem;
            border-bottom: 1px solid var(--border-color);
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-row {
            display: flex;
            gap: 1.5rem;
        }

        .form-row .form-group { flex: 1; }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.95rem;
        }

        .form-group input[type="text"],
        .form-group input[type="url"],
        .form-group input[type="number"],
        .form-group select,
        .form-group textarea {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            font-family: inherit;
            color: var(--text-primary);
            background: white;
            transition: all 0.3s ease;
        }

        .form-group input:focus,
        .form-group select:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(147, 51, 234, 0.1);
        }

        .form-group textarea {
            resize: vertical;
            min-height: 120px;
            line-height: 1.6;
        }

        .form-group .hint {
            font-size: 0.85rem;
            color: var(--text-secondary);
            margin-top: 0.35rem;
        }

        .checkbox-group {
            display: flex;
            flex-wrap: wrap;
            gap: 12px;
            margin-top: 0.5rem;
        }

        .checkbox-item {
            display: flex;
            align-items: center;
            gap: 6px;
            padding: 8px 14px;
            background: white;
            border: 2px solid var(--border-color);
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            user-select: none;
        }

        .checkbox-item:hover {
            border-color: var(--primary-color);
        }

        .checkbox-item input[type="checkbox"] {
            width: 16px;
            height: 16px;
            accent-color: var(--primary-color);
            cursor: pointer;
        }

        .checkbox-item.checked {
            border-color: var(--primary-color);
            background: rgba(147, 51, 234, 0.05);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
            margin-top: 2rem;
            padding-top: 1.5rem;
            border-top: 1px solid var(--border-color);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            gap: 8px;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            font-size: 1rem;
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

        .btn-secondary {
            background: rgba(107, 114, 128, 0.1);
            color: var(--text-secondary);
            border: 2px solid var(--border-color);
        }

        .btn-secondary:hover {
            background: rgba(107, 114, 128, 0.2);
            color: var(--text-primary);
        }

        .error-msg {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .success-msg {
            background: #d1fae5;
            color: #065f46;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
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

            .main-content { margin-left: 0; }
            .page-content { padding: 1rem; }
            .form-card { padding: 1.5rem; }
            .form-row { flex-direction: column; gap: 1rem; }
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
            <div class="nav-left">
                <a href="${pageContext.request.contextPath}/admin/movies">
                    <i class="fas fa-arrow-left"></i> 返回列表
                </a>
            </div>
            <div class="nav-right">
                <div class="user-info">
                    <div class="user-avatar">${currentAdmin.username.substring(0, 1).toUpperCase()}</div>
                    <span class="user-name">${currentAdmin.username}</span>
                </div>
            </div>
        </header>

        <!-- Page Content -->
        <main class="page-content">
            <div class="form-card">
                <h1>
                    <c:choose>
                        <c:when test="${editMode}">编辑电影</c:when>
                        <c:otherwise>添加新电影</c:otherwise>
                    </c:choose>
                </h1>

                <c:if test="${not empty errorMessage}">
                    <div class="error-msg">
                        <i class="fas fa-exclamation-circle"></i>
                        ${errorMessage}
                    </div>
                </c:if>

                <form id="movieForm" action="${pageContext.request.contextPath}/admin/movie-edit" method="post">
                    <c:if test="${editMode && not empty movie}">
                        <input type="hidden" name="id" value="${movie.id}">
                    </c:if>

                    <!-- Title -->
                    <div class="form-group">
                        <label for="title">电影标题 <span style="color: #ef4444;">*</span></label>
                        <input type="text" id="title" name="title"
                               placeholder="请输入电影标题"
                               value="<c:out value='${movie.title}'/>"
                               required>
                    </div>

                    <!-- Poster URL & Year -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="poster">海报链接</label>
                            <input type="url" id="poster" name="poster"
                                   placeholder="https://..."
                                   value="<c:out value='${movie.poster}'/>">
                            <div class="hint">建议尺寸: 300×450px</div>
                        </div>
                        <div class="form-group">
                            <label for="releaseYear">上映年份</label>
                            <input type="number" id="releaseYear" name="releaseYear"
                                   min="1900" max="2099"
                                   placeholder="2024"
                                   value="<c:out value='${movie.releaseYear}'/>">
                        </div>
                    </div>

                    <!-- Director & Runtime -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="director">导演</label>
                            <input type="text" id="director" name="director"
                                   placeholder="请输入导演姓名"
                                   value="<c:out value='${movie.director}'/>">
                        </div>
                        <div class="form-group">
                            <label for="runtime">片长（分钟）</label>
                            <input type="number" id="runtime" name="runtime"
                                   min="1"
                                   placeholder="120"
                                   value="<c:out value='${movie.runtime}'/>">
                        </div>
                    </div>

                    <!-- Video URL -->
                    <div class="form-group">
                        <label for="videoUrl">视频 URL / 嵌入代码</label>
                        <input type="text" id="videoUrl" name="videoUrl"
                               placeholder="粘贴视频地址或 B 站等 iframe 嵌入代码"
                               value="<c:out value='${movie.videoUrl}'/>">
                        <small style="color: rgba(255,255,255,0.5); display: block; margin-top: 6px;">
                            填写后系统会自动将该电影设为免费；留空则视为付费/无片源。
                        </small>
                    </div>

                    <!-- Description -->
                    <div class="form-group">
                        <label for="description">简介</label>
                        <textarea id="description" name="description"
                                  placeholder="请输入电影简介..."><c:out value="${movie.description}"/></textarea>
                    </div>

                    <!-- Rating -->
                    <div class="form-row">
                        <div class="form-group">
                            <label for="rating">评分</label>
                            <input type="number" id="rating" name="rating"
                                   min="0" max="10" step="0.1"
                                   placeholder="0.0 - 10.0"
                                   value="<c:out value='${movie.rating}'/>">
                        </div>
                        <div class="form-group">
                            <label for="viewCount">播放次数</label>
                            <input type="number" id="viewCount" name="viewCount"
                                   min="0"
                                   placeholder="0"
                                   value="<c:out value='${movie.viewCount}'/>">
                        </div>
                    </div>

                    <!-- Status -->
                    <div class="form-group">
                        <label for="status">状态</label>
                        <select id="status" name="status">
                            <option value="1" <c:if test="${empty movie || movie.status == 1}">selected</c:if>>上架</option>
                            <option value="0" <c:if test="${movie.status == 0}">selected</c:if>>下架</option>
                        </select>
                    </div>

                    <!-- Categories -->
                    <div class="form-group">
                        <label>所属分类</label>
                        <div class="checkbox-group">
                            <c:forEach items="${categories}" var="cat">
                                <c:set var="isSelected" value="false"/>
                                <c:forEach items="${selectedCategoryIds}" var="selectedId">
                                    <c:if test="${selectedId == cat.id}">
                                        <c:set var="isSelected" value="true"/>
                                    </c:if>
                                </c:forEach>
                                <label class="checkbox-item ${isSelected ? 'checked' : ''}">
                                    <input type="checkbox" name="categoryIds" value="${cat.id}"
                                           <c:if test="${isSelected}">checked</c:if>>
                                    <c:choose>
                                        <c:when test="${not empty cat.icon}">
                                            <i class="${cat.icon}" style="color: #9333ea;"></i>
                                        </c:when>
                                        <c:otherwise>
                                            <i class="fas fa-tag" style="color: #9333ea;"></i>
                                        </c:otherwise>
                                    </c:choose>
                                    <span><c:out value="${cat.name}"/></span>
                                </label>
                            </c:forEach>
                        </div>
                        <c:if test="${empty categories}">
                            <p class="hint">暂无可用分类，请先到<a href="${pageContext.request.contextPath}/admin/categories">分类管理</a>添加。</p>
                        </c:if>
                    </div>

                    <!-- Actions -->
                    <div class="form-actions">
                        <a href="${pageContext.request.contextPath}/admin/movies" class="btn btn-secondary">
                            <i class="fas fa-times"></i> 取消
                        </a>
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 保存
                        </button>
                    </div>
                </form>
            </div>
        </main>
    </div>

    <script>
        document.querySelectorAll('.checkbox-item input[type="checkbox"]').forEach(function(checkbox) {
            checkbox.addEventListener('change', function() {
                this.closest('.checkbox-item').classList.toggle('checked', this.checked);
            });
        });
    </script>
</body>
</html>
