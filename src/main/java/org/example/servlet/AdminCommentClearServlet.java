package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.CommentService;
import org.example.service.impl.CommentServiceImpl;

import java.io.IOException;

/**
 * 管理员清空某电影全部评论 Servlet
 */
@WebServlet(name = "AdminCommentClearServlet", value = "/admin/comment-clear")
public class AdminCommentClearServlet extends HttpServlet {

    private CommentService commentService = new CommentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String movieIdParam = request.getParameter("movieId");
        if (movieIdParam != null && !movieIdParam.trim().isEmpty()) {
            try {
                int movieId = Integer.parseInt(movieIdParam);
                commentService.deleteCommentsByMovieId(movieId);
            } catch (NumberFormatException e) {
                // 非法 ID，忽略
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/comments");
    }
}
