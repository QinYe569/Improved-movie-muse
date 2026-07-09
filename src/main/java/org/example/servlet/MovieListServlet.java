package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Category;
import org.example.entity.Movie;
import org.example.entity.User;
import org.example.service.CategoryService;
import org.example.service.MovieService;
import org.example.service.impl.CategoryServiceImpl;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 电影列表 Servlet
 * 支持分页、按评分排序
 */
@WebServlet(name = "MovieListServlet", value = "/user/movie-list")
public class MovieListServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    private CategoryService categoryService = new CategoryServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        String sortBy = request.getParameter("sortBy");
        
        List<Movie> movies;
        int totalCount = movieService.getTotalCount();
        
        int pageSize;
        int offset;
        
        if (page == 1) {
            pageSize = 8;
            offset = 0;
        } else {
            pageSize = 6;
            offset = 8 + (page - 2) * 6;
        }
        
        if ("rating".equals(sortBy)) {
            movies = movieService.findTopRatedWithOffset(offset, pageSize);
        } else {
            movies = movieService.findAllWithOffset(offset, pageSize);
        }
        
        int totalPages;
        if (totalCount <= 8) {
            totalPages = 1;
        } else {
            totalPages = (int) Math.ceil((double) (totalCount - 8) / 6) + 1;
        }
        if (totalPages == 0) totalPages = 1;
        
        List<Category> categories = categoryService.findAll();
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("movies", movies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("sortBy", sortBy);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/user/movie-list.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
