package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Comment;
import org.example.entity.Movie;
import org.example.entity.User;
import org.example.service.CommentService;
import org.example.service.MovieService;
import org.example.service.ViewHistoryService;
import org.example.service.impl.CommentServiceImpl;
import org.example.service.impl.MovieServiceImpl;
import org.example.service.impl.ViewHistoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 电影详情 Servlet（JSP 版本）
 * 支持通过电影名称查询详情
 */
@WebServlet(name = "MovieDetailJspServlet", value = "/user/movie-detail")
public class MovieDetailJspServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    private CommentService commentService = new CommentServiceImpl();
    private ViewHistoryService viewHistoryService = new ViewHistoryServiceImpl();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        User currentUser = null;
        if (session != null) {
            currentUser = (User) session.getAttribute("currentUser");
        }
        
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }
        
        // 优先通过电影名称查询
        String movieTitle = request.getParameter("movie");
        Movie movie = null;
        
        if (movieTitle != null && !movieTitle.trim().isEmpty()) {
            movie = movieService.findByTitle(movieTitle.trim());
        }
        
        // 如果名称没找到，尝试通过 ID 查询
        if (movie == null) {
            String idParam = request.getParameter("id");
            if (idParam != null && !idParam.trim().isEmpty()) {
                try {
                    Integer movieId = Integer.parseInt(idParam);
                    movie = movieService.findById(movieId);
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        }
        
        if (movie == null) {
            response.sendRedirect(request.getContextPath() + "/user/index");
            return;
        }
        
        // 增加播放次数
        movieService.incrementViewCount(movie.getId());
        
        // 记录观看历史
        viewHistoryService.addViewHistory(currentUser.getId(), movie.getId());
        
        // 查询评论列表
        List<Comment> comments = commentService.findByMovieId(movie.getId());
        
        // 查询推荐电影
        List<Movie> recommendMovies = movieService.findAll();
        if (recommendMovies.size() > 6) {
            recommendMovies = recommendMovies.subList(0, 6);
        }
        
        request.setAttribute("currentUser", currentUser);
        request.setAttribute("movie", movie);
        request.setAttribute("comments", comments);
        request.setAttribute("commentCount", comments.size());
        request.setAttribute("recommendMovies", recommendMovies);
        
        request.getRequestDispatcher("/user/movie-detail.jsp").forward(request, response);
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
