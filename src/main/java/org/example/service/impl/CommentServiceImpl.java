package org.example.service.impl;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.CommentMapper;
import org.example.entity.Comment;
import org.example.service.CommentService;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * 评论服务实现类
 */
public class CommentServiceImpl implements CommentService {
    
    @Override
    public Comment findById(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            return mapper.findById(id);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }

    @Override
    public List<Comment> findAllForAdmin() {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            return mapper.findAllForAdmin();
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Comment> findByMovieId(Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            return mapper.findByMovieId(movieId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public boolean addComment(Integer userId, Integer movieId, String content) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            Comment comment = new Comment();
            comment.setUserId(userId);
            comment.setMovieId(movieId);
            comment.setContent(content);
            comment.setStatus(1); // 正常状态
            
            int result = mapper.insert(comment);
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
    public boolean deleteComment(Integer id) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
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
    public boolean deleteCommentsByMovieId(Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            int result = mapper.deleteByMovieId(movieId);
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

    @Override
    public int getCountByMovieId(Integer movieId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            return mapper.countByMovieId(movieId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
    
    @Override
    public List<Comment> findByUserId(Integer userId) {
        SqlSession session = MyBatisUtil.getSqlSession();
        try {
            CommentMapper mapper = session.getMapper(CommentMapper.class);
            return mapper.findByUserId(userId);
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
