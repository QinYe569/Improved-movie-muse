package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Comment;
import org.example.service.CommentService;
import org.example.service.impl.CommentServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 评论列表 Servlet
 */
@WebServlet(name = "CommentListServlet", value = "/api/comments")
public class CommentListServlet extends HttpServlet {
    
    private CommentService commentService = new CommentServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        // 获取电影 ID 参数
        String movieIdStr = request.getParameter("movieId");
        
        Map<String, Object> result = new HashMap<>();
        
        if (movieIdStr == null || movieIdStr.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "电影 ID 不能为空");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        try {
            Integer movieId = Integer.parseInt(movieIdStr);
            
            // 查询评论列表
            List<Comment> comments = commentService.findByMovieId(movieId);
            int totalCount = commentService.getCountByMovieId(movieId);
            
            result.put("success", true);
            result.put("comments", comments);
            result.put("totalCount", totalCount);
            
        } catch (NumberFormatException e) {
            result.put("success", false);
            result.put("message", "电影 ID 格式错误");
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
