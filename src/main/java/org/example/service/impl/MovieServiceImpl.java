package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.MovieMapper;
import org.example.entity.Movie;
import org.example.service.MovieService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 电影服务实现类
 */
public class MovieServiceImpl implements MovieService {
    
    @Override
    public Movie findById(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findById(id);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public Movie findByTitle(String title) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findByTitle(title);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findAll(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findAll(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public List<Movie> findAllOrderById(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findAllOrderById(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findAll() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findByCategory(Integer categoryId, int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findByCategory(categoryId, offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> searchMovies(String keyword, int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.searchByTitle(keyword, offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public int getTotalCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.countAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public int getCountByCategory(Integer categoryId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.countByCategory(categoryId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public int getSearchCount(String keyword) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.countSearch(keyword);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean addMovie(Movie movie) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int result = mapper.insert(movie);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean updateMovie(Movie movie) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int result = mapper.update(movie);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean deleteMovie(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int result = mapper.deleteById(id);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public List<Integer> findCategoryIdsByMovieId(Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findCategoryIdsByMovieId(movieId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean saveMovieCategories(Integer movieId, List<Integer> categoryIds) {
        if (movieId == null) {
            return false;
        }
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            mapper.deleteMovieCategoriesByMovieId(movieId);
            if (categoryIds != null) {
                for (Integer categoryId : categoryIds) {
                    if (categoryId != null) {
                        mapper.insertMovieCategory(movieId, categoryId);
                    }
                }
            }
            session.commit();
            return true;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean incrementViewCount(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int result = mapper.incrementViewCount(id);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findTopRated(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findTopRated(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findTopRatedWithOffset(int offset, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findTopRated(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findAllWithOffset(int offset, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            return mapper.findAll(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findFreeMovies(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findFreeMovies(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Movie> findByViewCount(int page, int pageSize) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            MovieMapper mapper = session.getMapper(MovieMapper.class);
            int offset = (page - 1) * pageSize;
            return mapper.findByViewCount(offset, pageSize);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
