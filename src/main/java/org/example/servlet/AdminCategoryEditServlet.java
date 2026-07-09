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

/**
 * 管理员分类添加/编辑 Servlet
 */
@WebServlet(name = "AdminCategoryEditServlet", value = "/admin/category-edit")
public class AdminCategoryEditServlet extends HttpServlet {

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
        Admin currentAdmin = (Admin) session.getAttribute("currentAdmin");

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Category category = categoryService.findById(id);
                if (category != null) {
                    request.setAttribute("category", category);
                    request.setAttribute("editMode", true);
                } else {
                    request.setAttribute("errorMessage", "分类不存在");
                    request.setAttribute("editMode", false);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "无效的分类ID");
                request.setAttribute("editMode", false);
            }
        } else {
            request.setAttribute("editMode", false);
        }

        request.setAttribute("currentAdmin", currentAdmin);
        request.getRequestDispatcher("/admin/admin-category-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        request.setCharacterEncoding("UTF-8");

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String icon = request.getParameter("icon");
        String description = request.getParameter("description");
        String sortOrderStr = request.getParameter("sortOrder");
        String statusStr = request.getParameter("status");

        if (name == null || name.trim().isEmpty()) {
            request.setAttribute("errorMessage", "分类名称不能为空");
            request.setAttribute("editMode", idParam != null && !idParam.trim().isEmpty());
            request.setAttribute("currentAdmin", session.getAttribute("currentAdmin"));
            request.getRequestDispatcher("/admin/admin-category-edit.jsp").forward(request, response);
            return;
        }

        Category category = new Category();
        category.setName(name.trim());
        category.setIcon(icon);
        category.setDescription(description);

        if (sortOrderStr != null && !sortOrderStr.trim().isEmpty()) {
            try {
                category.setSortOrder(Integer.parseInt(sortOrderStr));
            } catch (NumberFormatException e) {
                category.setSortOrder(0);
            }
        } else {
            category.setSortOrder(0);
        }

        if (statusStr != null) {
            category.setStatus(Integer.parseInt(statusStr));
        } else {
            category.setStatus(1);
        }

        boolean success;
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                category.setId(Integer.parseInt(idParam));
                success = categoryService.updateCategory(category);
            } catch (NumberFormatException e) {
                success = false;
            }
        } else {
            success = categoryService.addCategory(category);
        }

        if (success) {
            response.sendRedirect(request.getContextPath() + "/admin/categories");
        } else {
            request.setAttribute("errorMessage", "保存分类失败");
            request.setAttribute("category", category);
            request.setAttribute("editMode", idParam != null && !idParam.trim().isEmpty());
            request.setAttribute("currentAdmin", session.getAttribute("currentAdmin"));
            request.getRequestDispatcher("/admin/admin-category-edit.jsp").forward(request, response);
        }
    }
}
