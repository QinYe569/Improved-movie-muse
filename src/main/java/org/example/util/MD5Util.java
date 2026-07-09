package org.example.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;

/**
 * MD5 加密工具类
 * 用于用户密码加密
 */
public class MD5Util {
    
    /**
     * MD5 加密
     * @param str 待加密字符串
     * @return 加密后的字符串（32 位小写）
     */
    public static String md5(String str) {
        try {
            MessageDigest md = MessageDigest.getInstance("MD5");
            byte[] digest = md.digest(str.getBytes());
            StringBuilder sb = new StringBuilder();
            for (byte b : digest) {
                String hex = Integer.toHexString(b & 0xff);
                if (hex.length() == 1) {
                    sb.append('0');
                }
                sb.append(hex);
            }
            return sb.toString();
        } catch (NoSuchAlgorithmException e) {
            throw new RuntimeException("MD5 加密失败：" + e.getMessage());
        }
    }
    
    /**
     * 验证密码
     * @param inputPassword 用户输入的密码
     * @param storedPassword 数据库中存储的密码
     * @return 是否匹配
     */
    public static boolean verify(String inputPassword, String storedPassword) {
        return md5(inputPassword).equals(storedPassword);
    }
    
    public static void main(String[] args) {
        // 测试 MD5 加密
        System.out.println("admin123 的 MD5: " + md5("admin123"));
        System.out.println("123456 的 MD5: " + md5("123456"));
    }
}
