package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.FavoriteMapper;
import org.example.entity.Favorite;
import org.example.service.FavoriteService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 收藏服务实现类
 */
public class FavoriteServiceImpl implements FavoriteService {
    
    @Override
    public List<Favorite> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            return mapper.findByUserId(userId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean addFavorite(Integer userId, Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            
            // 检查是否已收藏
            Favorite existing = mapper.findByUserIdAndMovieId(userId, movieId);
            if (existing != null) {
                return false; // 已收藏
            }
            
            Favorite favorite = new Favorite();
            favorite.setUserId(userId);
            favorite.setMovieId(movieId);
            
            int result = mapper.insert(favorite);
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
    public boolean removeFavorite(Integer userId, Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            int result = mapper.deleteByUserIdAndMovieId(userId, movieId);
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
    public boolean isFavorited(Integer userId, Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            Favorite favorite = mapper.findByUserIdAndMovieId(userId, movieId);
            return favorite != null;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public int getCountByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            return mapper.countByUserId(userId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public java.util.List<java.util.Map<String, Object>> getFavoriteCountByMovie() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            FavoriteMapper mapper = session.getMapper(FavoriteMapper.class);
            return mapper.countByMovie();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
