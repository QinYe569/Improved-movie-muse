package org.example.service;

import org.example.entity.Comment;

import java.util.List;

/**
 * 评论服务接口
 */
public interface CommentService {
    
    /**
     * 根据 ID 查询评论
     * @param id 评论 ID
     * @return 评论对象
     */
    Comment findById(Integer id);

    /**
     * 查询所有评论（管理后台使用）
     * @return 评论列表
     */
    List<Comment> findAllForAdmin();
    
    /**
     * 根据电影 ID 查询评论
     * @param movieId 电影 ID
     * @return 评论列表
     */
    List<Comment> findByMovieId(Integer movieId);
    
    /**
     * 添加评论
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @param content 评论内容
     * @return 是否成功
     */
    boolean addComment(Integer userId, Integer movieId, String content);
    
    /**
     * 删除评论
     * @param id 评论 ID
     * @return 是否成功
     */
    boolean deleteComment(Integer id);

    /**
     * 删除电影的所有评论
     * @param movieId 电影 ID
     * @return 是否成功
     */
    boolean deleteCommentsByMovieId(Integer movieId);

    /**
     * 获取电影评论总数
     * @param movieId 电影 ID
     * @return 总数
     */
    int getCountByMovieId(Integer movieId);
    
    /**
     * 根据用户 ID 查询评论
     * @param userId 用户 ID
     * @return 评论列表
     */
    List<Comment> findByUserId(Integer userId);
}
