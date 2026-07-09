package org.example.service;

import org.example.entity.Favorite;

import java.util.List;

/**
 * 收藏服务接口
 */
public interface FavoriteService {
    
    /**
     * 根据用户 ID 查询收藏
     * @param userId 用户 ID
     * @return 收藏列表
     */
    List<Favorite> findByUserId(Integer userId);
    
    /**
     * 添加收藏
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 是否成功
     */
    boolean addFavorite(Integer userId, Integer movieId);
    
    /**
     * 取消收藏
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 是否成功
     */
    boolean removeFavorite(Integer userId, Integer movieId);
    
    /**
     * 检查是否已收藏
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 是否已收藏
     */
    boolean isFavorited(Integer userId, Integer movieId);
    
    /**
     * 获取某用户的收藏总数
     * @param userId 用户 ID
     * @return 收藏数
     */
    int getCountByUserId(Integer userId);

    /**
     * 获取各电影的收藏数量统计
     * @return 收藏统计列表
     */
    java.util.List<java.util.Map<String, Object>> getFavoriteCountByMovie();
}
