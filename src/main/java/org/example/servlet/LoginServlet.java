package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.User;
import org.example.service.AdminService;
import org.example.service.UserService;
import org.example.service.impl.AdminServiceImpl;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 统一登录 Servlet
 * 同时检索 user 表和 admin 表，自动判断身份并跳转到对应页面
 */
@WebServlet(name = "LoginServlet", value = "/api/login")
public class LoginServlet extends HttpServlet {
    
    private UserService userService = new UserServiceImpl();
    private AdminService adminService = new AdminServiceImpl();
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
        
        Map<String, Object> result = new HashMap<>();
        
        // 参数验证
        if (username == null || username.trim().isEmpty() || 
            password == null || password.trim().isEmpty()) {
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                result.put("success", false);
                result.put("message", "用户名和密码不能为空");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("loginError", "用户名和密码不能为空");
                request.getRequestDispatcher("/user/login.jsp").forward(request, response);
            }
            return;
        }
        
        String trimmedUsername = username.trim();
        String trimmedPassword = password.trim();
        
        // 先检查是否是管理员
        Admin admin = adminService.login(trimmedUsername, trimmedPassword);
        
        if (admin != null) {
            // 管理员登录成功
            HttpSession session = request.getSession();
            session.setAttribute("currentAdmin", admin);
            session.setAttribute("adminId", admin.getId());
            session.setAttribute("adminUsername", admin.getUsername());
            session.setAttribute("isAdmin", true);
            
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                result.put("success", true);
                result.put("message", "管理员登录成功");
                result.put("role", "admin");
                response.getWriter().write(gson.toJson(result));
            } else {
                response.sendRedirect(request.getContextPath() + "/admin/admin-login-success.jsp");
            }
            return;
        }
        
        // 再检查是否是普通用户
        User user = userService.login(trimmedUsername, trimmedPassword);
        
        if (user != null) {
            // 校验用户是否被封禁
            if (user.getStatus() == null || user.getStatus() != 1) {
                if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                    result.put("success", false);
                    result.put("message", "该账号已被封禁，无法登录");
                    response.getWriter().write(gson.toJson(result));
                } else {
                    request.setAttribute("loginError", "该账号已被封禁，无法登录");
                    request.getRequestDispatcher("/user/login.jsp").forward(request, response);
                }
                return;
            }

            // 用户登录成功
            HttpSession session = request.getSession();
            session.setAttribute("currentUser", user);
            session.setAttribute("userId", user.getId());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("isAdmin", false);

            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                result.put("success", true);
                result.put("message", "登录成功");
                result.put("user", user);
                result.put("role", "user");
                response.getWriter().write(gson.toJson(result));
            } else {
                response.sendRedirect(request.getContextPath() + "/user/login-success.jsp");
            }
        } else {
            // 登录失败
            if ("XMLHttpRequest".equals(request.getHeader("X-Requested-With"))) {
                result.put("success", false);
                result.put("message", "用户名或密码错误");
                response.getWriter().write(gson.toJson(result));
            } else {
                request.setAttribute("loginError", "用户名或密码错误");
                request.getRequestDispatcher("/user/login.jsp").forward(request, response);
            }
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
