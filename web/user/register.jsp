<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户注册 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Poppins', sans-serif;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background: url('${pageContext.request.contextPath}/images/pawel-czerwinski-IXgSpDrxsgM-unsplash.jpg') center center / cover no-repeat;
            position: relative;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(0, 0, 0, 0.4);
            z-index: 0;
        }

        .register-container {
            position: relative;
            z-index: 1;
            width: 100%;
            max-width: 500px;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 24px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }

        .register-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .register-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }

        .register-header p {
            color: rgba(255, 255, 255, 0.7);
            font-size: 1rem;
        }

        .input-group {
            position: relative;
            margin-bottom: 1.5rem;
        }

        .input-group input {
            width: 100%;
            padding: 1rem 1rem 1rem 3rem;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: #ffffff;
            font-size: 1rem;
            outline: none;
            transition: all 0.3s ease;
        }

        .input-group input:focus {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.4);
        }

        .input-group input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .input-group .input-icon {
            position: absolute;
            left: 1rem;
            top: 50%;
            transform: translateY(-50%);
            color: rgba(255, 255, 255, 0.5);
            font-size: 1.1rem;
        }

        .register-btn {
            width: 100%;
            padding: 1rem;
            background: linear-gradient(135deg, #666666, #999999);
            border: none;
            border-radius: 12px;
            color: #ffffff;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .register-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.2);
        }

        .login-link {
            text-align: center;
            margin-top: 1.5rem;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.95rem;
        }

        .login-link a {
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
        }

        .login-link a:hover {
            text-decoration: underline;
        }

        .error-message {
            background: rgba(239, 68, 68, 0.2);
            border: 1px solid rgba(239, 68, 68, 0.4);
            color: #fca5a5;
            padding: 0.75rem 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .register-container {
                margin: 1rem;
                padding: 2rem;
            }

            .register-header h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="register-container">
        <div class="register-header">
            <h1>创建账户</h1>
            <p>加入 Movie-Muse，发现更多精彩电影</p>
        </div>

        <%-- 显示错误信息（由 Servlet 设置） --%>
        <%
            String errorMsg = (String) request.getAttribute("registerError");
            if (errorMsg != null) {
        %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
            </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/api/register" method="post">
            <div class="input-group">
                <i class="fas fa-envelope input-icon"></i>
                <input type="email" name="email" placeholder="邮箱地址" required>
            </div>

            <div class="input-group">
                <i class="fas fa-user input-icon"></i>
                <input type="text" name="username" placeholder="用户名" required>
            </div>

            <div class="input-group">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="password" id="password" placeholder="密码" required>
            </div>

            <div class="input-group">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="confirmPassword" placeholder="确认密码" required>
            </div>

            <button type="submit" class="register-btn">创建账户</button>
        </form>

        <div class="login-link">
            已有账户？<a href="login.jsp">立即登录</a>
        </div>
    </div>
</body>
</html>
