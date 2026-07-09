package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * 电影演员关联实体类
 * 对应数据库表：movie_actor
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class MovieActor {
    /**
     * 关联 ID
     */
    private Integer id;
    
    /**
     * 电影 ID
     */
    private Integer movieId;
    
    /**
     * 演员 ID
     */
    private Integer actorId;
    
    /**
     * 饰演角色
     */
    private String roleName;
    
    /**
     * 关联演员对象
     */
    private Actor actor;
}
