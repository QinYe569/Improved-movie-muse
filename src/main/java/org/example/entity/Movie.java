package org.example.entity;

import java.util.Date;

public class Movie {
    private Integer id;
    private String title;
    private String poster;
    private String description;
    private String director;
    private Integer releaseYear;
    private Integer runtime;
    private Double rating;
    private Integer viewCount;
    private String videoUrl;
    private Integer isFree;
    private Integer status;
    private Date createTime;

    public Movie() {
    }

    public Movie(Integer id, String title, String poster, String description, String director, Integer releaseYear, Integer runtime, Double rating, Integer viewCount, String videoUrl, Integer isFree, Integer status, Date createTime) {
        this.id = id;
        this.title = title;
        this.poster = poster;
        this.description = description;
        this.director = director;
        this.releaseYear = releaseYear;
        this.runtime = runtime;
        this.rating = rating;
        this.viewCount = viewCount;
        this.videoUrl = videoUrl;
        this.isFree = isFree;
        this.status = status;
        this.createTime = createTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getPoster() {
        return poster;
    }

    public void setPoster(String poster) {
        this.poster = poster;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDirector() {
        return director;
    }

    public void setDirector(String director) {
        this.director = director;
    }

    public Integer getReleaseYear() {
        return releaseYear;
    }

    public void setReleaseYear(Integer releaseYear) {
        this.releaseYear = releaseYear;
    }

    public Integer getRuntime() {
        return runtime;
    }

    public void setRuntime(Integer runtime) {
        this.runtime = runtime;
    }

    public Double getRating() {
        return rating;
    }

    public void setRating(Double rating) {
        this.rating = rating;
    }

    public Integer getViewCount() {
        return viewCount;
    }

    public void setViewCount(Integer viewCount) {
        this.viewCount = viewCount;
    }

    public String getVideoUrl() {
        return videoUrl;
    }

    public void setVideoUrl(String videoUrl) {
        this.videoUrl = videoUrl;
    }

    public Integer getIsFree() {
        return isFree;
    }

    public void setIsFree(Integer isFree) {
        this.isFree = isFree;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}