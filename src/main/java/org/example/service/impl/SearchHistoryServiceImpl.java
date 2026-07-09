package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.SearchHistoryMapper;
import org.example.entity.SearchHistory;
import org.example.service.SearchHistoryService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 搜索历史服务实现类
 */
public class SearchHistoryServiceImpl implements SearchHistoryService {

    @Override
    public List<SearchHistory> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            SearchHistoryMapper mapper = session.getMapper(SearchHistoryMapper.class);
            return mapper.findByUserId(userId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean addSearchHistory(Integer userId, String keyword) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            SearchHistoryMapper mapper = session.getMapper(SearchHistoryMapper.class);

            SearchHistory searchHistory = new SearchHistory();
            searchHistory.setUserId(userId);
            searchHistory.setKeyword(keyword);

            int result = mapper.insert(searchHistory);
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
    public boolean deleteSearchHistory(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            SearchHistoryMapper mapper = session.getMapper(SearchHistoryMapper.class);
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
    public boolean clearSearchHistory(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            SearchHistoryMapper mapper = session.getMapper(SearchHistoryMapper.class);
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
