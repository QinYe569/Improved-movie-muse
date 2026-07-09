<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entity.User" %>
<%
    User user = (User) session.getAttribute("currentUser");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>登录成功 - Movie-Muse</title>
</head>
<body>
<script>
    // 设置登录状态到 localStorage
    localStorage.setItem('isLoggedIn', 'true');
    localStorage.setItem('username', '<%= user.getUsername() %>');
    localStorage.setItem('userId', '<%= user.getId() %>');
    localStorage.setItem('userRole', 'user');
    
    // 跳转到用户首页
    window.location.href = '${pageContext.request.contextPath}/user/index';
</script>
<p>登录成功，正在跳转到首页...</p>
</body>
</html>
