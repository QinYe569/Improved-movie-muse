package org.example.service;

import org.example.entity.User;

import java.util.List;

/**
 * 用户服务接口
 */
public interface UserService {
    
    /**
     * 用户登录
     * @param username 用户名
     * @param password 密码
     * @return 登录成功的用户对象，失败返回 null
     */
    User login(String username, String password);
    
    /**
     * 用户注册
     * @param user 用户对象
     * @return 是否成功
     */
    boolean register(User user);
    
    /**
     * 根据 ID 查询用户
     * @param id 用户 ID
     * @return 用户对象
     */
    User findById(Integer id);
    
    /**
     * 根据用户名查询用户
     * @param username 用户名
     * @return 用户对象
     */
    User findByUsername(String username);
    
    /**
     * 检查用户名是否存在
     * @param username 用户名
     * @return 是否存在
     */
    boolean isUsernameExist(String username);
    
    /**
     * 检查邮箱是否已注册
     * @param email 邮箱
     * @return 是否已注册
     */
    boolean isEmailExist(String email);
    
    /**
     * 更新用户信息
     * @param user 用户对象
     * @return 是否成功
     */
    boolean updateUser(User user);

    /**
     * 删除用户
     * @param id 用户 ID
     * @return 是否成功
     */
    boolean deleteUser(Integer id);

    /**
     * 修改密码
     * @param userId 用户 ID
     * @param oldPassword 旧密码
     * @param newPassword 新密码
     * @return 是否成功
     */
    boolean changePassword(Integer userId, String oldPassword, String newPassword);
    
    /**
     * 查询所有用户
     * @return 用户列表
     */
    List<User> findAllUsers();

    /**
     * 获取用户总数
     * @return 总数
     */
    int getTotalCount();
}
