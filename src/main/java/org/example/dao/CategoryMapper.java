package org.example.dao;

import org.example.entity.Category;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 分类数据访问接口
 */
public interface CategoryMapper {
    
    /**
     * 根据 ID 查询分类
     * @param id 分类 ID
     * @return 分类对象
     */
    Category findById(@Param("id") Integer id);
    
    /**
     * 根据名称查询分类
     * @param name 分类名称
     * @return 分类对象
     */
    Category findByName(@Param("name") String name);
    
    /**
     * 查询所有分类
     * @return 分类列表
     */
    List<Category> findAll();

    /**
     * 查询所有分类（管理后台使用，包含禁用状态）
     * @return 分类列表
     */
    List<Category> findAllForAdmin();
    
    /**
     * 插入分类
     * @param category 分类对象
     * @return 影响行数
     */
    int insert(Category category);
    
    /**
     * 更新分类
     * @param category 分类对象
     * @return 影响行数
     */
    int update(Category category);
    
    /**
     * 删除分类
     * @param id 分类 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);
}
