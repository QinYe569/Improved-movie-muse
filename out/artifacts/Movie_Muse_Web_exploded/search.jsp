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
    <title><c:if test="${not empty keyword}">${keyword} - </c:if>搜索结果 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="css/style.css">
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
            background: url('images/pawel-czerwinski-tMbQpdguDVQ-unsplash.jpg') center center / cover no-repeat;
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
            background: rgba(0, 0, 0, 0.5);
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
            max-width: 1200px;
            margin: 0 auto;
            padding: 2rem;
            position: relative;
            z-index: 1;
        }

        .search-header {
            background: rgba(30, 37, 64, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 2rem;
            margin-bottom: 2rem;
        }

        .search-header h1 {
            font-size: 1.75rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }

        .search-header p {
            color: rgba(255, 255, 255, 0.5);
            font-size: 1rem;
        }

        .search-header .highlight {
            color: #a855f7;
            font-weight: 600;
        }

        .filter-section {
            background: rgba(30, 37, 64, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
            padding: 1.5rem 2rem;
            margin-bottom: 2rem;
        }

        .filter-title {
            font-size: 1rem;
            font-weight: 600;
            color: #ffffff;
            margin-bottom: 1rem;
        }

        .filter-tags {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
        }

        .filter-tag {
            padding: 8px 16px;
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            background: rgba(255, 255, 255, 0.05);
            color: rgba(255, 255, 255, 0.6);
            font-weight: 500;
            font-size: 0.9rem;
            cursor: pointer;
            transition: all 0.2s ease;
            text-decoration: none;
            display: inline-block;
        }

        .filter-tag:hover {
            border-color: #a855f7;
            color: #d8b4fe;
        }

        .filter-tag.active {
            background: linear-gradient(135deg, #8a2be2, #a855f7);
            color: white;
            border-color: transparent;
        }

        .movies-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
            gap: 1.5rem;
            margin-bottom: 2rem;
        }

        .movie-card {
            background: rgba(30, 37, 64, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
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
            height: 280px;
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

        .movie-card .card-rating {
            display: flex;
            align-items: center;
            gap: 4px;
            margin-bottom: 0.75rem;
        }

        .movie-card .card-rating .stars {
            color: #fbbf24;
            font-size: 0.85rem;
        }

        .movie-card .card-rating .score {
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.5);
        }

        .movie-card .card-meta {
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 0.85rem;
            color: rgba(255, 255, 255, 0.5);
        }

        .movie-card .card-genre {
            background: rgba(138, 43, 226, 0.3);
            color: #d8b4fe;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 0.75rem;
        }

        .empty-state {
            text-align: center;
            padding: 4rem;
            background: rgba(30, 37, 64, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 16px;
        }

        .empty-state .empty-icon {
            width: 100px;
            height: 100px;
            margin: 0 auto 1.5rem;
            background: rgba(138, 43, 226, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            color: #a855f7;
        }

        .empty-state h3 {
            font-size: 1.25rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #ffffff;
        }

        .empty-state p {
            color: rgba(255, 255, 255, 0.5);
            margin-bottom: 1.5rem;
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

        .search-bar-container {
            max-width: 1400px;
            margin: 6rem auto 0;
            padding: 0 3rem;
        }

        .search-bar-container .search-input-wrapper {
            position: relative;
            width: 100%;
            margin: 0 auto 2.5rem;
        }

        .search-bar-container .search-input-wrapper form {
            display: flex;
            position: relative;
        }

        .search-bar-container .search-glass {
            width: 100%;
            padding-left: 5.5rem;
            padding-right: 10rem;
            padding-top: 2rem;
            padding-bottom: 2rem;
            border-radius: 1.5rem;
            background: rgba(30, 37, 64, 0.95);
            border: 2px solid rgba(255, 255, 255, 0.15);
            color: #ffffff;
            font-size: 1.75rem;
            font-family: 'Poppins', sans-serif;
            box-shadow: 0 6px 30px rgba(0, 0, 0, 0.4);
            transition: all 0.3s ease;
        }

        .search-bar-container .search-glass::placeholder {
            color: rgba(255, 255, 255, 0.35);
            font-size: 1.5rem;
        }

        .search-bar-container .search-glass:focus {
            outline: none;
            border-color: #a855f7;
            box-shadow: 0 6px 40px rgba(168, 85, 247, 0.3);
        }

        .search-bar-container .search-icon {
            position: absolute;
            left: 2rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.5);
            pointer-events: none;
            font-size: 1.75rem;
        }

        .search-bar-container .search-submit {
            position: absolute;
            right: 1rem;
            top: 50%;
            transform: translateY(-50%);
            background: linear-gradient(135deg, #8a2be2, #a855f7);
            border: none;
            color: white;
            padding: 1.25rem 3.5rem;
            border-radius: 1rem;
            cursor: pointer;
            font-weight: 600;
            font-size: 1.5rem;
            transition: all 0.2s ease;
            box-shadow: 0 6px 20px rgba(138, 43, 226, 0.4);
        }

        .search-bar-container .search-submit:hover {
            opacity: 0.95;
            transform: translateY(-50%) scale(1.03);
            box-shadow: 0 8px 28px rgba(138, 43, 226, 0.5);
        }

        .pagination {
            display: flex;
            justify-content: center;
            gap: 10px;
            margin-top: 2rem;
            margin-bottom: 2rem;
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
            background: linear-gradient(135deg, #8a2be2, #a855f7);
            border: none;
        }

        .rating-stars {
            color: #fbbf24;
            font-size: 0.85rem;
        }

        @media (max-width: 768px) {
            .main-content {
                padding: 1rem;
            }

            .movies-grid {
                grid-template-columns: repeat(auto-fill, minmax(160px, 1fr));
                gap: 1rem;
            }

            .movie-card .card-poster {
                height: 220px;
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
                    <a href="${pageContext.request.contextPath}/user/profile.html" class="nav-link">个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/profile.html" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
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
                    <a href="${pageContext.request.contextPath}/user/profile.html" class="nav-link">个人中心</a>
                    <a href="${pageContext.request.contextPath}/user/profile.html" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30"><%= user.getUsername() %></a>
                    <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
                </div>
            </div>
        </div>
    </nav>

    <div class="search-bar-container">
        <div class="search-input-wrapper">
            <form action="${pageContext.request.contextPath}/search" method="get">
                <i class="fas fa-search search-icon"></i>
                <input type="text" name="q" class="search-glass" placeholder="搜索电影、导演、演员..." value="${keyword}">
                <button type="submit" class="search-submit">搜索</button>
            </form>
        </div>
    </div>

    <main class="main-content">
        <div class="search-header">
            <h1>搜索结果</h1>
            <p>
                找到 <span class="highlight">${totalCount}</span> 部
                <c:if test="${not empty keyword}">
                    与 "<span class="highlight">${keyword}</span>" 相关的电影
                </c:if>
                <c:if test="${empty keyword}">
                    电影
                </c:if>
            </p>
        </div>

        <div class="filter-section">
            <div class="filter-title">热门分类</div>
            <div class="filter-tags">
                <a href="${pageContext.request.contextPath}/search?q=${keyword}" class="filter-tag ${empty param.categoryId ? 'active' : ''}">全部</a>
                <c:forEach items="${categories}" var="cat">
                    <a href="${pageContext.request.contextPath}/user/category-movies?categoryId=${cat.id}" class="filter-tag">${cat.name}</a>
                </c:forEach>
            </div>
        </div>

        <c:if test="${not empty movies}">
            <div class="movies-grid">
                <c:forEach items="${movies}" var="movie">
                    <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${movie.title}" class="movie-card">
                        <img src="${movie.poster}" alt="${movie.title}" class="card-poster" onerror="this.src='https://picsum.photos/200/280?random=${movie.id}'">
                        <div class="card-info">
                            <h3 class="card-title">${movie.title}</h3>
                            <div class="card-rating">
                                <span class="rating-stars">
                                    <c:forEach begin="1" end="5" var="star">
                                        <c:choose>
                                            <c:when test="${star <= movie.rating / 2}">
                                                <i class="fas fa-star"></i>
                                            </c:when>
                                            <c:otherwise>
                                                <i class="far fa-star"></i>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </span>
                                <span class="score"><fmt:formatNumber value="${movie.rating}" pattern="#.#"/></span>
                            </div>
                            <div class="card-meta">
                                <span>${movie.releaseYear}</span>
                                <span class="card-genre">${movie.director}</span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </c:if>

        <c:if test="${empty movies}">
            <div class="empty-state">
                <div class="empty-icon">
                    <i class="fas fa-search"></i>
                </div>
                <h3>没有找到相关电影</h3>
                <p>试试其他关键词，或者浏览热门分类</p>
                <a href="${pageContext.request.contextPath}/user/index" class="filter-tag active" style="display: inline-block;">返回首页</a>
            </div>
        </c:if>

        <c:if test="${totalPages > 1}">
            <div class="pagination">
                <c:if test="${currentPage > 1}">
                    <a href="${pageContext.request.contextPath}/search?q=${keyword}&page=${currentPage - 1}" class="pagination-btn" title="上一页">
                        <i class="fas fa-chevron-left"></i>
                    </a>
                </c:if>

                <c:forEach begin="1" end="${totalPages}" var="pageNum">
                    <c:choose>
                        <c:when test="${pageNum == currentPage}">
                            <span class="pagination-btn active">${pageNum}</span>
                        </c:when>
                        <c:otherwise>
                            <a href="${pageContext.request.contextPath}/search?q=${keyword}&page=${pageNum}" class="pagination-btn">${pageNum}</a>
                        </c:otherwise>
                    </c:choose>
                </c:forEach>

                <c:if test="${currentPage < totalPages}">
                    <a href="${pageContext.request.contextPath}/search?q=${keyword}&page=${currentPage + 1}" class="pagination-btn" title="下一页">
                        <i class="fas fa-chevron-right"></i>
                    </a>
                </c:if>
            </div>
        </c:if>
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

    <script src="js/auth.js"></script>
    <script>
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
