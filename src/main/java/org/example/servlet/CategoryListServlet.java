package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Category;
import org.example.entity.User;
import org.example.service.CategoryService;
import org.example.service.impl.CategoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 分类列表 Servlet
 */
@WebServlet(name = "CategoryListServlet", value = "/user/categories")
public class CategoryListServlet extends HttpServlet {
    
    private CategoryService categoryService = new CategoryServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        List<Category> categories = categoryService.findAll();
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("categories", categories);
        
        request.getRequestDispatcher("/user/categories.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
