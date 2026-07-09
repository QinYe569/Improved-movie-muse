package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Category;
import org.example.entity.Movie;
import org.example.service.CategoryService;
import org.example.service.MovieService;
import org.example.service.impl.CategoryServiceImpl;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 检查用户登录状态 Servlet
 */
@WebServlet(name = "CheckAuthServlet", value = "/api/check-auth")
public class CheckAuthServlet extends HttpServlet {
    
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        Map<String, Object> result = new HashMap<>();
        
        // 检查 Session 中是否有用户信息
        Object username = request.getSession().getAttribute("username");
        Object userId = request.getSession().getAttribute("userId");
        
        if (username != null && userId != null) {
            result.put("loggedIn", true);
            result.put("username", username);
            result.put("userId", userId);
        } else {
            result.put("loggedIn", false);
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
