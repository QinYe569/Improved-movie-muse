package org.example.dao;

import org.example.entity.Favorite;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 收藏数据访问接口
 */
public interface FavoriteMapper {
    
    /**
     * 根据 ID 查询收藏
     * @param id 收藏 ID
     * @return 收藏对象
     */
    Favorite findById(@Param("id") Integer id);
    
    /**
     * 根据用户 ID 查询收藏
     * @param userId 用户 ID
     * @return 收藏列表
     */
    List<Favorite> findByUserId(@Param("userId") Integer userId);
    
    /**
     * 检查用户是否已收藏某电影
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 收藏对象，未收藏返回 null
     */
    Favorite findByUserIdAndMovieId(@Param("userId") Integer userId, 
                                    @Param("movieId") Integer movieId);
    
    /**
     * 插入收藏
     * @param favorite 收藏对象
     * @return 影响行数
     */
    int insert(Favorite favorite);
    
    /**
     * 删除收藏
     * @param id 收藏 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 根据用户 ID 和电影 ID 删除收藏
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 影响行数
     */
    int deleteByUserIdAndMovieId(@Param("userId") Integer userId, 
                                 @Param("movieId") Integer movieId);
    
    /**
     * 获取用户收藏总数
     * @param userId 用户 ID
     * @return 总数
     */
    int countByUserId(@Param("userId") Integer userId);
    
    java.util.List<java.util.Map<String, Object>> countByMovie();
}
