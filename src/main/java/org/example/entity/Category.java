package org.example.entity;

public class Category {
    private Integer id;
    private String name;
    private String icon;
    private String description;
    private Integer sortOrder;
    private Integer status;

    public Category() {
    }

    public Category(Integer id, String name, String icon, String description, Integer sortOrder, Integer status) {
        this.id = id;
        this.name = name;
        this.icon = icon;
        this.description = description;
        this.sortOrder = sortOrder;
        this.status = status;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getSortOrder() {
        return sortOrder;
    }

    public void setSortOrder(Integer sortOrder) {
        this.sortOrder = sortOrder;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }
}