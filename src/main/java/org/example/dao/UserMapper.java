package org.example.dao;

import org.example.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * 用户数据访问接口
 */
public interface UserMapper {
    
    /**
     * 根据 ID 查询用户
     * @param id 用户 ID
     * @return 用户对象
     */
    User findById(@Param("id") Integer id);
    
    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象
     */
    User findByUsername(@Param("username") String username);
    
    /**
     * 根据邮箱查询用户
     * @param email 邮箱
     * @return 用户对象
     */
    User findByEmail(@Param("email") String email);
    
    /**
     * 插入用户（注册）
     * @param user 用户对象
     * @return 影响行数
     */
    int insert(User user);
    
    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 影响行数
     */
    int update(User user);
    
    /**
     * 删除用户
     * @param id 用户 ID
     * @return 影响行数
     */
    int deleteById(@Param("id") Integer id);
    
    /**
     * 查询所有用户
     * @return 用户列表
     */
    List<User> findAll();
    
    /**
     * 根据用户名模糊查询
     * @param keyword 关键词
     * @return 用户列表
     */
    List<User> findByUsernameLike(@Param("keyword") String keyword);
    
    int countAll();
}
