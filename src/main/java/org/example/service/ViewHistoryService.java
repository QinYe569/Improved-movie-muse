package org.example.service;

import org.example.entity.ViewHistory;

import java.util.List;

/**
 * 观看历史服务接口
 */
public interface ViewHistoryService {

    /**
     * 根据用户 ID 查询观看历史
     * @param userId 用户 ID
     * @return 观看历史列表（含关联电影信息）
     */
    List<ViewHistory> findByUserId(Integer userId);

    /**
     * 添加观看历史记录（如果已存在则更新观看时间）
     * @param userId  用户 ID
     * @param movieId 电影 ID
     * @return 是否成功
     */
    boolean addViewHistory(Integer userId, Integer movieId);

    /**
     * 删除一条观看历史
     * @param id 记录 ID
     * @return 是否成功
     */
    boolean deleteViewHistory(Integer id);

    /**
     * 清空某用户的所有观看历史
     * @param userId 用户 ID
     * @return 是否成功
     */
    boolean clearViewHistory(Integer userId);
}
