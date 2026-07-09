package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Favorite;
import org.example.entity.Movie;
import org.example.entity.User;
import org.example.service.FavoriteService;
import org.example.service.impl.FavoriteServiceImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

/**
 * 收藏列表 Servlet（JSP 版本）
 */
@WebServlet(name = "FavoriteListServlet", value = "/user/favorite")
public class FavoriteListServlet extends HttpServlet {
    
    private FavoriteService favoriteService = new FavoriteServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        // 获取用户的收藏列表
        List<Favorite> favorites = favoriteService.findByUserId(currentUser.getId());
        
        // 提取收藏的电影对象
        List<Movie> movies = new ArrayList<>();
        for (Favorite fav : favorites) {
            if (fav.getMovie() != null) {
                movies.add(fav.getMovie());
            }
        }
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("movies", movies);
        request.setAttribute("favorites", favorites);
        
        request.getRequestDispatcher("/user/favorite.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
