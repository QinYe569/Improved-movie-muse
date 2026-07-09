package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 用户注册 Servlet
 */
@WebServlet(name = "RegisterServlet", value = "/api/register")
public class RegisterServlet extends HttpServlet {
    
    private UserService userService = new UserServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 设置请求编码
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        // 获取请求参数
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String confirmPassword = request.getParameter("confirmPassword");
        
        Map<String, Object> result = new HashMap<>();
        boolean isAjax = "XMLHttpRequest".equals(request.getHeader("X-Requested-With"));
        
        // 参数验证
        if (username == null || username.trim().isEmpty()) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "用户名不能为空");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "用户名不能为空");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        if (password == null || password.trim().isEmpty()) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "密码不能为空");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "密码不能为空");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        if (email == null || email.trim().isEmpty()) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "邮箱不能为空");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "邮箱不能为空");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        // 验证两次密码是否一致
        if (!password.equals(confirmPassword)) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "两次输入的密码不一致");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "两次输入的密码不一致");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        // 验证用户名是否已存在
        if (userService.isUsernameExist(username.trim())) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "用户名已存在");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "用户名已存在");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        // 验证邮箱是否已注册
        if (userService.isEmailExist(email.trim())) {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "邮箱已被注册");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "邮箱已被注册");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
            return;
        }
        
        // 创建用户对象
        User user = new User();
        user.setUsername(username.trim());
        user.setPassword(password); // Service 层会进行 MD5 加密
        user.setEmail(email.trim());
        user.setGender(0); // 默认未知
        user.setIsVip(0); // 默认非 VIP
        user.setStatus(1); // 默认正常
        
        // 调用服务层注册
        boolean success = userService.register(user);
        
        if (success) {
            if (isAjax) {
                result.put("success", true);
                result.put("message", "注册成功");
                response.getWriter().write(gson.toJson(result));
            } else {
                // 注册成功，重定向到登录页
                response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            }
        } else {
            if (isAjax) {
                result.put("success", false);
                result.put("message", "注册失败，请稍后重试");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("registerError", "注册失败，请稍后重试");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
