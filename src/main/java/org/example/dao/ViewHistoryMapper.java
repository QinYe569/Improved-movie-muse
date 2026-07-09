package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.ViewHistory;

import java.util.List;

/**
 * 观看历史数据访问接口
 */
public interface ViewHistoryMapper {

    /**
     * 根据用户 ID 查询观看历史
     * @param userId 用户 ID
     * @return 观看历史列表（含关联电影信息）
     */
    List<ViewHistory> findByUserId(@Param("userId") Integer userId);

    /**
     * 插入观看历史
     * @param viewHistory 观看历史对象
     * @return 影响行数
     */
    int insert(ViewHistory viewHistory);

    /**
     * 根据 ID 删除观看历史
     * @param id 记录 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 清空某用户的所有观看历史
     * @param userId 用户 ID
     * @return 影响行数
     */
    int clearByUserId(@Param("userId") Integer userId);

    /**
     * 根据用户 ID 和电影 ID 查询观看历史
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 观看历史对象，不存在则返回 null
     */
    ViewHistory findByUserIdAndMovieId(@Param("userId") Integer userId,
                                       @Param("movieId") Integer movieId);

    /**
     * 更新某用户某部电影的观看时间
     * @param userId 用户 ID
     * @param movieId 电影 ID
     * @return 影响行数
     */
    int updateViewTime(@Param("userId") Integer userId,
                       @Param("movieId") Integer movieId);
}
