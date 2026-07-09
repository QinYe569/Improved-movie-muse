package org.example.dao;

import org.example.entity.Movie;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 电影数据访问接口
 */
public interface MovieMapper {
    
    /**
     * 根据 ID 查询电影
     * @param id 电影 ID
     * @return 电影对象
     */
    Movie findById(@Param("id") Integer id);
    
    /**
     * 根据标题查询电影
     * @param title 电影标题
     * @return 电影对象
     */
    Movie findByTitle(@Param("title") String title);
    
    /**
     * 查询所有电影（分页）
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findAll(@Param("offset") int offset, @Param("limit") int limit);

    /**
     * 查询所有电影并按 ID 升序排列（管理后台使用）
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findAllOrderById(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 查询所有电影（不分页）
     * @return 电影列表
     */
    List<Movie> findAll();
    
    /**
     * 根据分类 ID 查询电影
     * @param categoryId 分类 ID
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findByCategory(@Param("categoryId") Integer categoryId, 
                               @Param("offset") int offset, 
                               @Param("limit") int limit);
    
    /**
     * 根据标题模糊查询
     * @param keyword 关键词
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> searchByTitle(@Param("keyword") String keyword, 
                              @Param("offset") int offset, 
                              @Param("limit") int limit);
    
    /**
     * 获取电影总数
     * @return 总数
     */
    int countAll();
    
    /**
     * 获取分类下的电影总数
     * @param categoryId 分类 ID
     * @return 总数
     */
    int countByCategory(@Param("categoryId") Integer categoryId);
    
    /**
     * 获取搜索结果总数
     * @param keyword 关键词
     * @return 总数
     */
    int countSearch(@Param("keyword") String keyword);
    
    /**
     * 插入电影
     * @param movie 电影对象
     * @return 影响行数
     */
    int insert(Movie movie);
    
    /**
     * 更新电影信息
     * @param movie 电影对象
     * @return 影响行数
     */
    int update(Movie movie);
    
    /**
     * 删除电影
     * @param id 电影 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 查询电影关联的分类 ID 列表
     * @param movieId 电影 ID
     * @return 分类 ID 列表
     */
    List<Integer> findCategoryIdsByMovieId(@Param("movieId") Integer movieId);

    /**
     * 插入电影分类关联
     * @param movieId 电影 ID
     * @param categoryId 分类 ID
     * @return 影响行数
     */
    int insertMovieCategory(@Param("movieId") Integer movieId, @Param("categoryId") Integer categoryId);

    /**
     * 删除电影的所有分类关联
     * @param movieId 电影 ID
     * @return 影响行数
     */
    int deleteMovieCategoriesByMovieId(@Param("movieId") Integer movieId);

    /**
     * 更新播放次数
     * @param id 电影 ID
     * @return 影响行数
     */
    int incrementViewCount(@Param("id") Integer id);
    
    /**
     * 查询评分最高的电影（分页）
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findTopRated(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 查询免费电影
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findFreeMovies(@Param("offset") int offset, @Param("limit") int limit);
    
    /**
     * 按播放次数查询热门电影（分页）
     * @param offset 偏移量
     * @param limit 每页数量
     * @return 电影列表
     */
    List<Movie> findByViewCount(@Param("offset") int offset, @Param("limit") int limit);
}
