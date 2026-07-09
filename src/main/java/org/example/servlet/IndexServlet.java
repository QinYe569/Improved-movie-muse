package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 首页 Servlet
 * 项目启动时访问此 Servlet，跳转到 index.html 页面
 * 使用 Jakarta Servlet 6.1.0 API
 */
@WebServlet(name = "IndexServlet", value = "/index")
public class IndexServlet extends HttpServlet {
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // 重定向到 index.html 页面
        response.sendRedirect(request.getContextPath() + "/index.html");
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
