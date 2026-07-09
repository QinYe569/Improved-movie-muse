package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "ChangePasswordServlet", value = "/user/change-password")
public class ChangePasswordServlet extends HttpServlet {

    private UserService userService = new UserServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            out.write("{\"success\":false,\"message\":\"请先登录\"}");
            return;
        }
        
        String oldPassword = request.getParameter("oldPassword");
        String newPassword = request.getParameter("newPassword");
        
        if (oldPassword == null || newPassword == null || oldPassword.isEmpty() || newPassword.isEmpty()) {
            out.write("{\"success\":false,\"message\":\"参数不能为空\"}");
            return;
        }
        
        boolean success = userService.changePassword(currentUser.getId(), oldPassword, newPassword);
        
        if (success) {
            out.write("{\"success\":true,\"message\":\"密码修改成功\"}");
        } else {
            out.write("{\"success\":false,\"message\":\"原密码不正确\"}");
        }
    }
}
