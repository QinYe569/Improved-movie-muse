package org.example.service;

import org.example.entity.Movie;

import java.util.List;

/**
 * 电影服务接口
 */
public interface MovieService {
    
    /**
     * 根据 ID 查询电影
     * @param id 电影 ID
     * @return 电影对象
     */
    Movie findById(Integer id);
    
    /**
     * 根据标题查询电影
     * @param title 电影标题
     * @return 电影对象
     */
    Movie findByTitle(String title);
    
    /**
     * 查询所有电影（分页）
     * @param page 页码（从 1 开始）
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findAll(int page, int pageSize);

    /**
     * 查询所有电影并按 ID 升序排列（管理后台使用）
     * @param page 页码（从 1 开始）
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findAllOrderById(int page, int pageSize);
    
    /**
     * 查询所有电影（不分页）
     * @return 电影列表
     */
    List<Movie> findAll();
    
    /**
     * 根据分类查询电影（分页）
     * @param categoryId 分类 ID
     * @param page 页码
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findByCategory(Integer categoryId, int page, int pageSize);
    
    /**
     * 搜索电影（分页）
     * @param keyword 关键词
     * @param page 页码
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> searchMovies(String keyword, int page, int pageSize);
    
    /**
     * 获取电影总数
     * @return 总数
     */
    int getTotalCount();
    
    /**
     * 获取分类下的电影总数
     * @param categoryId 分类 ID
     * @return 总数
     */
    int getCountByCategory(Integer categoryId);
    
    /**
     * 获取搜索结果总数
     * @param keyword 关键词
     * @return 总数
     */
    int getSearchCount(String keyword);
    
    /**
     * 添加电影
     * @param movie 电影对象
     * @return 是否成功
     */
    boolean addMovie(Movie movie);
    
    /**
     * 更新电影信息
     * @param movie 电影对象
     * @return 是否成功
     */
    boolean updateMovie(Movie movie);
    
    /**
     * 删除电影
     * @param id 电影 ID
     * @return 是否成功
     */
    boolean deleteMovie(Integer id);

    /**
     * 查询电影关联的分类 ID 列表
     * @param movieId 电影 ID
     * @return 分类 ID 列表
     */
    List<Integer> findCategoryIdsByMovieId(Integer movieId);

    /**
     * 保存电影的分类关联（先删除旧关联，再插入新关联）
     * @param movieId 电影 ID
     * @param categoryIds 分类 ID 列表
     * @return 是否成功
     */
    boolean saveMovieCategories(Integer movieId, List<Integer> categoryIds);

    /**
     * 增加播放次数
     * @param id 电影 ID
     * @return 是否成功
     */
    boolean incrementViewCount(Integer id);
    
    /**
     * 查询评分最高的电影
     * @param page 页码
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findTopRated(int page, int pageSize);
    
    /**
     * 查询评分最高的电影（直接传offset）
     * @param offset 偏移量
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findTopRatedWithOffset(int offset, int pageSize);
    
    /**
     * 查询所有电影（直接传offset）
     * @param offset 偏移量
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findAllWithOffset(int offset, int pageSize);
    
    /**
     * 查询免费电影
     * @param page 页码
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findFreeMovies(int page, int pageSize);
    
    /**
     * 按播放次数查询热门电影
     * @param page 页码
     * @param pageSize 每页数量
     * @return 电影列表
     */
    List<Movie> findByViewCount(int page, int pageSize);
}
