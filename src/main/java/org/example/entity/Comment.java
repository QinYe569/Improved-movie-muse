package org.example.entity;

import java.util.Date;

public class Comment {
    private Integer id;
    private Integer userId;
    private Integer movieId;
    private String content;
    private Date createTime;
    private Integer status;
    private User user;
    private Movie movie;

    public Comment() {
    }

    public Comment(Integer id, Integer userId, Integer movieId, String content, Date createTime, Integer status, User user, Movie movie) {
        this.id = id;
        this.userId = userId;
        this.movieId = movieId;
        this.content = content;
        this.createTime = createTime;
        this.status = status;
        this.user = user;
        this.movie = movie;
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

    public Integer getMovieId() {
        return movieId;
    }

    public void setMovieId(Integer movieId) {
        this.movieId = movieId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public Movie getMovie() {
        return movie;
    }

    public void setMovie(Movie movie) {
        this.movie = movie;
    }
}