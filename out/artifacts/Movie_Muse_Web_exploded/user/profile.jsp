<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ taglib prefix="fn" uri="jakarta.tags.functions" %>
<%@ page import="org.example.entity.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>个人中心 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: url('../images/pawel-czerwinski-SawCLzAiew8-unsplash.jpg') center center / cover no-repeat;
            position: relative;
            min-height: 100vh;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.2);
            z-index: 0;
        }

        * {
            position: relative;
            z-index: 1;
        }

        .nav-container {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .logo {
            font-size: 24px;
            font-weight: 700;
            color: #ffffff;
            text-decoration: none;
            margin-right: 40px;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.9);
            text-decoration: none;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .nav-link:hover {
            color: #ffffff;
        }

        .main-content {
            padding: 6rem 8% 4rem 8%;
        }

        .profile-section {
            margin-bottom: 3rem;
        }

        .section-card {
            background: rgba(30, 37, 64, 0.6);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 2rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .section-title i {
            color: #a855f7;
        }

        .welcome-info {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1.5rem;
        }

        .info-card {
            background: rgba(255, 255, 255, 0.05);
            padding: 1.25rem;
            border-radius: 12px;
            border-left: 3px solid #a855f7;
        }

        .info-item {
            background: rgba(255, 255, 255, 0.05);
            padding: 1.25rem;
            border-radius: 12px;
            border-left: 3px solid #a855f7;
        }

        .info-item.double-height {
            grid-row: span 2;
        }

        .info-label {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
            margin-bottom: 0.5rem;
        }

        .info-value {
            color: #ffffff;
            font-size: 1.1rem;
            font-weight: 600;
        }

        .vip-badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 20px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-left: 0.5rem;
        }

        .vip-badge.vip {
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: #1f2937;
        }

        .vip-badge.normal {
            background: rgba(255, 255, 255, 0.2);
            color: rgba(255, 255, 255, 0.8);
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
            gap: 1.5rem;
        }

        .movie-card {
            background: rgba(30, 37, 64, 0.5);
            backdrop-filter: blur(6px);
            -webkit-backdrop-filter: blur(6px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            color: inherit;
            display: block;
        }

        .movie-card:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(138, 43, 226, 0.2);
        }

        .movie-card .card-poster {
            width: 100%;
            height: 260px;
            object-fit: cover;
        }

        .movie-card .card-info {
            padding: 1rem;
        }

        .movie-card .card-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #ffffff;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-card .card-meta {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin-bottom: 0.75rem;
        }

        .movie-card .card-rating {
            color: #fbbf24;
            font-size: 0.85rem;
        }

        .movie-card .card-views {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.5);
        }

        .movie-card .card-actions {
            display: flex;
            gap: 8px;
        }

        .movie-card .card-actions button {
            flex: 1;
            padding: 6px;
            border: none;
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.08);
            cursor: pointer;
            transition: all 0.2s ease;
            color: rgba(255, 255, 255, 0.6);
        }

        .movie-card .card-actions button:hover {
            background: rgba(255, 255, 255, 0.15);
            color: #ffffff;
        }

        .password-form {
            max-width: 500px;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.95rem;
            margin-bottom: 0.5rem;
        }

        .form-input {
            width: 100%;
            padding: 0.75rem 1rem;
            background: rgba(255, 255, 255, 0.08);
            border: 1px solid rgba(255, 255, 255, 0.15);
            border-radius: 10px;
            color: #ffffff;
            font-size: 1rem;
            outline: none;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            background: rgba(255, 255, 255, 0.12);
            border-color: rgba(168, 85, 247, 0.5);
            box-shadow: 0 0 0 3px rgba(168, 85, 247, 0.1);
        }

        .password-strength {
            margin-top: 0.75rem;
        }

        .strength-bar {
            height: 6px;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 3px;
            overflow: hidden;
            margin-bottom: 0.5rem;
        }

        .strength-fill {
            height: 100%;
            width: 0;
            transition: all 0.3s ease;
            border-radius: 3px;
        }

        .strength-text {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.5);
        }

        .strength-weak { background: #ef4444; width: 25%; }
        .strength-fair { background: #f59e0b; width: 50%; }
        .strength-good { background: #3b82f6; width: 75%; }
        .strength-strong { background: #10b981; width: 100%; }

        .btn-primary {
            padding: 0.875rem 2rem;
            background: linear-gradient(135deg, #666666, #999999);
            border: none;
            border-radius: 12px;
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.2);
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            grid-column: 1 / -1;
        }

        .empty-state i {
            font-size: 3rem;
            color: rgba(255, 255, 255, 0.2);
            margin-bottom: 1rem;
        }

        .empty-state p {
            color: rgba(255, 255, 255, 0.5);
        }

        .comment-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 1.5rem;
            border: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.3s ease;
        }

        .comment-item:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(168, 85, 247, 0.3);
        }

        .comment-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 1rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .comment-movie-info {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            cursor: pointer;
        }

        .comment-movie-poster {
            width: 40px;
            height: 60px;
            object-fit: cover;
            border-radius: 6px;
        }

        .comment-movie-title {
            color: #ffffff;
            font-weight: 600;
            font-size: 1rem;
        }

        .comment-meta {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.85rem;
        }

        .comment-content {
            color: rgba(255, 255, 255, 0.85);
            line-height: 1.6;
            margin-bottom: 1rem;
        }

        .comment-footer {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .comment-time {
            color: rgba(255, 255, 255, 0.4);
            font-size: 0.85rem;
        }

        .delete-comment-btn {
            background: rgba(239, 68, 68, 0.2);
            color: #ef4444;
            border: 1px solid rgba(239, 68, 68, 0.3);
            padding: 0.5rem 1rem;
            border-radius: 8px;
            font-size: 0.85rem;
            cursor: pointer;
            transition: all 0.3s ease;
            display: flex;
            align-items: center;
            gap: 0.5rem;
        }

        .delete-comment-btn:hover {
            background: rgba(239, 68, 68, 0.3);
            border-color: rgba(239, 68, 68, 0.5);
            transform: translateY(-2px);
        }

        .modal-overlay {
            position: fixed;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.75);
            backdrop-filter: blur(4px);
            z-index: 10000;
            display: none;
            align-items: center;
            justify-content: center;
        }

        .modal-overlay.active {
            display: flex;
        }

        .modal-content {
            background: linear-gradient(135deg, #1a1a2e, #16213e);
            border-radius: 16px;
            padding: 2rem;
            max-width: 400px;
            width: 90%;
            border: 1px solid rgba(255, 255, 255, 0.1);
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.5);
            animation: modalSlideIn 0.3s ease-out;
        }

        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-30px) scale(0.95);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }

        .modal-title {
            color: #ffffff;
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 1rem;
            display: flex;
            align-items: center;
            gap: 0.75rem;
        }

        .modal-title i {
            color: #ef4444;
        }

        .modal-message {
            color: rgba(255, 255, 255, 0.8);
            margin-bottom: 1.5rem;
            line-height: 1.6;
        }

        .modal-actions {
            display: flex;
            gap: 1rem;
            justify-content: flex-end;
        }

        .modal-cancel-btn {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.2);
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .modal-cancel-btn:hover {
            background: rgba(255, 255, 255, 0.15);
        }

        .modal-confirm-btn {
            background: linear-gradient(135deg, #ef4444, #dc2626);
            color: #ffffff;
            border: none;
            padding: 0.75rem 1.5rem;
            border-radius: 10px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .modal-confirm-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(239, 68, 68, 0.4);
        }

        .page-footer {
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }

        .page-footer .footer-links {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 1rem;
        }

        .page-footer .footer-links a {
            color: rgba(255, 255, 255, 0.4);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .page-footer .footer-links a:hover {
            color: #a855f7;
        }

        .page-footer p {
            color: rgba(255, 255, 255, 0.3);
            font-size: 0.85rem;
            margin: 0;
        }

        @media (max-width: 768px) {
            .movies-grid {
                grid-template-columns: repeat(auto-fill, minmax(150px, 1fr));
                gap: 1rem;
            }

            .movie-card .card-poster {
                height: 220px;
            }

            .welcome-info {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
    <nav class="fixed top-0 left-0 right-0 z-50" style="background: transparent; backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
        <div class="max-w-7xl mx-auto px-6 py-4">
            <div class="nav-container">
                <a href="${pageContext.request.contextPath}/user/index" class="logo">Movie-Muse</a>
                <div class="hidden md:flex items-center gap-8">
                    <a href="${pageContext.request.contextPath}/user/index" class="nav-link">首页</a>
                    <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link">电影分类</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                    <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
                </div>
                <button id="mobileMenuBtn" class="md:hidden text-white text-xl">
                    <i class="fas fa-bars"></i>
                </button>
            </div>

            <div id="mobileMenu" class="hidden md:hidden mt-4 pb-4 border-t border-white/10 pt-4">
                <div class="flex flex-col gap-4">
                    <a href="${pageContext.request.contextPath}/user/index" class="nav-link">首页</a>
                    <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link">电影分类</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                    <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
                </div>
            </div>
        </div>
    </nav>

    <main class="main-content">
        <section class="profile-section">
            <div class="section-card">
                <h2 class="section-title"><i class="fas fa-user-circle"></i> 欢迎回来</h2>
                <div class="welcome-info">
                    <div class="info-card double-height">
                        <div class="info-label">用户名</div>
                        <div class="info-value"><%= user.getUsername() %></div>
                    </div>
                    <div class="info-card double-height">
                        <div class="info-label">注册时间</div>
                        <div class="info-value"><fmt:formatDate value="${currentUser.createTime}" pattern="yyyy-MM-dd"/></div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">账户状态</div>
                        <div class="info-value" style="color: #10b981;">正常</div>
                    </div>
                    <div class="info-card">
                        <div class="info-label">用户身份</div>
                        <div class="info-value" style="display: flex; align-items: center;">
                            <span>普通用户</span>
                            <span class="vip-badge normal">普通用户</span>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="profile-section">
            <div class="section-card">
                <h2 class="section-title"><i class="fas fa-history"></i> 浏览记录 (<c:out value="${fn:length(viewHistories)}"/> 部)</h2>
                <div class="movies-grid">
                    <c:if test="${not empty viewHistories}">
                        <c:forEach items="${viewHistories}" var="vh">
                            <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${vh.movie.title}" class="movie-card">
                                <img src="${vh.movie.poster}" alt="${vh.movie.title}" class="card-poster" onerror="this.src='https://picsum.photos/200/260?random=${vh.movie.id}'">
                                <div class="card-info">
                                    <h3 class="card-title">${vh.movie.title}</h3>
                                    <div class="card-meta">
                                        <span class="card-rating">★★★★★ <fmt:formatNumber value="${vh.movie.rating}" pattern="#.#"/></span>
                                    </div>
                                    <div class="card-meta" style="margin-top: 0.5rem; color: rgba(255,255,255,0.5); font-size: 0.8rem;">
                                        <i class="far fa-clock"></i> <fmt:formatDate value="${vh.viewTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty viewHistories}">
                        <div class="empty-state">
                            <i class="fas fa-film"></i>
                            <p>暂无浏览记录</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <section class="profile-section">
            <div class="section-card">
                <h2 class="section-title"><i class="fas fa-heart"></i> 我的收藏 (<c:out value="${fn:length(favorites)}"/> 部)</h2>
                <div class="movies-grid">
                    <c:if test="${not empty favorites}">
                        <c:forEach items="${favorites}" var="fav">
                            <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${fav.movie.title}" class="movie-card">
                                <img src="${fav.movie.poster}" alt="${fav.movie.title}" class="card-poster" onerror="this.src='https://picsum.photos/200/260?random=${fav.movie.id}'">
                                <div class="card-info">
                                    <h3 class="card-title">${fav.movie.title}</h3>
                                    <div class="card-meta">
                                        <span class="card-rating">★★★★★ <fmt:formatNumber value="${fav.movie.rating}" pattern="#.#"/></span>
                                    </div>
                                    <div class="card-actions">
                                        <button title="查看详情">
                                            <i class="fas fa-eye"></i>
                                        </button>
                                        <button title="取消收藏" onclick="removeFavorite(${fav.movie.id}, this)">
                                            <i class="fas fa-trash-alt"></i>
                                        </button>
                                    </div>
                                </div>
                            </a>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty favorites}">
                        <div class="empty-state">
                            <i class="fas fa-heart-broken"></i>
                            <p>暂无收藏的电影</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <section class="profile-section">
            <div class="section-card">
                <h2 class="section-title"><i class="fas fa-comment-dots"></i> 我的评论 (<c:out value="${fn:length(comments)}"/> 条)</h2>
                <div id="my-comments-list" class="space-y-4">
                    <c:if test="${not empty comments}">
                        <c:forEach items="${comments}" var="comment">
                            <div class="comment-item">
                                <div class="comment-header">
                                    <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${comment.movie.title}" class="comment-movie-info">
                                        <img src="${comment.movie.poster}" alt="${comment.movie.title}" class="comment-movie-poster" onerror="this.src='https://picsum.photos/40/60?random=${comment.movie.id}'">
                                        <div>
                                            <div class="comment-movie-title">${comment.movie.title}</div>
                                            <div class="comment-meta">用户：${comment.user.username}</div>
                                        </div>
                                    </a>
                                </div>
                                <div class="comment-content">
                                    ${comment.content}
                                </div>
                                <div class="comment-footer">
                                    <span class="comment-time"><fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                    <button class="delete-comment-btn" onclick="deleteComment(${comment.id}, this)">
                                        <i class="fas fa-trash-alt"></i> 删除
                                    </button>
                                </div>
                            </div>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty comments}">
                        <div class="empty-state" style="padding: 2rem;">
                            <i class="fas fa-comment-slash" style="font-size: 2.5rem; margin-bottom: 1rem;"></i>
                            <p style="color: rgba(255, 255, 255, 0.5);">暂无评论</p>
                        </div>
                    </c:if>
                </div>
            </div>
        </section>

        <section class="profile-section">
            <div class="section-card">
                <h2 class="section-title"><i class="fas fa-lock"></i> 修改密码</h2>
                <form class="password-form" id="passwordForm">
                    <div class="form-group">
                        <label class="form-label">当前密码</label>
                        <input type="password" class="form-input" id="oldPassword" placeholder="请输入当前密码" required>
                    </div>

                    <div class="form-group">
                        <label class="form-label">新密码</label>
                        <input type="password" class="form-input" id="newPassword" placeholder="请输入新密码" required>
                        <div class="password-strength">
                            <div class="strength-bar">
                                <div class="strength-fill" id="strengthBar"></div>
                            </div>
                            <div class="strength-text" id="strengthText">密码强度</div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">确认新密码</label>
                        <input type="password" class="form-input" id="confirmPassword" placeholder="请再次输入新密码" required>
                    </div>

                    <button type="submit" class="btn-primary">修改密码</button>
                </form>
            </div>
        </section>
    </main>

    <footer class="page-footer">
        <div class="footer-links">
            <a href="#">关于我们</a>
            <a href="#">隐私政策</a>
            <a href="#">服务条款</a>
            <a href="#">联系我们</a>
        </div>
        <p>&copy; 2024 Movie-Muse. All rights reserved.</p>
    </footer>

    <div id="deleteConfirmModal" class="modal-overlay">
        <div class="modal-content">
            <div class="modal-title">
                <i class="fas fa-exclamation-triangle"></i>
                确认删除
            </div>
            <div class="modal-message">
                您确定要删除吗？此操作不可恢复。
            </div>
            <div class="modal-actions">
                <button class="modal-cancel-btn" id="cancelDeleteBtn">
                    <i class="fas fa-times"></i> 取消
                </button>
                <button class="modal-confirm-btn" id="confirmDeleteBtn">
                    <i class="fas fa-trash-alt"></i> 删除
                </button>
            </div>
        </div>
    </div>

    <script src="../js/auth.js"></script>
    <script>
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');
        
        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });
        }

        const newPassword = document.getElementById('newPassword');
        const strengthBar = document.getElementById('strengthBar');
        const strengthText = document.getElementById('strengthText');

        newPassword.addEventListener('input', () => {
            const password = newPassword.value;
            let strength = 0;

            if (password.length >= 8) strength++;
            if (password.match(/[a-z]/) && password.match(/[A-Z]/)) strength++;
            if (password.match(/[0-9]/)) strength++;
            if (password.match(/[^a-zA-Z0-9]/)) strength++;

            strengthBar.className = 'strength-fill';
            if (strength === 0) {
                strengthText.textContent = '密码强度';
                strengthText.style.color = 'rgba(255, 255, 255, 0.5)';
            } else if (strength <= 1) {
                strengthBar.classList.add('strength-weak');
                strengthText.textContent = '弱';
                strengthText.style.color = '#ef4444';
            } else if (strength === 2) {
                strengthBar.classList.add('strength-fair');
                strengthText.textContent = '中等';
                strengthText.style.color = '#f59e0b';
            } else if (strength === 3) {
                strengthBar.classList.add('strength-good');
                strengthText.textContent = '强';
                strengthText.style.color = '#3b82f6';
            } else {
                strengthBar.classList.add('strength-strong');
                strengthText.textContent = '非常强';
                strengthText.style.color = '#10b981';
            }
        });

        document.getElementById('passwordForm').addEventListener('submit', (e) => {
            e.preventDefault();
            const oldPassword = document.getElementById('oldPassword').value;
            const newPassword = document.getElementById('newPassword').value;
            const confirmPassword = document.getElementById('confirmPassword').value;
            
            if (newPassword !== confirmPassword) {
                alert('两次输入的密码不一致！');
                return;
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', '${pageContext.request.contextPath}/user/change-password', true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const response = JSON.parse(xhr.responseText);
                    if (response.success) {
                        alert('密码修改成功！');
                        e.target.reset();
                        strengthBar.className = 'strength-fill';
                        strengthText.textContent = '密码强度';
                        strengthText.style.color = 'rgba(255, 255, 255, 0.5)';
                    } else {
                        alert(response.message || '密码修改失败');
                    }
                }
            };
            xhr.send('oldPassword=' + encodeURIComponent(oldPassword) + '&newPassword=' + encodeURIComponent(newPassword));
        });

        let deleteType = null;
        let deleteId = null;
        let deleteBtnElement = null;

        function removeFavorite(movieId, btn) {
            deleteType = 'favorite';
            deleteId = movieId;
            deleteBtnElement = btn;
            document.getElementById('deleteConfirmModal').classList.add('active');
        }

        function deleteComment(commentId, btn) {
            deleteType = 'comment';
            deleteId = commentId;
            deleteBtnElement = btn;
            document.getElementById('deleteConfirmModal').classList.add('active');
        }

        function hideDeleteModal() {
            document.getElementById('deleteConfirmModal').classList.remove('active');
            deleteType = null;
            deleteId = null;
            deleteBtnElement = null;
        }

        function confirmDelete() {
            if (!deleteType || deleteId === null) return;
            
            let url = '';
            if (deleteType === 'favorite') {
                url = '${pageContext.request.contextPath}/api/favorite';
            } else if (deleteType === 'comment') {
                url = '${pageContext.request.contextPath}/user/comment/delete';
            }
            
            const xhr = new XMLHttpRequest();
            xhr.open('POST', url, true);
            xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
            xhr.onload = function() {
                if (xhr.status === 200) {
                    const card = deleteBtnElement.closest('.movie-card') || deleteBtnElement.closest('.comment-item');
                    if (card) {
                        card.style.transform = 'scale(0.9)';
                        card.style.opacity = '0';
                        setTimeout(() => {
                            card.remove();
                        }, 300);
                    }
                }
                hideDeleteModal();
            };
            
            if (deleteType === 'favorite') {
                xhr.send('movieId=' + deleteId + '&action=remove');
            } else if (deleteType === 'comment') {
                xhr.send('id=' + deleteId);
            }
        }

        document.getElementById('cancelDeleteBtn').addEventListener('click', hideDeleteModal);
        document.getElementById('confirmDeleteBtn').addEventListener('click', confirmDelete);
        document.getElementById('deleteConfirmModal').addEventListener('click', (e) => {
            if (e.target === document.getElementById('deleteConfirmModal')) {
                hideDeleteModal();
            }
        });
    </script>
</body>
</html>
