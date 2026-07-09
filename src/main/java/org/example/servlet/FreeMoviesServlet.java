package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Movie;
import org.example.entity.User;
import org.example.service.MovieService;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 免费专区 Servlet
 */
@WebServlet(name = "FreeMoviesServlet", value = "/user/free-zone")
public class FreeMoviesServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        List<Movie> freeMovies = movieService.findFreeMovies(1, 100);
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("freeMovies", freeMovies);
        
        request.getRequestDispatcher("/user/free-zone.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
