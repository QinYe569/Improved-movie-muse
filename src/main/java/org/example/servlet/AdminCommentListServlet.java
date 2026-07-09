package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.Comment;
import org.example.entity.Movie;
import org.example.service.CommentService;
import org.example.service.impl.CommentServiceImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 管理员评论列表 Servlet
 */
@WebServlet(name = "AdminCommentListServlet", value = "/admin/comments")
public class AdminCommentListServlet extends HttpServlet {

    private CommentService commentService = new CommentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        List<Comment> comments = commentService.findAllForAdmin();

        List<Map<String, Object>> movieGroups = new ArrayList<>();
        Movie currentMovie = null;
        List<Comment> currentComments = new ArrayList<>();

        for (Comment comment : comments) {
            Movie movie = comment.getMovie();
            if (currentMovie == null || !currentMovie.getId().equals(movie.getId())) {
                if (currentMovie != null) {
                    Map<String, Object> group = new HashMap<>();
                    group.put("movie", currentMovie);
                    group.put("comments", currentComments);
                    movieGroups.add(group);
                }
                currentMovie = movie;
                currentComments = new ArrayList<>();
            }
            currentComments.add(comment);
        }

        if (currentMovie != null && !currentComments.isEmpty()) {
            Map<String, Object> group = new HashMap<>();
            group.put("movie", currentMovie);
            group.put("comments", currentComments);
            movieGroups.add(group);
        }

        request.setAttribute("movieGroups", movieGroups);
        request.setAttribute("commentCount", comments.size());
        request.setAttribute("currentAdmin", currentAdmin);
        request.getRequestDispatcher("/admin/admin-comments.jsp").forward(request, response);
    }
}
