<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="org.example.entity.Admin" %>
<%
    Admin admin = (Admin) session.getAttribute("currentAdmin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/admin/login");
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
    // 设置管理员状态到 localStorage
    localStorage.setItem('isLoggedIn', 'true');
    localStorage.setItem('username', '<%= admin.getUsername() %>');
    localStorage.setItem('userId', '<%= admin.getId() %>');
    localStorage.setItem('userRole', 'admin');
    
    // 跳转到管理员首页
    window.location.href = '${pageContext.request.contextPath}/admin/dashboard';
</script>
<p>管理员登录成功，正在跳转到管理后台...</p>
</body>
</html>
