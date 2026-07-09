package org.example.service;

import org.example.entity.SearchHistory;

import java.util.List;

/**
 * 搜索历史服务接口
 */
public interface SearchHistoryService {

    /**
     * 根据用户 ID 查询搜索历史
     * @param userId 用户 ID
     * @return 搜索历史列表
     */
    List<SearchHistory> findByUserId(Integer userId);

    /**
     * 添加搜索历史记录
     * @param userId  用户 ID
     * @param keyword 搜索关键词
     * @return 是否成功
     */
    boolean addSearchHistory(Integer userId, String keyword);

    /**
     * 删除一条搜索历史
     * @param id 记录 ID
     * @return 是否成功
     */
    boolean deleteSearchHistory(Integer id);

    /**
     * 清空某用户的所有搜索历史
     * @param userId 用户 ID
     * @return 是否成功
     */
    boolean clearSearchHistory(Integer userId);
}
