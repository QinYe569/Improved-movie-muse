package org.example.dao;

import org.apache.ibatis.annotations.Param;
import org.example.entity.Announcement;

import java.util.List;

public interface AnnouncementMapper {

    Announcement findById(@Param("id") Integer id);

    List<Announcement> findAll();

    int insert(Announcement announcement);

    int deleteById(@Param("id") Integer id);
}