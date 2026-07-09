package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.UserMapper;
import org.example.entity.User;
import org.example.service.UserService;
import org.example.util.MD5Util;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 用户服务实现类
 */
public class UserServiceImpl implements UserService {
    
    @Override
    public User login(String username, String password) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findByUsername(username);
            
            if (user != null && MD5Util.verify(password, user.getPassword())) {
                // 密码正确，返回用户信息（不返回密码）
                user.setPassword(null);
                return user;
            }
            return null;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean register(User user) {
        // 检查用户名是否已存在
        if (isUsernameExist(user.getUsername())) {
            return false;
        }
        
        // 检查邮箱是否已注册
        if (isEmailExist(user.getEmail())) {
            return false;
        }
        
        // 密码 MD5 加密
        user.setPassword(MD5Util.md5(user.getPassword()));
        
        // 设置默认值
        if (user.getGender() == null) {
            user.setGender(0); // 默认未知
        }
        if (user.getIsVip() == null) {
            user.setIsVip(0); // 默认非 VIP
        }
        if (user.getStatus() == null) {
            user.setStatus(1); // 默认正常
        }
        
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.insert(user);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public User findById(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findById(id);
            if (user != null) {
                user.setPassword(null); // 不返回密码
            }
            return user;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public User findByUsername(String username) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findByUsername(username);
            if (user != null) {
                user.setPassword(null); // 不返回密码
            }
            return user;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean isUsernameExist(String username) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findByUsername(username);
            return user != null;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean isEmailExist(String email) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findByEmail(email);
            return user != null;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean updateUser(User user) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.update(user);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean deleteUser(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            int result = mapper.deleteById(id);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean changePassword(Integer userId, String oldPassword, String newPassword) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            User user = mapper.findById(userId);
            
            if (user == null || !MD5Util.verify(oldPassword, user.getPassword())) {
                return false; // 用户不存在或旧密码错误
            }
            
            // 更新密码
            user.setPassword(MD5Util.md5(newPassword));
            int result = mapper.update(user);
            session.commit();
            return result > 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<User> findAllUsers() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.findAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public int getTotalCount() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            UserMapper mapper = session.getMapper(UserMapper.class);
            return mapper.countAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
