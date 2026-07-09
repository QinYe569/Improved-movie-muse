package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.MovieService;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;

/**
 * 管理员删除电影 Servlet
 */
@WebServlet(name = "AdminMovieDeleteServlet", value = "/admin/movie-delete")
public class AdminMovieDeleteServlet extends HttpServlet {

    private MovieService movieService = new MovieServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/admin/movies");
            return;
        }

        try {
            int id = Integer.parseInt(idParam);
            movieService.deleteMovie(id);
        } catch (NumberFormatException e) {
            // 非法 ID，直接返回列表
        }

        response.sendRedirect(request.getContextPath() + "/admin/movies");
    }
}
