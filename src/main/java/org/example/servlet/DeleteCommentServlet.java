package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.service.CommentService;
import org.example.service.impl.CommentServiceImpl;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet(name = "DeleteCommentServlet", value = "/user/comment/delete")
public class DeleteCommentServlet extends HttpServlet {

    private CommentService commentService = new CommentServiceImpl();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            out.write("{\"success\":false}");
            return;
        }
        
        String idStr = request.getParameter("id");
        if (idStr == null || idStr.isEmpty()) {
            out.write("{\"success\":false}");
            return;
        }
        
        try {
            int id = Integer.parseInt(idStr);
            boolean success = commentService.deleteComment(id);
            out.write("{\"success\":" + success + "}");
        } catch (NumberFormatException e) {
            out.write("{\"success\":false}");
        }
    }
}
