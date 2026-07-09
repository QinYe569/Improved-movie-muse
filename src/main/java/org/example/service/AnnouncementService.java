package org.example.service;

import org.example.entity.Announcement;

import java.util.List;

public interface AnnouncementService {

    List<Announcement> findAll();

    boolean addAnnouncement(Announcement announcement);

    boolean deleteAnnouncement(Integer id);
}