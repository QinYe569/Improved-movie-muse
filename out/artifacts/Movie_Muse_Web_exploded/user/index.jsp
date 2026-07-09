<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
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
    <title>Movie-Muse - 发现你的下一部挚爱电影</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    colors: {
                        dark: {
                            base: '#141414',
                            card: '#1a1a2e',
                            border: '#2a2a3a',
                        }
                    }
                }
            }
        }
    </script>
    <style>
        @import url('https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap');

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #141414;
            min-height: 100vh;
            overflow-x: hidden;
            margin: 0;
            padding: 0;
        }

        /* ===== Navbar ===== */
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

        /* ===== Hero Banner ===== */
        .hero-banner {
            position: relative;
            width: 100vw;
            height: 80vh;
            min-height: 500px;
            overflow: hidden;
            margin: 0;
            margin-left: calc(-50vw + 50%);
            margin-right: calc(-50vw + 50%);
            left: 0;
        }

        .hero-banner::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('${pageContext.request.contextPath}/images/hero-bg.jpg') center center / cover no-repeat;
            background-color: #1a1a2e;
            z-index: 0;
        }

        .hero-banner::after {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background:
                linear-gradient(
                    to bottom,
                    rgba(0, 0, 0, 0.2) 0%,
                    rgba(0, 0, 0, 0.05) 30%,
                    rgba(0, 0, 0, 0.1) 50%,
                    rgba(0, 0, 0, 0.5) 75%,
                    rgba(0, 0, 0, 0.85) 100%
                );
            z-index: 1;
        }

        .hero-content {
            position: relative;
            z-index: 2;
            height: 100%;
            display: flex;
            flex-direction: column;
            justify-content: flex-end;
            align-items: center;
            text-align: center;
            padding: 0 20px 20px 20px;
            max-width: 1400px;
            margin: 0 auto;
        }

        .hero-title {
            font-size: 3.5rem;
            font-weight: 800;
            line-height: 1.1;
            color: #ffffff;
            margin-bottom: 1rem;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.8);
            letter-spacing: 2px;
            max-width: 700px;
        }

        .hero-subtitle {
            font-size: 1.15rem;
            color: rgba(255, 255, 255, 0.7);
            margin-bottom: 2rem;
            max-width: 500px;
            text-shadow: 0 2px 10px rgba(0, 0, 0, 0.5);
        }

        /* ===== Search Panel ===== */
        .hero-search-panel {
            padding: 24px 28px;
            background: rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            width: 95%;
            max-width: 1100px;
            min-width: 400px;
        }

        .hero-search {
            display: flex;
            gap: 12px;
            margin-bottom: 16px;
        }

        .hero-search-wrapper {
            position: relative;
            flex: 1;
        }

        .hero-search-wrapper .search-icon {
            position: absolute;
            left: 22px;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.4);
            font-size: 1.3rem;
            pointer-events: none;
        }

        .hero-search-input {
            width: 100%;
            height: 75px;
            padding: 0 24px 0 55px;
            border: none;
            border-radius: 12px;
            background: rgba(255, 255, 255, 0.15);
            backdrop-filter: blur(10px);
            -webkit-backdrop-filter: blur(10px);
            color: #ffffff;
            font-size: 18px;
            outline: none;
            transition: all 0.3s ease;
        }

        .hero-search-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .hero-search-input:focus {
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 0 0 3px rgba(255, 255, 255, 0.3);
        }

        .hero-search-btn {
            height: 75px;
            padding: 0 48px;
            background: linear-gradient(135deg, #555555, #888888);
            border: none;
            border-radius: 12px;
            color: #ffffff;
            font-weight: 600;
            font-size: 18px;
            cursor: pointer;
            transition: all 0.3s ease;
            white-space: nowrap;
        }

        .hero-search-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 25px rgba(255, 255, 255, 0.2);
        }

        .hero-tags {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 10px;
        }

        .hero-tag {
            padding: 8px 20px;
            border-radius: 24px;
            background: rgba(255, 255, 255, 0.12);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.15);
            color: rgba(255, 255, 255, 0.8);
            font-size: 0.9rem;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.2s ease;
        }

        .hero-tag:hover,
        .hero-tag.active {
            background: rgba(255, 255, 255, 0.25);
            border-color: rgba(255, 255, 255, 0.4);
            color: #ffffff;
        }

        /* ===== Content Sections ===== */
        .content-sections {
            background-color: #141414;
            padding: 0 8% 3rem 8%;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 1.5rem;
        }

        .section-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: #ffffff;
            position: relative;
            padding-left: 16px;
        }

        .section-title::before {
            content: '';
            position: absolute;
            left: 0;
            top: 50%;
            transform: translateY(-50%);
            width: 4px;
            height: 70%;
            background: linear-gradient(180deg, #ffffff, #ffffff);
            border-radius: 2px;
        }

        .section-link {
            color: rgba(255, 255, 255, 0.6);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 500;
            transition: color 0.2s ease;
        }

        .section-link:hover {
            color: #ffffff;
        }

        .movie-section {
            margin-bottom: 60px;
        }

        .movies-row {
            display: flex;
            gap: 30px;
            overflow-x: auto;
            padding-bottom: 1rem;
            padding-top: 0.5rem;
            scroll-snap-type: x mandatory;
            -ms-overflow-style: none;
            scrollbar-width: none;
        }

        .movies-row::-webkit-scrollbar {
            display: none;
        }

        .movie-card {
            flex: 0 0 180px;
            scroll-snap-align: start;
            background: rgba(30, 30, 50, 0.6);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .movie-card:hover {
            transform: translateY(-8px) scale(1.03);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
        }

        .movie-card .poster-wrap {
            position: relative;
            aspect-ratio: 2/3;
            overflow: hidden;
        }

        .movie-card .poster-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .movie-card:hover .poster-wrap img {
            transform: scale(1.08);
        }

        .movie-card .rating-badge {
            position: absolute;
            top: 8px;
            right: 8px;
            background: rgba(250, 204, 21, 0.9);
            color: #1a1a1a;
            padding: 4px 8px;
            border-radius: 6px;
            font-size: 0.75rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 3px;
        }

        .movie-card .card-info {
            padding: 12px;
        }

        .movie-card .card-title {
            font-weight: 600;
            color: #ffffff;
            font-size: 0.9rem;
            margin-bottom: 4px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-card .card-meta {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.7);
        }

        /* ===== Footer ===== */
        .site-footer {
            background: rgba(20, 20, 20, 0.95);
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding: 2rem 5%;
            text-align: center;
        }

        .site-footer .footer-links {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 1rem;
            flex-wrap: wrap;
        }

        .site-footer .footer-links a {
            color: rgba(255, 255, 255, 0.5);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.2s ease;
        }

        .site-footer .footer-links a:hover {
            color: #ffffff;
        }

        .site-footer p {
            color: rgba(255, 255, 255, 0.4);
            font-size: 0.85rem;
        }

        /* ===== Responsive ===== */
        @media (max-width: 768px) {
            .hero-banner {
                height: 70vh;
            }

            .hero-title {
                font-size: 2rem;
            }

            .hero-subtitle {
                font-size: 1rem;
            }

            .hero-search-panel {
                width: 95%;
                min-width: unset;
            }

            .hero-search {
                flex-direction: column;
            }

            .hero-search-input {
                width: 100%;
                height: 60px;
                font-size: 16px;
                padding: 0 18px 0 45px;
            }

            .hero-search-btn {
                width: 100%;
                height: 60px;
                font-size: 16px;
            }

            .hero-search-wrapper .search-icon {
                font-size: 1.1rem;
                left: 16px;
            }

            .content-sections {
                padding: 2rem 4%;
            }

            .movies-row {
                gap: 16px;
            }

            .movie-card {
                flex: 0 0 150px;
            }

            .movie-section {
                margin-bottom: 40px;
            }

            .logo {
                font-size: 20px;
                margin-right: 20px;
            }
        }

        @media (max-width: 480px) {
            .hero-title {
                font-size: 1.6rem;
            }

            .hero-search-panel {
                width: 98%;
                padding: 16px;
            }

            .hero-search-input {
                height: 50px;
                font-size: 14px;
                padding: 0 15px 0 40px;
            }

            .hero-search-btn {
                height: 50px;
                font-size: 14px;
            }

            .hero-search-wrapper .search-icon {
                font-size: 1rem;
                left: 14px;
            }
        }

        @keyframes pulse-gold {
            0%, 100% {
                box-shadow: 0 10px 40px rgba(251, 191, 36, 0.4);
            }
            50% {
                box-shadow: 0 15px 50px rgba(251, 191, 36, 0.6);
            }
        }

        /* 公告弹窗动画 */
        @keyframes modalSlideIn {
            from {
                opacity: 0;
                transform: translateY(-50px) scale(0.9);
            }
            to {
                opacity: 1;
                transform: translateY(0) scale(1);
            }
        }
    </style>
</head>
<body>

<!-- Navigation -->
<nav class="fixed top-0 left-0 right-0 z-50" style="background: transparent; backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
    <div class="max-w-7xl mx-auto px-6 py-4">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/user/index" class="logo">Movie-Muse</a>
            <div class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/user/index" class="nav-link text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link text-white hover:text-white/80 transition-colors">个人中心</a>
                <!-- 已登录状态显示用户名 -->
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30" id="navUsername"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white text-xl" aria-label="菜单">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div id="mobileMenu" class="hidden md:hidden mt-4 pb-4 border-t border-white/10 pt-4">
            <div class="flex flex-col gap-4">
                <a href="${pageContext.request.contextPath}/user/index" class="nav-link text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link text-white hover:text-white/80 transition-colors">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30" id="mobileNavUsername"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
        </div>
    </div>
</nav>

<!-- Hero Banner -->
<section class="hero-banner">
    <div class="hero-content">
        <h1 class="hero-title">发现你的下一部<br>挚爱电影</h1>
        <p class="hero-subtitle">探索数千部电影，找到属于你的那一部</p>

        <div class="hero-search-panel">
            <div class="hero-search">
                <div class="hero-search-wrapper">
                    <i class="fas fa-search search-icon"></i>
                    <input type="text" class="hero-search-input" placeholder="搜索电影、导演、演员..." id="searchInput">
                </div>
                <button class="hero-search-btn" onclick="performSearch()">搜索</button>
            </div>
        </div>
    </div>
</section>

<!-- Content Sections -->
<main class="content-sections">

    <!-- 最新上映 -->
    <c:if test="${not empty latestMovies}">
        <section class="movie-section">
            <div class="section-header">
                <h2 class="section-title">最新上映</h2>
                <a href="${pageContext.request.contextPath}/user/movie-list" class="section-link">查看全部 <i class="fas fa-chevron-right text-xs"></i></a>
            </div>
            <div class="movies-row">
                <c:forEach items="${latestMovies}" var="movie">
                    <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                        <div class="poster-wrap">
                            <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='https://picsum.photos/300/450?random=${movie.id}'">
                            <c:if test="${not empty movie.rating}">
                                <div class="rating-badge"><i class="fas fa-star"></i> <fmt:formatNumber value="${movie.rating}" pattern="#.#"/></div>
                            </c:if>
                        </div>
                        <div class="card-info">
                            <h3 class="card-title">${movie.title}</h3>
                            <p class="card-meta">${movie.releaseYear}</p>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>
    </c:if>

    <!-- 猜你喜欢 -->
    <c:if test="${not empty recommendMovies}">
        <section class="movie-section">
            <div class="section-header">
                <h2 class="section-title">猜你喜欢</h2>
                <a href="${pageContext.request.contextPath}/user/movie-list" class="section-link">查看全部 <i class="fas fa-chevron-right text-xs"></i></a>
            </div>
            <div class="movies-row">
                <c:forEach items="${recommendMovies}" var="movie">
                    <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                        <div class="poster-wrap">
                            <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='https://picsum.photos/300/450?random=${movie.id}'">
                            <c:if test="${not empty movie.rating}">
                                <div class="rating-badge"><i class="fas fa-star"></i> <fmt:formatNumber value="${movie.rating}" pattern="#.#"/></div>
                            </c:if>
                        </div>
                        <div class="card-info">
                            <h3 class="card-title">${movie.title}</h3>
                            <p class="card-meta">${movie.releaseYear}</p>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </section>
    </c:if>

    <!-- 限时免费专区按钮 -->
    <div style="text-align: center; margin: 60px 0 30px;">
        <a href="${pageContext.request.contextPath}/user/free-zone" style="
            display: inline-block;
            padding: 18px 56px;
            background: linear-gradient(135deg, #fbbf24 0%, #f59e0b 100%);
            color: #1f2937;
            text-decoration: none;
            border-radius: 30px;
            font-size: 20px;
            font-weight: 700;
            letter-spacing: 1px;
            box-shadow: 0 10px 40px rgba(251, 191, 36, 0.4);
            transition: all 0.3s ease;
            animation: pulse-gold 2s ease-in-out infinite;
        " onmouseover="this.style.transform='translateY(-3px) scale(1.05)'; this.style.boxShadow='0 15px 50px rgba(251, 191, 36, 0.6)'" onmouseout="this.style.transform='translateY(0) scale(1)'; this.style.boxShadow='0 10px 40px rgba(251, 191, 36, 0.4)'">
            <i class="fas fa-crown" style="margin-right: 12px;"></i>限时免费专区
        </a>
    </div>

    <style>
        @keyframes pulse-gold {
            0%, 100% {
                box-shadow: 0 10px 40px rgba(251, 191, 36, 0.4);
            }
            50% {
                box-shadow: 0 15px 50px rgba(251, 191, 36, 0.6);
            }
        }
    </style>

    <!-- 查看更多电影按钮 -->
    <div style="text-align: center; margin: 30px 0 40px;">
        <a href="${pageContext.request.contextPath}/user/movie-list" style="
            display: inline-block;
            padding: 16px 48px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: #ffffff;
            text-decoration: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            letter-spacing: 1px;
            box-shadow: 0 10px 30px rgba(102, 126, 234, 0.4);
            transition: all 0.3s ease;
        " onmouseover="this.style.transform='translateY(-3px)'; this.style.boxShadow='0 15px 40px rgba(102, 126, 234, 0.6)'" onmouseout="this.style.transform='translateY(0)'; this.style.boxShadow='0 10px 30px rgba(102, 126, 234, 0.4)'">
            <i class="fas fa-film" style="margin-right: 10px;"></i>查看更多电影
        </a>
    </div>

</main>

<!-- Footer -->
<footer class="site-footer">
    <div class="footer-links">
        <a href="#">关于我们</a>
        <a href="#">联系我们</a>
        <a href="#">隐私政策</a>
        <a href="#">用户协议</a>
    </div>
    <p>&copy; 2024 Movie-Muse. All rights reserved.</p>
</footer>

<!-- 公告弹窗 -->
<div id="announcement-modal" class="fixed inset-0 bg-black bg-opacity-75 backdrop-blur-sm z-[10000] flex items-center justify-center" style="display: none;">
    <div class="relative bg-gradient-135deg from-[#1a1a2e] to-[#16213e] rounded-2xl w-1/2 max-w-4xl max-h-[80vh] overflow-y-auto shadow-2xl border border-white/10" style="animation: modalSlideIn 0.3s ease-out;">
        <!-- 关闭按钮 -->
        <button id="close-announcement" class="absolute top-4 right-4 text-white/60 hover:text-white transition-colors text-2xl font-bold w-10 h-10 flex items-center justify-center rounded-full hover:bg-white/10 z-10">
            ×
        </button>
        
        <!-- 公告内容 -->
        <div class="p-10">
            <!-- 标题 -->
            <div class="text-center mb-8">
                <h2 class="text-3xl font-bold bg-gradient-135deg from-purple-400 to-pink-400 bg-clip-text text-transparent mb-3">
                    🎉 系统公告
                </h2>
                <p class="text-white/60 text-lg">最新动态与重要通知</p>
            </div>

            <!-- 公告列表 -->
            <div class="space-y-6 mb-8">
                <c:choose>
                    <c:when test="${not empty announcements}">
                        <c:forEach items="${announcements}" var="ann">
                            <div class="bg-white/5 rounded-xl p-6 border border-white/10">
                                <div class="flex items-center justify-between mb-3 flex-wrap gap-2">
                                    <h3 class="text-xl font-semibold text-purple-300">${ann.title}</h3>
                                    <span class="text-white/40 text-sm">
                                        <fmt:formatDate value="${ann.publishTime}" pattern="yyyy-MM-dd HH:mm"/>
                                    </span>
                                </div>
                                <p class="text-white/80 leading-relaxed whitespace-pre-wrap">${ann.content}</p>
                            </div>
                        </c:forEach>
                    </c:when>
                    <c:otherwise>
                        <div class="text-center py-10 text-white/60">
                            <i class="fas fa-inbox text-4xl mb-4 block"></i>
                            暂无公告
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>

            <!-- 底部按钮 -->
            <div class="text-center pt-6 border-t border-white/10">
                <button id="got-it-btn" class="bg-gradient-135deg from-purple-500 to-pink-500 hover:from-purple-600 hover:to-pink-600 text-white font-semibold py-3 px-10 rounded-full transition-all transform hover:scale-105 shadow-lg hover:shadow-purple-500/50">
                    我知道了
                </button>
            </div>
        </div>
    </div>
</div>

<!-- JavaScript -->
<script src="${pageContext.request.contextPath}/js/auth.js"></script>
<script src="${pageContext.request.contextPath}/js/vip-system.js"></script>
<script>
    // 公告系统
    const AnnouncementSystem = {
        init: function() {
            this.show();
            this.setupEventListeners();
        },
        
        show: function() {
            const modal = document.getElementById('announcement-modal');
            if (modal) {
                modal.style.display = 'flex';
                document.body.style.overflow = 'hidden'; // 禁止背景滚动
            }
        },
        
        hide: function() {
            const modal = document.getElementById('announcement-modal');
            if (modal) {
                modal.style.display = 'none';
                document.body.style.overflow = ''; // 恢复滚动
            }
        },
        
        setupEventListeners: function() {
            // 关闭按钮
            const closeBtn = document.getElementById('close-announcement');
            if (closeBtn) {
                closeBtn.addEventListener('click', () => {
                    this.hide();
                });
            }
            
            // 我知道了按钮
            const gotItBtn = document.getElementById('got-it-btn');
            if (gotItBtn) {
                gotItBtn.addEventListener('click', () => {
                    this.hide();
                });
            }
            
            // 点击背景关闭
            const modal = document.getElementById('announcement-modal');
            if (modal) {
                modal.addEventListener('click', (e) => {
                    if (e.target === modal) {
                        this.hide();
                    }
                });
            }
        }
    };
    
    // 页面加载完成后初始化
    document.addEventListener('DOMContentLoaded', function() {
        // 初始化公告系统
        AnnouncementSystem.init();
        console.log('JSP 首页加载完成');
    });
    
    // 搜索功能 - 跳转到搜索页
    function performSearch() {
        const searchInput = document.getElementById('searchInput');
        const query = searchInput ? searchInput.value.trim() : '';
        
        if (query) {
            window.location.href = '${pageContext.request.contextPath}/search?q=' + encodeURIComponent(query);
        }
    }
    
    // 搜索框回车
    const searchInput = document.getElementById('searchInput');
    if (searchInput) {
        searchInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                performSearch();
            }
        });
    }
    
    // 电影卡片点击事件 - 让 <a> 标签自然跳转
    document.querySelectorAll('.movie-card').forEach(card => {
        card.addEventListener('click', function(e) {
            // 自然跳转，不做拦截
        });
    });
    
    // Mobile menu toggle
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    
    if (mobileMenuBtn && mobileMenu) {
        mobileMenuBtn.addEventListener('click', () => {
            mobileMenu.classList.toggle('hidden');
        });
    }
</script>
</body>
</html>
