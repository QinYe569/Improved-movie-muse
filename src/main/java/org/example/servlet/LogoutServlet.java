package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * 用户退出登录 Servlet
 */
@WebServlet(name = "LogoutServlet", value = "/api/logout")
public class LogoutServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        // 获取 Session 并移除用户信息
        HttpSession session = request.getSession(false);
        if (session != null) {
            session.removeAttribute("currentUser");
            session.removeAttribute("userId");
            session.removeAttribute("username");
            // 可选：使 Session 失效
            // session.invalidate();
        }
        
        // 重定向到首页
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
