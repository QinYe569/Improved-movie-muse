package org.example;

import org.apache.ibatis.session.SqlSession;
import org.example.dao.MovieMapper;
import org.example.entity.Movie;
import org.example.util.MyBatisUtil;

import java.util.List;

/**
 * MyBatis 数据库连接测试
 * 验证 MyBatis 配置是否正确
 */
public class MyBatisTest {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   MyBatis 数据库连接测试");
        System.out.println("===========================================\n");
        
        SqlSession session = null;
        try {
            // 1. 测试连接
            System.out.println("[1] 测试数据库连接...");
            session = MyBatisUtil.getSqlSession();
            System.out.println("✓ 数据库连接成功！\n");
            
            // 2. 测试查询电影数量
            System.out.println("[2] 查询电影总数...");
            MovieMapper movieMapper = session.getMapper(MovieMapper.class);
            int count = movieMapper.countAll();
            System.out.println("✓ 电影总数: " + count + "\n");
            
            // 3. 测试查询所有电影
            System.out.println("[3] 查询所有电影...");
            List<Movie> movies = movieMapper.findAll();
            if (movies.isEmpty()) {
                System.out.println("⚠ 数据库中暂无电影数据\n");
            } else {
                System.out.println("✓ 共查询到 " + movies.size() + " 部电影：");
                for (Movie movie : movies) {
                    System.out.println("  - ID: " + movie.getId() + 
                                     ", 标题: " + movie.getTitle() + 
                                     ", 评分: " + movie.getRating());
                }
                System.out.println();
            }
            
            // 4. 测试查询分类
            System.out.println("[4] 查询分类数据...");
            org.example.dao.CategoryMapper categoryMapper = session.getMapper(org.example.dao.CategoryMapper.class);
            List<org.example.entity.Category> categories = categoryMapper.findAll();
            System.out.println("✓ 共查询到 " + categories.size() + " 个分类：");
            for (org.example.entity.Category category : categories) {
                System.out.println("  - ID: " + category.getId() + 
                                 ", 名称: " + category.getName() + 
                                 ", 图标: " + category.getIcon());
            }
            System.out.println();
            
            // 5. 测试查询管理员
            System.out.println("[5] 查询管理员数据...");
            org.example.dao.AdminMapper adminMapper = session.getMapper(org.example.dao.AdminMapper.class);
            org.example.entity.Admin admin = adminMapper.findByUsername("admin");
            if (admin != null) {
                System.out.println("✓ 找到管理员: " + admin.getUsername());
                System.out.println("  角色: " + (admin.getRole() == 2 ? "超级管理员" : "普通管理员"));
            } else {
                System.out.println("⚠ 未找到管理员账号");
            }
            System.out.println();
            
            System.out.println("===========================================");
            System.out.println("   ✓ 所有测试通过！MyBatis 配置正确");
            System.out.println("===========================================");
            
        } catch (Exception e) {
            System.out.println("\n===========================================");
            System.out.println("   ✗ 测试失败！");
            System.out.println("===========================================");
            System.out.println("\n错误信息：");
            e.printStackTrace();
            System.out.println("\n可能的原因：");
            System.out.println("1. 数据库连接信息错误（url、username、password）");
            System.out.println("2. MySQL 服务未启动");
            System.out.println("3. 数据库名不存在");
            System.out.println("4. 缺少 MySQL 驱动");
        } finally {
            MyBatisUtil.closeSession(session);
        }
    }
}
