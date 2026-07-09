package org.example.entity;

import java.util.Date;

public class SearchHistory {
    private Integer id;
    private Integer userId;
    private String keyword;
    private Date searchTime;
    private User user;

    public SearchHistory() {
    }

    public SearchHistory(Integer id, Integer userId, String keyword, Date searchTime, User user) {
        this.id = id;
        this.userId = userId;
        this.keyword = keyword;
        this.searchTime = searchTime;
        this.user = user;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public String getKeyword() {
        return keyword;
    }

    public void setKeyword(String keyword) {
        this.keyword = keyword;
    }

    public Date getSearchTime() {
        return searchTime;
    }

    public void setSearchTime(Date searchTime) {
        this.searchTime = searchTime;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }
}