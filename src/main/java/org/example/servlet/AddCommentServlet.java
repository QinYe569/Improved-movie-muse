package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.CommentService;
import org.example.service.impl.CommentServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

/**
 * 添加评论 Servlet
 */
@WebServlet(name = "AddCommentServlet", value = "/api/comment/add")
public class AddCommentServlet extends HttpServlet {
    
    private CommentService commentService = new CommentServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json;charset=UTF-8");
        
        // 获取请求参数
        String movieIdStr = request.getParameter("movieId");
        String content = request.getParameter("content");
        
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
        
        if (content == null || content.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "评论内容不能为空");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        try {
            Integer movieId = Integer.parseInt(movieIdStr);
            
            // 添加评论
            boolean success = commentService.addComment(userId, movieId, content.trim());
            
            if (success) {
                result.put("success", true);
                result.put("message", "评论成功");
            } else {
                result.put("success", false);
                result.put("message", "评论失败，请稍后重试");
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
