package org.example.util;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import java.io.IOException;
import java.io.InputStream;

/**
 * MyBatis 工具类
 * 用于获取 SqlSession 对象
 */
public class MyBatisUtil {
    
    private static SqlSessionFactory sqlSessionFactory;
    
    static {
        try {
            // 读取 MyBatis 配置文件
            String resource = "mybatis-config.xml";
            InputStream inputStream = Resources.getResourceAsStream(resource);
            sqlSessionFactory = new SqlSessionFactoryBuilder().build(inputStream);
        } catch (IOException e) {
            e.printStackTrace();
            throw new RuntimeException("初始化 MyBatis 失败：" + e.getMessage());
        }
    }
    
    /**
     * 获取 SqlSession 对象
     * @return SqlSession
     */
    public static SqlSession getSqlSession() {
        return sqlSessionFactory.openSession();
    }
    
    /**
     * 获取 SqlSession 对象（可设置是否自动提交）
     * @param autoCommit 是否自动提交
     * @return SqlSession
     */
    public static SqlSession getSqlSession(boolean autoCommit) {
        return sqlSessionFactory.openSession(autoCommit);
    }
    
    /**
     * 关闭 SqlSession
     * @param session SqlSession
     */
    public static void closeSession(SqlSession session) {
        if (session != null) {
            session.close();
        }
    }
}
