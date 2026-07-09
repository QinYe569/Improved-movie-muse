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

/**
 * 分类电影列表 Servlet
 */
@WebServlet(name = "CategoryMoviesServlet", value = "/user/category-movies")
public class CategoryMoviesServlet extends HttpServlet {
    
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
        
        // 获取分类 ID
        Integer categoryId = null;
        try {
            categoryId = Integer.parseInt(request.getParameter("categoryId"));
        } catch (NumberFormatException e) {
            // 没有分类 ID，跳转到分类列表页
            response.sendRedirect(request.getContextPath() + "/user/categories");
            return;
        }
        
        // 获取分页参数
        int page = 1;
        try {
            page = Integer.parseInt(request.getParameter("page"));
            if (page < 1) page = 1;
        } catch (NumberFormatException e) {
            page = 1;
        }
        
        int pageSize = 20;
        List<Movie> movies = movieService.findByCategory(categoryId, page, pageSize);
        int totalCount = movieService.getCountByCategory(categoryId);
        int totalPages = (int) Math.ceil((double) totalCount / pageSize);
        if (totalPages == 0) totalPages = 1;
        
        // 获取当前分类信息
        Category currentCategory = categoryService.findById(categoryId);
        // 获取所有分类
        List<Category> categories = categoryService.findAll();
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("movies", movies);
        request.setAttribute("currentCategory", currentCategory);
        request.setAttribute("categories", categories);
        request.setAttribute("categoryId", categoryId);
        request.setAttribute("currentPage", page);
        request.setAttribute("totalPages", totalPages);
        
        request.getRequestDispatcher("/user/category-movies.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
