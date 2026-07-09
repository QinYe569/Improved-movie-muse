package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.CategoryMapper;
import org.example.entity.Category;
import org.example.service.CategoryService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 分类服务实现类
 */
public class CategoryServiceImpl implements CategoryService {
    
    @Override
    public Category findById(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            return mapper.findById(id);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public Category findByName(String name) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            return mapper.findByName(name);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Category> findAll() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            return mapper.findAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public List<Category> findAllForAdmin() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            return mapper.findAllForAdmin();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean addCategory(Category category) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            int result = mapper.insert(category);
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
    public boolean updateCategory(Category category) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
            int result = mapper.update(category);
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
    public boolean deleteCategory(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CategoryMapper mapper = session.getMapper(CategoryMapper.class);
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
}
