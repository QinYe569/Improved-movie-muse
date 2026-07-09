<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    未登录状态的导航栏
    使用方式：在 JSP 页面中使用 <jsp:include page="/components/navbar-guest.jsp" />
--%>
<nav class="fixed top-0 left-0 right-0 z-50" style="background: transparent; backdrop-filter: blur(10px); -webkit-backdrop-filter: blur(10px);">
    <div class="max-w-7xl mx-auto px-6 py-4">
        <div class="nav-container">
            <a href="${pageContext.request.contextPath}/index.html" class="logo">Movie-Muse</a>
            <div class="hidden md:flex items-center gap-8">
                <a href="${pageContext.request.contextPath}/index.html" class="nav-link text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-list.html" class="nav-link text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/login.jsp" class="nav-link text-white hover:text-white/80 transition-colors">个人中心</a>
                <!-- 未登录状态显示登录/注册 -->
                <a href="${pageContext.request.contextPath}/user/login.jsp" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium transition-colors backdrop-blur-sm border border-white/30">登录 / 注册</a>
            </div>
            <button id="mobileMenuBtn" class="md:hidden text-white text-xl" aria-label="菜单">
                <i class="fas fa-bars"></i>
            </button>
        </div>

        <div id="mobileMenu" class="hidden md:hidden mt-4 pb-4 border-t border-white/10 pt-4">
            <div class="flex flex-col gap-4">
                <a href="${pageContext.request.contextPath}/index.html" class="nav-link text-white hover:text-white/80 transition-colors">首页</a>
                <a href="${pageContext.request.contextPath}/user/category-list.html" class="nav-link text-white hover:text-white/80 transition-colors">电影分类</a>
                <a href="${pageContext.request.contextPath}/user/login.jsp" class="nav-link text-white hover:text-white/80 transition-colors">个人中心</a>
                <a href="${pageContext.request.contextPath}/user/login.jsp" class="bg-white/20 hover:bg-white/30 text-white px-5 py-2 rounded-full font-medium text-center transition-colors backdrop-blur-sm border border-white/30">登录 / 注册</a>
            </div>
        </div>
    </div>
</nav>

<script>
    // 移动端菜单切换
    document.addEventListener('DOMContentLoaded', function() {
        const mobileMenuBtn = document.getElementById('mobileMenuBtn');
        const mobileMenu = document.getElementById('mobileMenu');
        
        if (mobileMenuBtn && mobileMenu) {
            mobileMenuBtn.addEventListener('click', function() {
                mobileMenu.classList.toggle('hidden');
            });
        }
    });
</script>
