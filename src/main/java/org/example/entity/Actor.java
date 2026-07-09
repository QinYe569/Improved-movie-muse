package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * 演员实体类
 * 对应数据库表：actor
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Actor {
    /**
     * 演员 ID
     */
    private Integer id;
    
    /**
     * 演员姓名
     */
    private String name;
    
    /**
     * 性别 0-未知 1-男 2-女
     */
    private Integer gender;
    
    /**
     * 简介
     */
    private String description;
}
