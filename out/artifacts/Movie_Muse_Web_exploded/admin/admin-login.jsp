<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员登录 - Movie-Muse</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        :root {
            --primary-color: #9333ea;
            --text-primary: #1f2937;
            --text-secondary: #6b7280;
            --border-color: #e5e7eb;
        }

        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
            background: url('../images/pawel-czerwinski-SawCLzAiew8-unsplash.jpg') center center / cover no-repeat;
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        body::before {
            content: '';
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            background: rgba(243, 244, 246, 0.4);
            z-index: 0;
        }

        body > * {
            position: relative;
            z-index: 1;
        }

        .login-card {
            width: 420px;
            background: white;
            border-radius: 20px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.1);
            padding: 3rem 2.5rem;
        }

        .login-card .logo {
            text-align: center;
            margin-bottom: 2rem;
        }

        .login-card .logo h1 {
            font-size: 2.5rem;
            font-weight: 800;
            background: linear-gradient(135deg, #9333ea, #a855f7);
            -webkit-background-clip: text;
            -webkit-text-fill-color: transparent;
            background-clip: text;
        }

        .login-card .logo p {
            color: var(--text-secondary);
            margin-top: 0.5rem;
            font-size: 0.95rem;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            font-weight: 600;
            color: var(--text-primary);
            margin-bottom: 0.5rem;
            font-size: 0.9rem;
        }

        .form-group input {
            width: 100%;
            padding: 12px 16px;
            border: 2px solid var(--border-color);
            border-radius: 10px;
            font-size: 1rem;
            font-family: inherit;
            color: var(--text-primary);
            transition: all 0.3s ease;
        }

        .form-group input:focus {
            outline: none;
            border-color: var(--primary-color);
            box-shadow: 0 0 0 4px rgba(147, 51, 234, 0.1);
        }

        .btn-login {
            width: 100%;
            padding: 14px;
            background: linear-gradient(135deg, var(--primary-color), #a855f7);
            color: white;
            border: none;
            border-radius: 10px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 12px rgba(147, 51, 234, 0.3);
        }

        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 16px rgba(147, 51, 234, 0.4);
        }

        .error-msg {
            background: #fee2e2;
            color: #991b1b;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .back-link {
            text-align: center;
            margin-top: 1.5rem;
        }

        .back-link a {
            color: var(--text-secondary);
            text-decoration: none;
            font-size: 0.9rem;
            transition: color 0.3s ease;
        }

        .back-link a:hover {
            color: var(--primary-color);
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="logo">
            <h1>Movie-Muse</h1>
            <p>管理后台登录</p>
        </div>

        <c:if test="${not empty loginError}">
            <div class="error-msg">
                <i class="fas fa-exclamation-circle"></i>
                ${loginError}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="form-group">
                <label for="username"><i class="fas fa-user"></i> 用户名</label>
                <input type="text" id="username" name="username" placeholder="请输入管理员用户名" required>
            </div>

            <div class="form-group">
                <label for="password"><i class="fas fa-lock"></i> 密码</label>
                <input type="password" id="password" name="password" placeholder="请输入密码" required>
            </div>

            <button type="submit" class="btn-login">
                <i class="fas fa-sign-in-alt"></i> 登录
            </button>
        </form>


    </div>
</body>
</html>
