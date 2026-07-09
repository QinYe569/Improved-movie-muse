package org.example.service;

import org.example.entity.Category;

import java.util.List;

/**
 * 分类服务接口
 */
public interface CategoryService {
    
    /**
     * 根据 ID 查询分类
     * @param id 分类 ID
     * @return 分类对象
     */
    Category findById(Integer id);
    
    /**
     * 根据名称查询分类
     * @param name 分类名称
     * @return 分类对象
     */
    Category findByName(String name);
    
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
     * 添加分类
     * @param category 分类对象
     * @return 是否成功
     */
    boolean addCategory(Category category);
    
    /**
     * 更新分类
     * @param category 分类对象
     * @return 是否成功
     */
    boolean updateCategory(Category category);
    
    /**
     * 删除分类
     * @param id 分类 ID
     * @return 是否成功
     */
    boolean deleteCategory(Integer id);
}
