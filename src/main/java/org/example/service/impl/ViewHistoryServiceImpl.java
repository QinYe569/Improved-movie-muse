package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.ViewHistoryMapper;
import org.example.entity.ViewHistory;
import org.example.service.ViewHistoryService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 观看历史服务实现类
 */
public class ViewHistoryServiceImpl implements ViewHistoryService {

    @Override
    public List<ViewHistory> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            ViewHistoryMapper mapper = session.getMapper(ViewHistoryMapper.class);
            return mapper.findByUserId(userId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean addViewHistory(Integer userId, Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            ViewHistoryMapper mapper = session.getMapper(ViewHistoryMapper.class);

            // 检查是否已有该电影的观看记录
            ViewHistory existing = mapper.findByUserIdAndMovieId(userId, movieId);
            if (existing != null) {
                // 已存在，更新观看时间
                int result = mapper.updateViewTime(userId, movieId);
                session.commit();
                return result > 0;
            }

            // 不存在，插入新记录
            ViewHistory viewHistory = new ViewHistory();
            viewHistory.setUserId(userId);
            viewHistory.setMovieId(movieId);

            int result = mapper.insert(viewHistory);
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
    public boolean deleteViewHistory(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            ViewHistoryMapper mapper = session.getMapper(ViewHistoryMapper.class);
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
    public boolean clearViewHistory(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            ViewHistoryMapper mapper = session.getMapper(ViewHistoryMapper.class);
            int result = mapper.clearByUserId(userId);
            session.commit();
            return result >= 0;
        } catch (Exception e) {
            session.rollback();
            e.printStackTrace();
            return false;
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
