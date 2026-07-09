package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.Movie;
import org.example.service.MovieService;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 管理员电影列表 Servlet
 */
@WebServlet(name = "AdminMovieListServlet", value = "/admin/movies")
public class AdminMovieListServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    private static final int PAGE_SIZE = 10;
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }
        
        int page = 1;
        try {
            String pageParam = request.getParameter("page");
            if (pageParam != null) {
                page = Integer.parseInt(pageParam);
                if (page < 1) page = 1;
            }
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        List<Movie> movies = movieService.findAllOrderById(page, PAGE_SIZE);
        int totalCount = movieService.getTotalCount();
        int totalPages = (int) Math.ceil((double) totalCount / PAGE_SIZE);
        if (totalPages == 0) totalPages = 1;
        
        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        
        request.setAttribute("currentAdmin", currentAdmin);
        request.setAttribute("movies", movies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        
        request.getRequestDispatcher("/admin/admin-movies.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
