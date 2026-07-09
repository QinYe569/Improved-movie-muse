package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Announcement;
import org.example.entity.Category;
import org.example.entity.Movie;
import org.example.entity.User;
import org.example.service.AnnouncementService;
import org.example.service.CategoryService;
import org.example.service.MovieService;
import org.example.service.impl.AnnouncementServiceImpl;
import org.example.service.impl.CategoryServiceImpl;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 用户首页 Servlet
 * 从数据库加载电影数据并转发到 JSP 页面
 */
@WebServlet(name = "UserIndexServlet", value = "/user/index")
public class UserIndexServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();
    private AnnouncementService announcementService = new AnnouncementServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("currentUser");
        }
        
        // 未登录则跳转到登录页
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }
        
        // 加载首页数据
        // 最新上映：按创建时间倒序取前 10 部
        List<Movie> latestMovies = movieService.findAll(1, 10);
        // 猜你喜欢：按播放次数排序的热门电影
        List<Movie> hotMovies = movieService.findByViewCount(1, 10);
        
        // 加载所有分类
        List<Category> categories = categoryService.findAll();
        // 加载系统公告（按发布时间倒序）
        List<Announcement> announcements = announcementService.findAll();
        
        // 将数据放入 request
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("latestMovies", latestMovies);
        request.setAttribute("recommendMovies", hotMovies);
        request.setAttribute("categories", categories);
        request.setAttribute("announcements", announcements);
        
        // 转发到 JSP 页面渲染
        request.getRequestDispatcher("/user/index.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
