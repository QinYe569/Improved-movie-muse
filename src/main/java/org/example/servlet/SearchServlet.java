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

@WebServlet(name = "SearchServlet", value = "/search")
public class SearchServlet extends HttpServlet {

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

        String keyword = request.getParameter("q");
        if (keyword == null) {
            keyword = "";
        }
        keyword = keyword.trim();

        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (NumberFormatException e) {
            page = 1;
        }

        int pageSize = 12;
        List<Movie> movies;
        int totalCount;

        if (keyword.isEmpty()) {
            movies = movieService.findAll(page, pageSize);
            totalCount = movieService.getTotalCount();
        } else {
            movies = movieService.searchMovies(keyword, page, pageSize);
            totalCount = movieService.getSearchCount(keyword);
        }

        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        if (totalPages == 0) totalPages = 1;

        List<Category> categories = categoryService.findAll();

        request.setAttribute("keyword", keyword);
        request.setAttribute("movies", movies);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        request.setAttribute("totalCount", totalCount);
        request.setAttribute("categories", categories);
        request.setAttribute("currentUser", currentUser);

        request.getRequestDispatcher("/search.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
