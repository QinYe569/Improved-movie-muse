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
    <title>电影列表 - Movie-Muse</title>
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

        /* ===== 背景图和淡遮罩层 ===== */
        body::before {
            content: '';
            position: fixed;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: url('../images/pawel-czerwinski-IXgSpDrxsgM-unsplash.jpg') center center / cover no-repeat;
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

        /* ===== Movie Grid ===== */
        .movie-list-container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 100px 40px 60px;
        }

        .page-title {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 40px;
            text-align: center;
        }

        .movie-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 30px;
            margin-bottom: 60px;
        }

        .movie-card {
            background: rgba(30, 30, 50, 0.6);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            backdrop-filter: blur(8px);
            -webkit-backdrop-filter: blur(8px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            text-decoration: none;
            display: block;
        }

        .movie-card:hover {
            transform: translateY(-8px) scale(1.02);
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
            background: rgba(30, 30, 50, 0.8);
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
            padding: 16px;
        }

        .movie-card .card-title {
            font-weight: 600;
            color: #ffffff;
            font-size: 1rem;
            margin-bottom: 8px;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }

        .movie-card .card-desc {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.6);
            line-height: 1.5;
            margin-bottom: 8px;
            display: -webkit-box;
            -webkit-line-clamp: 2;
            -webkit-box-orient: vertical;
            overflow: hidden;
        }

        .movie-card .card-meta {
            font-size: 0.8rem;
            color: rgba(255, 255, 255, 0.5);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* ===== Pagination ===== */
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
            background: rgba(255, 255, 255, 0.3);
            border-color: rgba(255, 255, 255, 0.5);
        }

        .pagination-btn.next {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border: none;
        }

        .pagination-btn.next:hover {
            box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4);
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
        @media (max-width: 1024px) {
            .movie-grid {
                grid-template-columns: repeat(3, 1fr);
            }
        }

        @media (max-width: 768px) {
            .movie-grid {
                grid-template-columns: repeat(2, 1fr);
                gap: 20px;
            }

            .movie-list-container {
                padding: 80px 20px 40px;
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
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link">电影分类</a>
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
                <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=1" class="nav-link">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="nav-link">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/profile" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
            </div>
        </div>
    </div>
</nav>

<!-- Movie List -->
<main class="movie-list-container">
    <h1 class="page-title">全部电影</h1>

    <div class="movie-grid">
        <c:forEach items="${movies}" var="movie">
            <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                <div class="poster-wrap">
                    <img src="${movie.poster}" alt="${movie.title}" onerror="this.src='https://picsum.photos/300/450?random=${movie.id}'">
                    <div class="rating-badge">
                        <i class="fas fa-star"></i>
                        <fmt:formatNumber value="${movie.rating}" pattern="#.#"/>
                    </div>
                </div>
                <div class="card-info">
                    <h3 class="card-title">${movie.title}</h3>
                    <p class="card-desc">${movie.description}</p>
                    <div class="card-meta">
                        <span>${movie.director} · ${movie.releaseYear}</span>
                        <span>${movie.runtime} 分钟</span>
                    </div>
                </div>
            </a>
        </c:forEach>
    </div>

    <c:if test="${empty movies}">
        <div style="text-align: center; padding: 4rem; color: rgba(255,255,255,0.5);">
            <i class="fas fa-film" style="font-size: 3rem; margin-bottom: 1rem; opacity: 0.3;"></i>
            <p>暂无电影数据</p>
        </div>
    </c:if>

    <!-- 分页 -->
    <c:if test="${totalPages > 1}">
        <div class="pagination">
            <c:if test="${currentPage > 1}">
                <a href="${pageContext.request.contextPath}/user/movie-list?page=${currentPage - 1}" class="pagination-btn" title="上一页">
                    <i class="fas fa-chevron-left"></i>
                </a>
            </c:if>

            <c:forEach begin="1" end="${totalPages}" var="pageNum">
                <c:choose>
                    <c:when test="${pageNum == currentPage}">
                        <span class="pagination-btn active">${pageNum}</span>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/user/movie-list?page=${pageNum}" class="pagination-btn">${pageNum}</a>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:if test="${currentPage < totalPages}">
                <a href="${pageContext.request.contextPath}/user/movie-list?page=${currentPage + 1}" class="pagination-btn next" title="下一页">
                    <i class="fas fa-chevron-right"></i>
                </a>
            </c:if>
        </div>
    </c:if>
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

<!-- JavaScript -->
<script src="../js/auth.js"></script>
<script>
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
