package org.example.servlet;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.Movie;
import org.example.service.MovieService;
import org.example.service.impl.MovieServiceImpl;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 电影详情 Servlet
 */
@WebServlet(name = "MovieDetailServlet", value = "/api/movie-detail")
public class MovieDetailServlet extends HttpServlet {
    
    private MovieService movieService = new MovieServiceImpl();
    private Gson gson = new Gson();
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        response.setContentType("application/json;charset=UTF-8");
        
        // 获取电影名称参数
        String movieTitle = request.getParameter("movie");
        
        Map<String, Object> result = new HashMap<>();
        
        if (movieTitle == null || movieTitle.trim().isEmpty()) {
            result.put("success", false);
            result.put("message", "电影名称不能为空");
            response.getWriter().write(gson.toJson(result));
            return;
        }
        
        // 查询电影详情
        Movie movie = movieService.findByTitle(movieTitle.trim());
        
        if (movie != null) {
            // 增加播放次数（异步，不等待结果）
            movieService.incrementViewCount(movie.getId());
            
            result.put("success", true);
            result.put("movie", movie);
        } else {
            result.put("success", false);
            result.put("message", "电影不存在");
        }
        
        response.getWriter().write(gson.toJson(result));
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}
