package org.example.entity;

import java.util.Date;

public class Announcement {
    private Integer id;
    private String title;
    private String content;
    private Date publishTime;
    private Integer authorId;
    private Admin author;

    public Announcement() {
    }

    public Announcement(Integer id, String title, String content, Date publishTime, Integer authorId, Admin author) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.publishTime = publishTime;
        this.authorId = authorId;
        this.author = author;
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

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Date getPublishTime() {
        return publishTime;
    }

    public void setPublishTime(Date publishTime) {
        this.publishTime = publishTime;
    }

    public Integer getAuthorId() {
        return authorId;
    }

    public void setAuthorId(Integer authorId) {
        this.authorId = authorId;
    }

    public Admin getAuthor() {
        return author;
    }

    public void setAuthor(Admin author) {
        this.author = author;
    }
}