package org.example.service;

import org.example.entity.Admin;

/**
 * 管理员服务接口
 */
public interface AdminService {
    
    /**
     * 管理员登录
     * @param username 用户名
     * @param password 密码
     * @return 登录成功的管理员对象，失败返回 null
     */
    Admin login(String username, String password);
    
    /**
     * 根据 ID 查询管理员
     * @param id 管理员 ID
     * @return 管理员对象
     */
    Admin findById(Integer id);
    
    /**
     * 根据用户名查询管理员
     * @param username 用户名
     * @return 管理员对象
     */
    Admin findByUsername(String username);
}
