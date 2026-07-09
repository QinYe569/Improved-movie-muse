package org.example.entity;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

/**
 * 系统配置实体类
 * 对应数据库表：system_config
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class SystemConfig {
    /**
     * 配置 ID
     */
    private Integer id;
    
    /**
     * 配置键
     */
    private String configKey;
    
    /**
     * 配置值
     */
    private String configValue;
    
    /**
     * 配置描述
     */
    private String description;
}
