package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.service.CategoryService;
import org.example.service.impl.CategoryServiceImpl;

import java.io.IOException;

/**
 * 管理员删除分类 Servlet
 */
@WebServlet(name = "AdminCategoryDeleteServlet", value = "/admin/category-delete")
public class AdminCategoryDeleteServlet extends HttpServlet {

    private CategoryService categoryService = new CategoryServiceImpl();

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
                categoryService.deleteCategory(id);
            } catch (NumberFormatException e) {
                // 非法 ID，忽略
            }
        }

        response.sendRedirect(request.getContextPath() + "/admin/categories");
    }
}
