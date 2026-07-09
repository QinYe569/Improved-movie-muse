package org.example.test;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

/**
 * 数据库连接测试（纯 JDBC，不依赖 MyBatis）
 */
public class DatabaseConnectionTest {
    
    public static void main(String[] args) {
        System.out.println("===========================================");
        System.out.println("   数据库连接测试");
        System.out.println("===========================================\n");
        
        String url = "jdbc:mysql://localhost:3306/movie?useUnicode=true&characterEncoding=utf8&useSSL=false&serverTimezone=Asia/Shanghai&allowPublicKeyRetrieval=true";
        String username = "root";
        String password = "060424";
        
        Connection conn = null;
        try {
            // 1. 加载驱动
            System.out.println("[1] 加载 MySQL 驱动...");
            Class.forName("com.mysql.cj.jdbc.Driver");
            System.out.println("✓ 驱动加载成功\n");
            
            // 2. 建立连接
            System.out.println("[2] 连接数据库...");
            System.out.println("    URL: " + url);
            System.out.println("    用户名：" + username);
            conn = DriverManager.getConnection(url, username, password);
            System.out.println("✓ 数据库连接成功！\n");
            
            // 3. 检查各表数据量
            System.out.println("[3] 检查各表数据量...");
            Statement stmt = conn.createStatement();
            
            String[] tables = {"user", "admin", "movie", "actor", "category", 
                              "comment", "favorite", "movie_actor", "movie_category", 
                              "view_history", "search_history", "system_config"};
            
            for (String table : tables) {
                String sql = "SELECT COUNT(*) FROM " + table;
                var rs = stmt.executeQuery(sql);
                if (rs.next()) {
                    int count = rs.getInt(1);
                    System.out.println("    ✓ " + table + " 表：" + count + " 条记录");
                }
            }
            
            System.out.println("\n===========================================");
            System.out.println("   ✓ 数据库配置正确！连接成功");
            System.out.println("===========================================");
            
        } catch (ClassNotFoundException e) {
            System.out.println("\n✗ 错误：找不到 MySQL 驱动");
            System.out.println("请确保 mysql-connector-j 已添加到 pom.xml");
            e.printStackTrace();
        } catch (SQLException e) {
            System.out.println("\n✗ 错误：数据库连接失败");
            System.out.println("错误信息：" + e.getMessage());
            System.out.println("\n可能的原因：");
            System.out.println("1. MySQL 服务未启动");
            System.out.println("2. 数据库名不存在（应该是 movie）");
            System.out.println("3. 用户名或密码错误");
            System.out.println("4. 端口号不是 3306");
            e.printStackTrace();
        } finally {
            try {
                if (conn != null && !conn.isClosed()) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}
