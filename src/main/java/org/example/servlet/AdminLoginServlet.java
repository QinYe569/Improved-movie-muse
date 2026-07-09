package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.service.AdminService;
import org.example.service.impl.AdminServiceImpl;

import java.io.IOException;

/**
 * 管理员登录 Servlet
 */
@WebServlet(name = "AdminLoginServlet", value = "/admin/login")
public class AdminLoginServlet extends HttpServlet {
    
    private AdminService adminService = new AdminServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            request.setAttribute("loginError", "用户名和密码不能为空");
            request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
            return;
        }
        
        Admin admin = adminService.login(username.trim(), password.trim());
        
        if (admin != null) {
            HttpSession session = request.getSession();
            session.setAttribute("currentAdmin", admin);
            response.sendRedirect(request.getContextPath() + "/admin/admin-login-success.jsp");
        } else {
            request.setAttribute("loginError", "用户名或密码错误");
            request.getRequestDispatcher("/admin/admin-login.jsp").forward(request, response);
        }
    }
}
