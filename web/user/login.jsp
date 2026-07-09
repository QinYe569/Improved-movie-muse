<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户登录 - Movie-Muse</title>
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

        .login-container {
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

        .login-header {
            text-align: center;
            margin-bottom: 2.5rem;
        }

        .login-header h1 {
            font-size: 2rem;
            font-weight: 700;
            color: #ffffff;
            margin-bottom: 0.5rem;
        }

        .login-header p {
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

        .login-options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 0.5rem;
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
        }

        .remember-me input {
            width: 1rem;
            height: 1rem;
            accent-color: #8a2be2;
        }

        .forgot-password {
            color: rgba(255, 255, 255, 0.7);
            font-size: 0.9rem;
            text-decoration: none;
            transition: color 0.2s ease;
        }

        .forgot-password:hover {
            color: #ffffff;
        }

        .login-btn {
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

        .login-btn:hover {
            transform: translateY(-2px);
            box-shadow: 0 8px 20px rgba(255, 255, 255, 0.2);
        }

        .register-link {
            text-align: center;
            margin-top: 1.5rem;
            color: rgba(255, 255, 255, 0.6);
            font-size: 0.95rem;
        }

        .register-link a {
            color: #ffffff;
            text-decoration: none;
            font-weight: 600;
        }

        .register-link a:hover {
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
            .login-container {
                margin: 1rem;
                padding: 2rem;
            }

            .login-header h1 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1>欢迎回来</h1>
            <p>请登录您的账户</p>
        </div>

        <%-- 显示错误信息（由 Servlet 设置） --%>
        <%
            String errorMsg = (String) request.getAttribute("loginError");
            if (errorMsg != null) {
        %>
            <div class="error-message">
                <i class="fas fa-exclamation-circle"></i> <%= errorMsg %>
            </div>
        <%
            }
        %>

        <form action="${pageContext.request.contextPath}/api/login" method="post">
            <div class="input-group">
                <i class="fas fa-user input-icon"></i>
                <input type="text" name="username" placeholder="用户名" required>
            </div>

            <div class="input-group">
                <i class="fas fa-lock input-icon"></i>
                <input type="password" name="password" placeholder="密码" required>
            </div>

            <div class="login-options">
                <label class="remember-me">
                    <input type="checkbox">
                    记住我
                </label>
                <a href="#" class="forgot-password">忘记密码？</a>
            </div>

            <button type="submit" class="login-btn">登录</button>
        </form>

        <div class="register-link">
            还没有账户？<a href="register.jsp">立即注册</a>
        </div>
    </div>
</body>
</html>
