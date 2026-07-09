package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 管理员用户列表 Servlet
 */
@WebServlet(name = "AdminUserListServlet", value = "/admin/users")
public class AdminUserListServlet extends HttpServlet {
    
    private UserService userService = new UserServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        List<User> users = userService.findAllUsers();
        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        
        request.setAttribute("currentAdmin", currentAdmin);
        request.setAttribute("users", users);
        
        request.getRequestDispatcher("/admin/admin-users.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
