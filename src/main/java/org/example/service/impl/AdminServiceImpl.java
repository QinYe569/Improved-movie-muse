package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.AdminMapper;
import org.example.entity.Admin;
import org.example.service.AdminService;
import org.example.util.MD5Util;
import org.example.util.MyBatisUtil;

/**
 * 管理员服务实现类
 */
public class AdminServiceImpl implements AdminService {
    
    @Override
    public Admin login(String username, String password) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AdminMapper mapper = session.getMapper(AdminMapper.class);
            Admin admin = mapper.findByUsername(username);
            
            if (admin != null && MD5Util.verify(password, admin.getPassword())) {
                // 密码正确，不返回密码
                admin.setPassword(null);
                return admin;
            }
            return null;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public Admin findById(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AdminMapper mapper = session.getMapper(AdminMapper.class);
            Admin admin = mapper.findById(id);
            if (admin != null) {
                admin.setPassword(null);
            }
            return admin;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public Admin findByUsername(String username) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AdminMapper mapper = session.getMapper(AdminMapper.class);
            Admin admin = mapper.findByUsername(username);
            if (admin != null) {
                admin.setPassword(null);
            }
            return admin;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
