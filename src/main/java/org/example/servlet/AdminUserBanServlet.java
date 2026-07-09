package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;

/**
 * 管理员封禁/解封用户 Servlet
 */
@WebServlet(name = "AdminUserBanServlet", value = "/admin/user-ban")
public class AdminUserBanServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/users");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            User user = userService.findById(id);
            if (user != null) {
                // 切换状态：正常(1) -> 禁用(0)，禁用(0) -> 正常(1)
                user.setStatus(user.getStatus() != null && user.getStatus() == 1 ? 0 : 1);
                userService.updateUser(user);
            }
        } catch (NumberFormatException e) {
            // 非法 ID，忽略
        }

        response.sendRedirect(request.getContextPath() + "/admin/users");
    }
}
