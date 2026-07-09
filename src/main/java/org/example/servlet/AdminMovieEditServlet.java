package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.Category;
import org.example.entity.Movie;
import org.example.service.CategoryService;
import org.example.service.MovieService;
import org.example.service.impl.CategoryServiceImpl;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * 管理员电影编辑 Servlet
 */
@WebServlet(name = "AdminMovieEditServlet", value = "/admin/movie-edit")
public class AdminMovieEditServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
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
        
        List<Category> categories = categoryService.findAll();
        request.setAttribute("categories", categories);

        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                int id = Integer.parseInt(idParam);
                Movie movie = movieService.findById(id);
                if (movie != null) {
                    request.setAttribute("movie", movie);
                    request.setAttribute("editMode", true);
                    request.setAttribute("selectedCategoryIds", movieService.findCategoryIdsByMovieId(id));
                } else {
                    request.setAttribute("errorMessage", "电影不存在");
                    request.setAttribute("editMode", false);
                }
            } catch (NumberFormatException e) {
                request.setAttribute("errorMessage", "无效的电影ID");
                request.setAttribute("editMode", false);
            }
        } else {
            request.setAttribute("editMode", false);
        }

        request.setAttribute("currentAdmin", currentAdmin);
        request.getRequestDispatcher("/admin/admin-movie-edit.jsp").forward(request, response);
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
        String title = request.getParameter("title");
        String poster = request.getParameter("poster");
        String description = request.getParameter("description");
        String director = request.getParameter("director");
        String releaseYearStr = request.getParameter("releaseYear");
        String runtimeStr = request.getParameter("runtime");
        String ratingStr = request.getParameter("rating");
        String viewCountStr = request.getParameter("viewCount");
        String videoUrl = request.getParameter("videoUrl");
        String statusStr = request.getParameter("status");
        String[] categoryIds = request.getParameterValues("categoryIds");

        Movie movie = new Movie();
        movie.setTitle(title);
        movie.setPoster(poster);
        movie.setDescription(description);
        movie.setDirector(director);
        
        if (releaseYearStr != null && !releaseYearStr.trim().isEmpty()) {
            try {
                movie.setReleaseYear(Integer.parseInt(releaseYearStr));
            } catch (NumberFormatException e) {
                movie.setReleaseYear(null);
            }
        }
        
        if (runtimeStr != null && !runtimeStr.trim().isEmpty()) {
            try {
                movie.setRuntime(Integer.parseInt(runtimeStr));
            } catch (NumberFormatException e) {
                movie.setRuntime(null);
            }
        }

        if (ratingStr != null && !ratingStr.trim().isEmpty()) {
            try {
                movie.setRating(Double.parseDouble(ratingStr));
            } catch (NumberFormatException e) {
                movie.setRating(null);
            }
        }

        if (viewCountStr != null && !viewCountStr.trim().isEmpty()) {
            try {
                movie.setViewCount(Integer.parseInt(viewCountStr));
            } catch (NumberFormatException e) {
                movie.setViewCount(null);
            }
        }

        // 如果用户粘贴的是 iframe 嵌入代码，提取其中的 src URL
        String extractedVideoUrl = extractVideoUrl(videoUrl);
        movie.setVideoUrl(extractedVideoUrl);

        // 有视频地址/嵌入代码则设为免费可播放，否则为付费/无片源
        if (extractedVideoUrl != null && !extractedVideoUrl.trim().isEmpty()) {
            movie.setIsFree(1);
        } else {
            movie.setIsFree(0);
        }

        if (statusStr != null) {
            movie.setStatus(Integer.parseInt(statusStr));
        } else {
            movie.setStatus(1);
        }
        
        boolean success;
        if (idParam != null && !idParam.trim().isEmpty()) {
            try {
                movie.setId(Integer.parseInt(idParam));
                success = movieService.updateMovie(movie);
            } catch (NumberFormatException e) {
                success = false;
            }
        } else {
            success = movieService.addMovie(movie);
        }
        
        if (success) {
            // 保存电影分类关联
            List<Integer> selectedCategoryIds = new ArrayList<>();
            if (categoryIds != null) {
                for (String cid : categoryIds) {
                    try {
                        selectedCategoryIds.add(Integer.parseInt(cid));
                    } catch (NumberFormatException e) {
                        // 忽略非法值
                    }
                }
            }
            movieService.saveMovieCategories(movie.getId(), selectedCategoryIds);
            response.sendRedirect(request.getContextPath() + "/admin/movies");
        } else {
            request.setAttribute("errorMessage", "保存电影失败");
            request.setAttribute("movie", movie);
            request.setAttribute("editMode", idParam != null && !idParam.trim().isEmpty());
            request.setAttribute("categories", categoryService.findAll());
            request.setAttribute("currentAdmin", session.getAttribute("currentAdmin"));
            request.getRequestDispatcher("/admin/admin-movie-edit.jsp").forward(request, response);
        }
    }

    /**
     * 从 iframe 嵌入代码中提取 src URL；如果本身就是普通 URL 则直接返回。
     */
    private String extractVideoUrl(String input) {
        if (input == null || input.trim().isEmpty()) {
            return null;
        }
        String trimmed = input.trim();
        // 若包含 iframe 标签，提取 src 属性值
        if (trimmed.toLowerCase().contains("<iframe")) {
            Pattern pattern = Pattern.compile("src=[\"']([^\"']+)[\"']", Pattern.CASE_INSENSITIVE);
            Matcher matcher = pattern.matcher(trimmed);
            if (matcher.find()) {
                return matcher.group(1).trim();
            }
            return null;
        }
        return trimmed;
    }
}
