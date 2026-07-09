package org.example.entity;

import java.util.Date;

public class ViewHistory {
    private Integer id;
    private Integer userId;
    private Integer movieId;
    private Date viewTime;
    private User user;
    private Movie movie;

    public ViewHistory() {
    }

    public ViewHistory(Integer id, Integer userId, Integer movieId, Date viewTime, User user, Movie movie) {
        this.id = id;
        this.userId = userId;
        this.movieId = movieId;
        this.viewTime = viewTime;
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

    public Date getViewTime() {
        return viewTime;
    }

    public void setViewTime(Date viewTime) {
        this.viewTime = viewTime;
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