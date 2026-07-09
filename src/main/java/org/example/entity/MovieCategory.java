package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * 电影分类关联实体类
 * 对应数据库表：movie_category
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieCategory {
    /**
     * 关联 ID
     */
    private Integer id;
    
    /**
     * 电影 ID
     */
    private Integer movieId;
    
    /**
     * 分类 ID
     */
    private Integer categoryId;
    
    /**
     * 关联分类对象
     */
    private Category category;
}
