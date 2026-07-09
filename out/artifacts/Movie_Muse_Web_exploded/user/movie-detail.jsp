<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%@ page import="org.example.entity.User" %>
<%@ page import="org.example.entity.Movie" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
    Movie currentMovie = (Movie) request.getAttribute("movie");
    Integer currentMovieId = currentMovie != null ? currentMovie.getId() : null;
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${movie.title} - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700;800&display=swap">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }

        body {
            font-family: 'Poppins', sans-serif;
            background: url('${pageContext.request.contextPath}/images/pawel-czerwinski-prMn9KINLtI-unsplash.jpg') center center / cover no-repeat;
            position: relative;
            min-height: 100vh;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.5);
            z-index: 0;
        }

        * { position: relative; z-index: 1; }

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
        .nav-link:hover { color: #ffffff; }

        .movie-detail-section { padding: 2rem 8% 4rem 8%; }

        .movie-detail {
            display: flex;
            gap: 3rem;
            background: rgba(30, 37, 64, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            padding: 2.5rem;
        }

        .movie-detail .poster {
            flex: 0 0 30%;
            max-width: 30%;
        }
        .movie-detail .poster img {
            width: 100%;
            border-radius: 12px;
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.3);
        }

        .movie-detail .info {
            flex: 1;
            padding-top: 1rem;
        }

        .movie-detail .title {
            font-size: 2.5rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: #ffffff;
        }

        .movie-detail .meta {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            margin-bottom: 1.5rem;
            flex-wrap: wrap;
        }

        .movie-detail .rating {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .movie-detail .rating .stars { color: #fbbf24; font-size: 1.25rem; }
        .movie-detail .rating .score { font-weight: 600; font-size: 1.25rem; color: #ffffff; }
        .movie-detail .year, .movie-detail .runtime { color: rgba(255, 255, 255, 0.5); font-size: 0.95rem; }
        .movie-detail .genre {
            background: rgba(138, 43, 226, 0.3);
            color: #d8b4fe;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 0.85rem;
        }
        .movie-detail .director, .movie-detail .cast {
            margin-bottom: 0.75rem;
            color: rgba(255, 255, 255, 0.6);
        }
        .movie-detail .director strong, .movie-detail .cast strong { color: #ffffff; }

        .movie-detail .synopsis {
            margin: 1.5rem 0;
            line-height: 1.8;
            color: rgba(255, 255, 255, 0.6);
            text-align: justify;
        }

        .movie-detail .actions { display: flex; gap: 1rem; }

        .btn {
            padding: 0.75rem 1.5rem;
            border-radius: 8px;
            font-weight: 600;
            font-size: 0.95rem;
            cursor: pointer;
            transition: all 0.3s ease;
            border: none;
            display: inline-flex;
            align-items: center;
            gap: 0.5rem;
        }
        .btn-primary {
            background: linear-gradient(135deg, #667eea, #764ba2);
            color: #ffffff;
        }
        .btn-primary:hover { transform: translateY(-2px); box-shadow: 0 8px 20px rgba(102, 126, 234, 0.4); }
        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: #ffffff;
            border: 1px solid rgba(255, 255, 255, 0.2);
        }
        .btn-secondary:hover { background: rgba(255, 255, 255, 0.2); }

        .recommended-section { margin-top: 3rem; }
        .recommended-section h2 {
            font-size: 1.5rem;
            font-weight: 600;
            margin-bottom: 1.5rem;
            color: #ffffff;
        }
        .recommended-movies {
            display: flex;
            gap: 1.5rem;
            overflow-x: auto;
            padding-bottom: 1rem;
            scrollbar-width: none;
        }
        .recommended-movies::-webkit-scrollbar { display: none; }

        .movie-card-rec {
            flex: 0 0 200px;
            background: rgba(30, 37, 64, 0.85);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 12px;
            overflow: hidden;
            transition: all 0.3s ease;
            cursor: pointer;
            text-decoration: none;
            display: block;
        }
        .movie-card-rec:hover {
            transform: translateY(-6px);
            box-shadow: 0 12px 24px rgba(138, 43, 226, 0.2);
        }
        .movie-card-rec .card-poster {
            width: 100%;
            height: 280px;
            object-fit: cover;
        }
        .movie-card-rec .card-info { padding: 1rem; }
        .movie-card-rec .card-title {
            font-weight: 600;
            margin-bottom: 0.5rem;
            color: #ffffff;
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
        .movie-card-rec .card-rating {
            display: flex;
            align-items: center;
            gap: 4px;
        }
        .movie-card-rec .card-rating .stars { color: #fbbf24; font-size: 0.85rem; }
        .movie-card-rec .card-rating .score { font-size: 0.85rem; color: rgba(255, 255, 255, 0.5); }

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
        .page-footer .footer-links a:hover { color: #a855f7; }
        .page-footer p {
            color: rgba(255, 255, 255, 0.3);
            font-size: 0.85rem;
            margin: 0;
        }

        .video-player-section {
            margin-top: 3rem;
            background: rgba(30, 37, 64, 0.9);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            border-radius: 20px;
            padding: 2rem;
        }
        .video-player-section h2 {
            font-size: 1.8rem;
            color: #ffffff;
            margin-bottom: 1.5rem;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .video-player-section h2 i { color: #a855f7; }

        .video-player-box {
            width: 100%;
            background: #000;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.5);
            position: relative;
            padding-top: 56.25%;
            height: 0;
        }
        .video-player-box iframe {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            border: none;
        }
        .video-placeholder {
            position: absolute;
            top: 0; left: 0;
            width: 100%; height: 100%;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            color: rgba(255, 255, 255, 0.6);
            font-size: 1.2rem;
        }
        .video-placeholder i { font-size: 4rem; margin-bottom: 1rem; opacity: 0.3; }

        .free-zone-badge {
            display: inline-block;
            padding: 0.5rem 1rem;
            background: linear-gradient(135deg, #fbbf24, #f59e0b);
            color: #1f2937;
            border-radius: 20px;
            font-weight: 700;
            font-size: 0.9rem;
            margin-left: 1rem;
            animation: pulse 2s ease-in-out infinite;
        }
        @keyframes pulse {
            0%, 100% { transform: scale(1); opacity: 1; }
            50% { transform: scale(1.05); opacity: 0.8; }
        }

        .search-bar-page {
            max-width: 1200px;
            margin: 5.5rem auto 0;
            padding: 0 2rem;
        }
        .search-bar-page .search-input-wrapper {
            position: relative;
            max-width: 600px;
            margin: 0 auto 2rem;
        }

        .comments-section {
            margin-top: 60px;
            background: rgba(30, 37, 64, 0.6);
            backdrop-filter: blur(12px);
            -webkit-backdrop-filter: blur(12px);
            border-radius: 16px;
            padding: 30px;
            border: 1px solid rgba(255, 255, 255, 0.08);
        }
        .comments-title {
            font-size: 1.8rem;
            color: #ffffff;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
        }
        .comments-title i { color: #a855f7; }
        .comment-input-area {
            margin-bottom: 40px;
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 20px;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }
        .comment-item {
            background: rgba(255, 255, 255, 0.05);
            border-radius: 12px;
            padding: 20px;
            margin-bottom: 15px;
            border: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.3s ease;
        }
        .comment-item:hover {
            background: rgba(255, 255, 255, 0.08);
            border-color: rgba(168, 85, 247, 0.3);
        }

        @media (max-width: 768px) {
            .movie-detail { flex-direction: column; padding: 1.5rem; }
            .movie-detail .poster { max-width: 100%; }
            .movie-detail .poster img { max-width: 250px; margin: 0 auto; display: block; }
            .movie-detail .title { font-size: 1.75rem; }
            .movie-detail .meta { flex-wrap: wrap; gap: 0.75rem; }
            .movie-detail .actions { flex-direction: column; }
        }
    </style>
</head>
<body>

    <!-- Navbar -->
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
                    <button onclick="logout()" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">退出登录</button>
                </div>
            </div>
        </div>
    </nav>

    <!-- Search Bar -->
    <div class="search-bar-page">
        <div class="search-input-wrapper">
            <input type="text" id="searchInput" class="search-glass w-full pl-12 pr-12 py-4 rounded-xl focus:outline-none transition-all" style="background: rgba(255,255,255,0.1); border: 1px solid rgba(255,255,255,0.2); color: #fff;" placeholder="搜索电影、导演、演员...">
            <i class="fas fa-search absolute left-4 top-1/2 -translate-y-1/2 text-white/40"></i>
        </div>
    </div>

    <!-- Movie Detail Section -->
    <main class="movie-detail-section">
        <div class="movie-detail">
            <div class="poster">
                <img src="${movie.poster}" alt="${movie.title}海报" onerror="this.src='https://picsum.photos/300/450?random=${movie.id}'">
            </div>

            <div class="info">
                <h1 class="title">${movie.title}</h1>
                <div class="meta">
                    <div class="rating">
                        <span class="stars"><i class="fas fa-star"></i></span>
                        <span class="score"><fmt:formatNumber value="${movie.rating}" pattern="#.#"/></span>
                    </div>
                    <span class="year">${movie.releaseYear}</span>
                    <span class="runtime">${movie.runtime}分钟</span>
                    <span class="genre">电影</span>
                </div>

                <p class="director"><strong>导演:</strong> ${movie.director}</p>

                <p class="synopsis">${movie.description}</p>

                <div class="actions">
                    <button class="btn btn-primary" id="favorite-btn">
                        <i class="fas fa-heart"></i> 加入收藏
                    </button>
                    <c:if test="${not empty movie.videoUrl}">
                        <a href="#video-section" class="btn btn-secondary">
                            <i class="fas fa-play"></i> 立即观看
                        </a>
                    </c:if>
                </div>
            </div>
        </div>

        <!-- 视频播放器模块（仅当有videoUrl时显示） -->
        <c:if test="${not empty movie.videoUrl}">
            <div class="video-player-section" id="video-section">
                <h2>
                    <i class="fas fa-play-circle"></i>
                    在线观看
                    <c:if test="${movie.isFree == 1}">
                        <span class="free-zone-badge">
                            <i class="fas fa-gift"></i> 限时免费
                        </span>
                    </c:if>
                </h2>
                <div class="video-player-box">
                    <iframe src="${movie.videoUrl}" scrolling="no" border="0" frameborder="no" framespacing="0" allowfullscreen="true"></iframe>
                </div>
            </div>
        </c:if>

        <!-- 评论区模块 -->
        <div class="comments-section">
            <h2 class="comments-title">
                <i class="fas fa-comments"></i>
                评论区
                <span style="font-size: 1rem; color: rgba(255,255,255,0.6); font-weight: 400;">(${commentCount} 条评论)</span>
            </h2>

            <!-- 发表评论 -->
            <div class="comment-input-area">
                <div style="display: flex; gap: 15px; align-items: flex-start;">
                    <div style="width: 50px; height: 50px; border-radius: 50%; background: linear-gradient(135deg, #667eea, #764ba2); display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                        <i class="fas fa-user" style="color: white; font-size: 20px;"></i>
                    </div>
                    <div style="flex: 1;">
                        <textarea id="comment-textarea" placeholder="写下您的影评..." rows="3" style="width: 100%; background: rgba(0, 0, 0, 0.3); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 8px; padding: 12px; color: #ffffff; font-size: 14px; resize: vertical; font-family: inherit;"></textarea>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-top: 12px;">
                            <span style="color: rgba(255, 255, 255, 0.6); font-size: 13px;"><%= user.getUsername() %></span>
                            <button id="post-comment-btn" style="background: linear-gradient(135deg, #667eea, #764ba2); color: white; border: none; padding: 10px 24px; border-radius: 8px; font-weight: 600; cursor: pointer; transition: all 0.3s ease; font-size: 14px;">
                                <i class="fas fa-paper-plane" style="margin-right: 6px;"></i>发布评论
                            </button>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 评论列表 -->
            <div id="comments-list">
                <c:forEach items="${comments}" var="comment">
                    <div class="comment-item">
                        <div style="display: flex; gap: 15px; align-items: flex-start;">
                            <div style="width: 45px; height: 45px; border-radius: 50%; background: linear-gradient(135deg, #667eea, #764ba2); display: flex; align-items: center; justify-content: center; flex-shrink: 0;">
                                <span style="color: white; font-weight: 700; font-size: 18px;">${comment.user.username.charAt(0)}</span>
                            </div>
                            <div style="flex: 1; min-width: 0;">
                                <div style="display: flex; align-items: center; gap: 10px; margin-bottom: 8px; flex-wrap: wrap;">
                                    <span style="color: #ffffff; font-weight: 600; font-size: 15px;">${comment.user.username}</span>
                                    <span style="color: rgba(255, 255, 255, 0.4); font-size: 12px;"><fmt:formatDate value="${comment.createTime}" pattern="yyyy-MM-dd HH:mm"/></span>
                                </div>
                                <p style="color: rgba(255, 255, 255, 0.85); line-height: 1.6; margin: 0; word-wrap: break-word;">${comment.content}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
                <c:if test="${empty comments}">
                    <div style="text-align: center; padding: 3rem; color: rgba(255,255,255,0.4);">
                        <i class="fas fa-comment-slash" style="font-size: 2rem; margin-bottom: 1rem;"></i>
                        <p>暂无评论，快来发表第一条评论吧！</p>
                    </div>
                </c:if>
            </div>
        </div>

        <!-- Recommended Section -->
        <div class="recommended-section">
            <h2>猜你喜欢</h2>
            <div class="recommended-movies">
                <c:forEach items="${recommendMovies}" var="recMovie">
                    <a href="${pageContext.request.contextPath}/user/movie-detail?movie=${recMovie.title}" class="movie-card-rec">
                        <img src="${recMovie.poster}" alt="${recMovie.title}" class="card-poster" onerror="this.src='https://picsum.photos/200/280?random=${recMovie.id}'">
                        <div class="card-info">
                            <h3 class="card-title">${recMovie.title}</h3>
                            <div class="card-rating">
                                <span class="stars"><i class="fas fa-star"></i></span>
                                <span class="score"><fmt:formatNumber value="${recMovie.rating}" pattern="#.#"/></span>
                            </div>
                        </div>
                    </a>
                </c:forEach>
            </div>
        </div>
    </main>

    <!-- Footer -->
    <footer class="page-footer">
        <div class="footer-links">
            <a href="#">关于我们</a>
            <a href="#">隐私政策</a>
            <a href="#">服务条款</a>
            <a href="#">联系我们</a>
        </div>
        <p>&copy; 2024 Movie-Muse. All rights reserved.</p>
    </footer>

    <!-- 隐藏字段存储电影ID，确保JavaScript能正确获取 -->
    <input type="hidden" id="hiddenMovieId" value="<%= currentMovieId != null ? currentMovieId : "" %>">

    <script src="${pageContext.request.contextPath}/js/auth.js"></script>
    <script>
        const hiddenInput = document.getElementById('hiddenMovieId');
        const movieId = hiddenInput ? hiddenInput.value : '';
        const contextPath = '${pageContext.request.contextPath}';
        console.log('当前电影ID:', movieId);
        console.log('隐藏字段元素:', hiddenInput);
        console.log('当前电影对象:', '<%= currentMovie != null ? currentMovie.getTitle() : "null" %>');

        // Mobile menu toggle
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');
        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener('click', () => {
                mobileMenu.classList.toggle('hidden');
            });
        }

        // Favorite button
        const favoriteBtn = document.getElementById('favorite-btn');
        if (favoriteBtn) {
            function checkFavoriteStatus() {
                fetch(contextPath + '/api/favorite?movieId=' + movieId)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success && data.favorited) {
                            favoriteBtn.innerHTML = '<i class="fas fa-heart" style="color: #ef4444;"></i> 已收藏';
                        } else {
                            favoriteBtn.innerHTML = '<i class="fas fa-heart"></i> 加入收藏';
                        }
                    })
                    .catch(err => console.error('检查收藏状态失败:', err));
            }

            checkFavoriteStatus();

            favoriteBtn.addEventListener('click', function() {
                const isFavorited = this.innerHTML.includes('已收藏');
                const action = isFavorited ? 'remove' : 'add';
                
                fetch(contextPath + '/api/favorite?movieId=' + movieId + '&action=' + action)
                    .then(response => response.json())
                    .then(data => {
                        if (data.success) {
                            if (data.favorited) {
                                favoriteBtn.innerHTML = '<i class="fas fa-heart" style="color: #ef4444;"></i> 已收藏';
                            } else {
                                favoriteBtn.innerHTML = '<i class="fas fa-heart"></i> 加入收藏';
                            }
                            alert(data.message);
                        } else {
                            alert(data.message);
                        }
                    })
                    .catch(err => {
                        console.error('收藏操作失败:', err);
                        alert('操作失败，请稍后重试');
                    });
            });
        }

        // Post comment
        const postCommentBtn = document.getElementById('post-comment-btn');
        const commentTextarea = document.getElementById('comment-textarea');
        const commentsContainer = document.getElementById('comments-container');
        
        if (postCommentBtn && commentTextarea) {
            postCommentBtn.addEventListener('click', function() {
                const content = commentTextarea.value.trim();
                if (!content) {
                    alert('请输入评论内容');
                    return;
                }
                if (!movieId || movieId === '' || movieId === 'null') {
                    alert('电影信息加载异常，请刷新页面后重试！(movieId=' + movieId + ')');
                    return;
                }
                
                const formData = new URLSearchParams();
                formData.append('movieId', movieId);
                formData.append('content', content);
                
                fetch(contextPath + '/api/comment/add', {
                    method: 'POST',
                    headers: {
                        'Content-Type': 'application/x-www-form-urlencoded'
                    },
                    body: formData
                })
                .then(response => response.json())
                .then(data => {
                    if (data.success) {
                        alert(data.message);
                        commentTextarea.value = '';
                        location.reload();
                    } else {
                        alert(data.message);
                    }
                })
                .catch(err => {
                    console.error('评论失败:', err);
                    alert('评论失败，请稍后重试');
                });
            });
            
            commentTextarea.addEventListener('keydown', function(e) {
                if (e.ctrlKey && e.key === 'Enter') {
                    postCommentBtn.click();
                }
            });
        }

        // Search
        const searchInput = document.getElementById('searchInput');
        if (searchInput) {
            searchInput.addEventListener('keypress', function(e) {
                if (e.key === 'Enter') {
                    const query = searchInput.value.trim();
                    if (query) {
                        window.location.href = contextPath + '/search?q=' + encodeURIComponent(query);
                    }
                }
            });
        }
    </script>
</body>
</html>
