<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 
    公共页脚组件
    使用方式：在 JSP 页面中使用 <jsp:include page="/components/footer.jsp" />
--%>
<footer class="site-footer">
    <div class="footer-links">
        <a href="${pageContext.request.contextPath}/about.jsp">关于我们</a>
        <a href="${pageContext.request.contextPath}/contact.jsp">联系我们</a>
        <a href="${pageContext.request.contextPath}/privacy.jsp">隐私政策</a>
        <a href="${pageContext.request.contextPath}/terms.jsp">用户协议</a>
    </div>
    <p>&copy; ${pageContext.timeZone} Movie-Muse. All rights reserved.</p>
</footer>

<style>
    .site-footer {
        text-align: center;
        padding: 2rem;
        margin-top: 3rem;
        border-top: 1px solid rgba(255, 255, 255, 0.05);
    }
    
    .site-footer .footer-links {
        display: flex;
        justify-content: center;
        gap: 2rem;
        margin-bottom: 1rem;
        flex-wrap: wrap;
    }
    
    .site-footer .footer-links a {
        color: rgba(255, 255, 255, 0.4);
        text-decoration: none;
        font-size: 0.9rem;
        transition: color 0.3s ease;
    }
    
    .site-footer .footer-links a:hover {
        color: #a855f7;
    }
    
    .site-footer p {
        color: rgba(255, 255, 255, 0.3);
        font-size: 0.85rem;
        margin: 0;
    }
</style>
