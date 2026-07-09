package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.FavoriteService;
import org.example.service.MovieService;
import org.example.service.UserService;
import org.example.service.impl.FavoriteServiceImpl;
import org.example.service.impl.MovieServiceImpl;
import org.example.service.impl.UserServiceImpl;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * 管理员控制台 Servlet
 */
@WebServlet(name = "AdminDashboardServlet", value = "/admin/dashboard")
public class AdminDashboardServlet extends HttpServlet {

    private MovieService movieService = new MovieServiceImpl();
    private UserService userService = new UserServiceImpl();
    private FavoriteService favoriteService = new FavoriteServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        // 获取统计数据
        int totalMovies = movieService.getTotalCount();
        int totalUsers = userService.getTotalCount();
        List<Map<String, Object>> favoriteStats = favoriteService.getFavoriteCountByMovie();

        request.setAttribute("totalMovies", totalMovies);
        request.setAttribute("totalUsers", totalUsers);
        request.setAttribute("favoriteStats", favoriteStats);

        request.getRequestDispatcher("/admin/admin-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
