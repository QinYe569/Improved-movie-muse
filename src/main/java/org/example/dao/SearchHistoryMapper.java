package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.SearchHistory;

import java.util.List;

/**
 * 搜索历史数据访问接口
 */
public interface SearchHistoryMapper {

    /**
     * 根据用户 ID 查询搜索历史
     * @param userId 用户 ID
     * @return 搜索历史列表
     */
    List<SearchHistory> findByUserId(@Param("userId") Integer userId);

    /**
     * 插入搜索历史
     * @param searchHistory 搜索历史对象
     * @return 影响行数
     */
    int insert(SearchHistory searchHistory);

    /**
     * 根据 ID 删除搜索历史
     * @param id 记录 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);

    /**
     * 清空某用户的所有搜索历史
     * @param userId 用户 ID
     * @return 影响行数
     */
    int clearByUserId(@Param("userId") Integer userId);
}
