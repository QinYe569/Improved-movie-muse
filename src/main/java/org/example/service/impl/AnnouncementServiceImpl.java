package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.AnnouncementMapper;
import org.example.entity.Announcement;
import org.example.service.AnnouncementService;
import org.example.util.MyBatisUtil;

import java.util.List;

public class AnnouncementServiceImpl implements AnnouncementService {

    @Override
    public List<Announcement> findAll() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AnnouncementMapper mapper = session.getMapper(AnnouncementMapper.class);
            return mapper.findAll();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public boolean addAnnouncement(Announcement announcement) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AnnouncementMapper mapper = session.getMapper(AnnouncementMapper.class);
            int result = mapper.insert(announcement);
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
    public boolean deleteAnnouncement(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            AnnouncementMapper mapper = session.getMapper(AnnouncementMapper.class);
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