package org.example.dao;

import org.example.entity.Comment;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 评论数据访问接口
 */
public interface CommentMapper {
    
    /**
     * 根据 ID 查询评论
     * @param id 评论 ID
     * @return 评论对象
     */
    Comment findById(@Param("id") Integer id);

    /**
     * 查询所有评论（管理后台使用，包含已删除/禁用状态）
     * @return 评论列表
     */
    List<Comment> findAllForAdmin();
    
    /**
     * 根据电影 ID 查询评论
     * @param movieId 电影 ID
     * @return 评论列表
     */
    List<Comment> findByMovieId(@Param("movieId") Integer movieId);
    
    /**
     * 根据用户 ID 查询评论
     * @param userId 用户 ID
     * @return 评论列表
     */
    List<Comment> findByUserId(@Param("userId") Integer userId);
    
    /**
     * 插入评论
     * @param comment 评论对象
     * @return 影响行数
     */
    int insert(Comment comment);
    
    /**
     * 删除评论
     * @param id 评论 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 根据电影 ID 删除评论
     * @param movieId 电影 ID
     * @return 影响行数
     */
    int deleteByMovieId(@Param("movieId") Integer movieId);
    
    /**
     * 获取电影评论总数
     * @param movieId 电影 ID
     * @return 总数
     */
    int countByMovieId(@Param("movieId") Integer movieId);
}
