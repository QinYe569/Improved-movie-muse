package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.Category;
import org.example.service.CategoryService;
import org.example.service.impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 管理员分类列表 Servlet
 */
@WebServlet(name = "AdminCategoryListServlet", value = "/admin/categories")
public class AdminCategoryListServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");
        List<Category> categories = categoryService.findAllForAdmin();

        request.setAttribute("categories", categories);
        request.setAttribute("currentAdmin", currentAdmin);
        request.getRequestDispatcher("/admin/admin-categories.jsp").forward(request, response);
    }
}
