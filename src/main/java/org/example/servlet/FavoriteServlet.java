package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.FavoriteService;
import org.example.service.impl.FavoriteServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 收藏/取消收藏 Servlet
 */
@WebServlet(name = "FavoriteServlet", value = "/api/favorite")
public class FavoriteServlet extends HttpServlet {
    
    private FavoriteService favoriteService = new FavoriteServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        // 获取请求参数
        String movieIdStr = request.getParameter("movieId");
        String action = request.getParameter("action"); // add 或 remove
        
        Map<String, Object> result = new HashMap<>();
        
        // 检查登录状态
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            result.put("success", false);
            result.put("message", "请先登录");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        Integer userId = (Integer) session.getAttribute("userId");
        
        // 参数验证
        if (movieIdStr == null || movieIdStr.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "电影 ID 不能为空");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        try {
            Integer movieId = Integer.parseInt(movieIdStr);
            
            boolean success;
            if ("add".equals(action)) {
                // 添加收藏
                success = favoriteService.addFavorite(userId, movieId);
                if (success) {
                    result.put("success", true);
                    result.put("message", "收藏成功");
                    result.put("favorited", true);
                } else {
                    result.put("success", false);
                    result.put("message", "您已收藏该电影");
                }
            } else if ("remove".equals(action)) {
                // 取消收藏
                success = favoriteService.removeFavorite(userId, movieId);
                if (success) {
                    result.put("success", true);
                    result.put("message", "已取消收藏");
                    result.put("favorited", false);
                } else {
                    result.put("success", false);
                    result.put("message", "未找到该收藏");
                }
            } else {
                // 检查收藏状态
                boolean isFavorited = favoriteService.isFavorited(userId, movieId);
                result.put("success", true);
                result.put("favorited", isFavorited);
            }
            
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "电影 ID 格式错误");
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doPost(request, response);
    }
}
