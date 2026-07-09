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
    <title>${currentCategory.name}电影 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="../css/style.css">
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

        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('../images/pawel-czerwinski-prMn9KINLtI-unsplash.jpg') center center / cover no-repeat;
            z-index: -1;
        }

        body::after {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.3);
            z-index: -1;
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
        }

        .nav-link {
            color: rgba(255, 255, 255, 0.8);
            text-decoration: none;
            font-weight: 500;
            font-size: 15px;
            transition: color 0.3s ease;
        }

        .nav-link:hover {
            color: #ffffff;
        }

        .category-page {
            display: flex;
            max-width: 1600px;
            margin: 0 auto;
            padding: 100px 40px 60px;
            gap: 40px;
        }

        .category-sidebar {
            width: 280px;
            flex-shrink: 0;
            background: rgba(30, 37, 64, 0.6);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            height: fit-content;
            position: sticky;
            top: 120px;
        }

        .sidebar-title {
            color: #ffffff;
            font-size: 1.3rem;
            font-weight: 700;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
        }

        .category-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
        }

        .category-item {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 18px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 10px;
            color: rgba(255, 255, 255, 0.7);
            text-decoration: none;
            transition: all 0.3s ease;
            border: 1px solid transparent;
            cursor: pointer;
        }

        .category-item:hover {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            transform: translateX(5px);
        }

        .category-item.active {
            background: linear-gradient(135deg, #9333ea, #a855f7);
            color: #ffffff;
            border-color: rgba(168, 85, 247, 0.3);
            box-shadow: 0 4px 15px rgba(168, 85, 247, 0.3);
        }

        .category-count {
            background: rgba(255, 255, 255, 0.15);
            padding: 4px 10px;
            border-radius: 12px;
            font-size: 0.8rem;
        }

        .category-content {
            flex: 1;
            min-width: 0;
        }

        .category-movies-section {
            margin-bottom: 20px;
            scroll-margin-top: 100px;
        }

        .category-movies-section .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 25px;
            flex-wrap: wrap;
            gap: 15px;
        }

        .category-movies-section .section-title {
            font-size: 1.8rem;
            font-weight: 700;
            color: #ffffff;
            margin: 0;
            display: flex;
            align-items: center;
        }

        .category-movies-section .section-desc {
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.95rem;
            margin: 5px 0 0 35px;
        }

        .view-all-btn {
            color: #a855f7;
            text-decoration: none;
            font-size: 0.95rem;
            font-weight: 500;
            display: flex;
            align-items: center;
            gap: 8px;
            transition: all 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
            background: rgba(168, 85, 247, 0.1);
        }

        .view-all-btn:hover {
            background: rgba(168, 85, 247, 0.2);
            transform: translateX(5px);
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(2, 1fr);
            gap: 30px;
        }

        .movie-card {
            background: rgba(30, 37, 64, 0.6);
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            border: 1px solid rgba(255, 255, 255, 0.08);
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
        }

        .movie-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
            background: rgba(30, 30, 50, 0.8);
            border-color: rgba(168, 85, 247, 0.3);
        }

        .movie-card .poster-wrap {
            position: relative;
            width: 100%;
            padding-top: 150%;
            overflow: hidden;
        }

        .movie-card .poster-wrap img {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.3s ease;
        }

        .movie-card:hover .poster-wrap img {
            transform: scale(1.05);
        }

        .movie-card .rating-badge {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(250, 204, 21, 0.9);
            color: #1a1a1a;
            padding: 5px 10px;
            border-radius: 6px;
            font-size: 0.8rem;
            font-weight: 700;
            display: flex;
            align-items: center;
            gap: 4px;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
        }

        .movie-card .card-info {
            padding: 15px;
            flex: 1;
            display: flex;
            flex-direction: column;
            gap: 8px;
        }

        .movie-card .card-title {
            font-weight: 600;
            color: #ffffff;
            font-size: 1.05rem;
            margin: 0;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-card .card-desc {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.65);
            line-height: 1.5;
            margin: 0;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
            flex: 1;
        }

        .movie-card .card-meta {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.5);
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: auto;
            padding-top: 10px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 40px;
            padding-bottom: 40px;
        }

        .pagination-btn {
            width: 40px;
            height: 40px;
            display: flex;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            color: #ffffff;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .pagination-btn:hover {
            background: rgba(255, 255, 255, 0.2);
            border-color: rgba(255, 255, 255, 0.4);
            transform: translateY(-2px);
        }

        .pagination-btn.active {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: rgba(255, 255, 255, 0.5);
        }

        .empty-state i {
            font-size: 3rem;
            margin-bottom: 1rem;
            opacity: 0.3;
        }

        @media (max-width: 1200px) {
            .category-page {
                padding: 100px 20px 40px;
            }

            .category-sidebar {
                width: 220px;
            }
        }

        @media (max-width: 768px) {
            .category-page {
                flex-direction: column;
                padding: 80px 15px 30px;
            }

            .category-sidebar {
                width: 100%;
                position: static;
            }

            .movies-grid {
                grid-template-columns: 1fr;
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
                <a href="${pageContext.request.contextPath}/user/index" class="nav-link">首页</a>
                <a href="${pageContext.request.contextPath}/user/categories" class="nav-link">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white text-xl" aria-label="菜单">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div id="mobileMenu" class="hidden md:hidden mt-4 pb-4 border-t border-white/10 pt-4">
            <div class="flex flex-col gap-4">
                <a href="${pageContext.request.contextPath}/user/index" class="nav-link">首页</a>
                <a href="${pageContext.request.contextPath}/user/categories" class="nav-link">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
        </div>
    </div>
</nav>

<!-- Main Content -->
<div class="category-page">
    <!-- Sidebar -->
    <aside class="category-sidebar">
        <h2 class="sidebar-title"><i class="fas fa-th-large" style="margin-right: 10px;"></i>电影分类</h2>
        <div class="category-list">
            <c:forEach items="${categories}" var="cat">
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=${cat.id}"
                   class="category-item ${cat.id == currentCategory.id ? 'active' : ''}">
                    <span>
                        <c:if test="${not empty cat.icon}"><i class="${cat.icon}" style="margin-right: 10px;"></i></c:if>
                        ${cat.name}
                    </span>
                </a>
            </c:forEach>
        </div>
    </aside>

    <!-- Content -->
    <main class="category-content">
        <section class="category-movies-section">
            <div class="section-header">
                <div>
                    <h2 class="section-title">
                        <c:if test="${not empty currentCategory.icon}">
                            <i class="${currentCategory.icon}" style="margin-right: 15px; color: #667eea;"></i>
                        </c:if>
                        ${currentCategory.name}电影
                    </h2>
                    <c:if test="${not empty currentCategory.description}">
                        <p class="section-desc">${currentCategory.description}</p>
                    </c:if>
                </div>
                <span class="view-all-btn">共 ${fn:length(movies)} 部 <i class="fas fa-film"></i></span>
            </div>

            <c:if test="${not empty movies}">
                <div class="movies-grid">
                    <c:forEach items="${movies}" var="movie">
                        <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                            <div class="poster-wrap">
                                <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='https://picsum.photos/400/600?random=${movie.id}'">
                                <div class="rating-badge">
                                    <i class="fas fa-star"></i>
                                    <fmt:formatNumber value="${movie.rating}" pattern="#.#"/>
                                </div>
                            </div>
                            <div class="card-info">
                                <h3 class="card-title">${movie.title}</h3>
                                <p class="card-desc">${movie.description}</p>
                                <div class="card-meta">
                                    <span>${currentCategory.name} · ${movie.releaseYear}</span>
                                    <span>${movie.runtime} 分钟</span>
                                </div>
                            </div>
                        </a>
                    </c:forEach>
                </div>
            </c:if>

            <c:if test="${empty movies}">
                <div class="empty-state">
                    <i class="fas fa-film"></i>
                    <p>该分类下暂无电影</p>
                </div>
            </c:if>
        </section>

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=${currentCategory.id}&page=${currentPage - 1}" class="pagination-btn" title="上一页">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <span class="pagination-btn active">${pageNum}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=${currentCategory.id}&page=${pageNum}" class="pagination-btn">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=${currentCategory.id}&page=${currentPage + 1}" class="pagination-btn" title="下一页">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </c:if>
    </main>
</div>

<script src="../js/auth.js"></script>
<script>
    const mobileMenuBtn = document.getElementById('mobileMenuBtn');
    const mobileMenu = document.getElementById('mobileMenu');
    if (mobileMenuBtn && mobileMenu) {
        mobileMenuBtn.addEventListener('click', function() {
            mobileMenu.classList.toggle('hidden');
        });
    }
</script>

</body>
</html>
