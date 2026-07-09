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
 * 管理员删除评论 Servlet
 */
@WebServlet(name = "AdminCommentDeleteServlet", value = "/admin/comment-delete")
public class AdminCommentDeleteServlet extends HttpServlet {

    private CommentService commentService = new CommentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String idParam = request.getParameter("id");
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                commentService.deleteComment(id);
            } catch (NumberFormatException e) {
                // 非法 ID，忽略
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/comments");
    }
}
