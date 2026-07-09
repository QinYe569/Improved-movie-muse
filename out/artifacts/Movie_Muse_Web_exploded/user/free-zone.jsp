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
    <title>限时免费专区 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap">
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

        .free-zone-hero {
            position: relative;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 4rem 8% 3rem;
            margin-top: 4rem;
            border-radius: 0 0 30px 30px;
            overflow: hidden;
        }

        .free-zone-hero::before {
            content: '';
            position: absolute;
            top: -50%;
            right: -10%;
            width: 600px;
            height: 600px;
            background: radial-gradient(circle, rgba(255,255,255,0.1) 0%, transparent 70%);
            border-radius: 50%;
        }

        .hero-content {
            position: relative;
            z-index: 1;
            text-align: center;
        }

        .hero-title {
            font-size: 3rem;
            font-weight: 800;
            color: #ffffff;
            margin-bottom: 1rem;
            text-shadow: 0 4px 20px rgba(0,0,0,0.3);
        }

        .hero-subtitle {
            font-size: 1.2rem;
            color: rgba(255, 255, 255, 0.9);
            margin-bottom: 2rem;
        }

        .free-badge {
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: #1f2937;
            padding: 0.75rem 2rem;
            border-radius: 50px;
            font-weight: 700;
            font-size: 1.1rem;
            box-shadow: 0 10px 30px rgba(251, 191, 36, 0.4);
            animation: pulse 2s ease-in-out infinite;
        }

        @keyframes pulse {
            0%, 100% {
                transform: scale(1);
            }
            50% {
                transform: scale(1.05);
            }
        }

        .movies-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 3rem 8%;
        }

        .section-title {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 2rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }

        .section-title i {
            color: #fbbf24;
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
        }

        .movie-card {
            background: rgba(30, 37, 64, 0.6);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            position: relative;
            text-decoration: none;
            display: block;
        }

        .movie-card:hover {
            transform: translateY(-10px);
            box-shadow: 0 20px 40px rgba(138, 43, 226, 0.3);
            border-color: rgba(168, 85, 247, 0.4);
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
            transform: scale(1.1);
        }

        .movie-card .play-overlay {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.5);
            display: flex;
            align-items: center;
            justify-content: center;
            opacity: 0;
            transition: opacity 0.3s ease;
        }

        .movie-card:hover .play-overlay {
            opacity: 1;
        }

        .play-button {
            width: 70px;
            height: 70px;
            background: rgba(168, 85, 247, 0.9);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            box-shadow: 0 10px 30px rgba(168, 85, 247, 0.5);
        }

        .play-button i {
            color: #ffffff;
            font-size: 2rem;
            margin-left: 4px;
        }

        .movie-card .card-info {
            padding: 1.5rem;
        }

        .movie-card .card-title {
            font-weight: 700;
            color: #ffffff;
            font-size: 1.2rem;
            margin-bottom: 0.75rem;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-card .card-meta {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .movie-card .rating {
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .movie-card .rating i {
            color: #fbbf24;
            font-size: 1rem;
        }

        .movie-card .rating span {
            color: #ffffff;
            font-weight: 600;
        }

        .movie-card .year {
            color: rgba(255, 255, 255, 0.5);
            font-size: 0.9rem;
        }

        .site-footer {
            background: rgba(20, 20, 20, 0.95);
            border-top: 1px solid rgba(255, 255, 255, 0.05);
            padding: 2rem 5%;
            text-align: center;
            margin-top: 4rem;
        }

        .site-footer .footer-links {
            display: flex;
            justify-content: center;
            gap: 2rem;
            margin-bottom: 1rem;
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

        @media (max-width: 768px) {
            .hero-title {
                font-size: 2rem;
            }

            .movies-grid {
                grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
                gap: 1.5rem;
            }
        }
    </style>
</head>
<body>

<nav class="fixed top-0 left-0 right-0 z-50" style="background: rgba(20, 20, 20, 0.9); backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
    <div class="max-w-7xl mx-auto px-6 py-4">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/user/index" class="logo">Movie-Muse</a>
            <div class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/user/index" class="text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="text-white hover:text-white/80 transition-colors">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white text-xl" aria-label="菜单">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div id="mobileMenu" class="hidden md:hidden mt-4 pb-4 border-t border-white/10 pt-4">
            <div class="flex flex-col gap-4">
                <a href="${pageContext.request.contextPath}/user/index" class="text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="text-white hover:text-white/80 transition-colors">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
        </div>
    </div>
</nav>

<section class="free-zone-hero">
    <div class="hero-content">
        <h1 class="hero-title">
            <i class="fas fa-gift"></i> 限时免费专区
        </h1>
        <p class="hero-subtitle">精选高分电影，免费观看，限时畅享！</p>
        <div class="free-badge">
            <i class="fas fa-crown"></i>
            <span>完全免费 · 无需 VIP</span>
        </div>
    </div>
</section>

<main class="movies-container">
    <h2 class="section-title">
        <i class="fas fa-film"></i>
        免费片单
        <span style="font-size: 1rem; color: rgba(255,255,255,0.5); font-weight: 400; margin-left: 10px;">(${fn:length(freeMovies)} 部)</span>
    </h2>

    <div class="movies-grid">
        <c:forEach items="${freeMovies}" var="movie">
            <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                <div class="poster-wrap">
                    <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='https://picsum.photos/300/450?random=${movie.id}'">
                    <div class="play-overlay">
                        <div class="play-button">
                            <i class="fas fa-play"></i>
                        </div>
                    </div>
                </div>
                <div class="card-info">
                    <h3 class="card-title">${movie.title}</h3>
                    <div class="card-meta">
                        <div class="rating">
                            <i class="fas fa-star"></i>
                            <span><fmt:formatNumber value="${movie.rating}" pattern="#.#"/></span>
                        </div>
                        <span class="year">${movie.releaseYear}</span>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>
</main>

<footer class="site-footer">
    <div class="footer-links">
        <a href="#">关于我们</a>
        <a href="#">联系我们</a>
        <a href="#">隐私政策</a>
        <a href="#">用户协议</a>
    </div>
    <p>&copy; 2024 Movie-Muse. All rights reserved.</p>
</footer>

<script src="${pageContext.request.contextPath}/js/auth.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        checkLogin();
    });

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
