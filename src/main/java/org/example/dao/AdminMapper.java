package org.example.dao;

import org.example.entity.Admin;
import org.apache.ibatis.annotations.Param;

/**
 * 管理员数据访问接口
 */
public interface AdminMapper {
    
    /**
     * 根据 ID 查询管理员
     * @param id 管理员 ID
     * @return 管理员对象
     */
    Admin findById(@Param("id") Integer id);
    
    /**
     * 根据用户名查询管理员
     * @param username 用户名
     * @return 管理员对象
     */
    Admin findByUsername(@Param("username") String username);
    
    /**
     * 插入管理员
     * @param admin 管理员对象
     * @return 影响行数
     */
    int insert(Admin admin);
    
    /**
     * 更新管理员信息
     * @param admin 管理员对象
     * @return 影响行数
     */
    int update(Admin admin);
    
    /**
     * 删除管理员
     * @param id 管理员 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);
}
