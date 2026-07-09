package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Comment;
import org.example.entity.Favorite;
import org.example.entity.User;
import org.example.entity.ViewHistory;
import org.example.service.CommentService;
import org.example.service.FavoriteService;
import org.example.service.ViewHistoryService;
import org.example.service.impl.CommentServiceImpl;
import org.example.service.impl.FavoriteServiceImpl;
import org.example.service.impl.ViewHistoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 个人中心 Servlet
 */
@WebServlet(name = "ProfileServlet", value = "/user/profile")
public class ProfileServlet extends HttpServlet {
    
    private FavoriteService favoriteService = new FavoriteServiceImpl();
    private CommentService commentService = new CommentServiceImpl();
    private ViewHistoryService viewHistoryService = new ViewHistoryServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        // 获取收藏列表（含电影信息）
        List<Favorite> favorites = favoriteService.findByUserId(currentUser.getId());
        
        // 获取评论列表（含电影信息）
        List<Comment> comments = commentService.findByUserId(currentUser.getId());
        
        // 获取浏览历史列表（含电影信息）
        List<ViewHistory> viewHistories = viewHistoryService.findByUserId(currentUser.getId());
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("favorites", favorites);
        request.setAttribute("comments", comments);
        request.setAttribute("viewHistories", viewHistories);
        
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        // 获取更新参数
        String email = request.getParameter("email");
        String genderStr = request.getParameter("gender");
        String action = request.getParameter("action");
        
        // 处理更新个人信息
        if ("update".equals(action)) {
            if (email != null && !email.trim().isEmpty()) {
                currentUser.setEmail(email.trim());
            }
            if (genderStr != null) {
                try {
                    currentUser.setGender(Integer.parseInt(genderStr));
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        }
        
        // 获取收藏列表（含电影信息）
        List<Favorite> favorites = favoriteService.findByUserId(currentUser.getId());
        
        // 获取评论列表（含电影信息）
        List<Comment> comments = commentService.findByUserId(currentUser.getId());
        
        // 获取浏览历史列表（含电影信息）
        List<ViewHistory> viewHistories = viewHistoryService.findByUserId(currentUser.getId());
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("favorites", favorites);
        request.setAttribute("comments", comments);
        request.setAttribute("viewHistories", viewHistories);
        
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
}
