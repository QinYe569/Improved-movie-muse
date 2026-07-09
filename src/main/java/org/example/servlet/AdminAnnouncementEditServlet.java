package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Admin;
import org.example.entity.Announcement;
import org.example.service.AnnouncementService;
import org.example.service.impl.AnnouncementServiceImpl;

import java.io.IOException;

@WebServlet(name = "AdminAnnouncementEditServlet", value = "/admin/announcement-edit")
public class AdminAnnouncementEditServlet extends HttpServlet {

    private AnnouncementService announcementService = new AnnouncementServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        request.getRequestDispatcher("/admin/admin-announcement-edit.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        String title = request.getParameter("title");
        String content = request.getParameter("content");

        if (title == null || title.trim().isEmpty() || content == null || content.trim().isEmpty()) {
            request.setAttribute("error", "标题和内容不能为空");
            request.getRequestDispatcher("/admin/admin-announcement-edit.jsp").forward(request, response);
            return;
        }

        Admin admin = (Admin) session.getAttribute("currentAdmin");

        Announcement announcement = new Announcement();
        announcement.setTitle(title.trim());
        announcement.setContent(content.trim());
        announcement.setAuthorId(admin.getId());

        boolean success = announcementService.addAnnouncement(announcement);

        if (success) {
            request.setAttribute("success", "公告发布成功！");
        } else {
            request.setAttribute("error", "公告发布失败，请重试");
        }

        request.getRequestDispatcher("/admin/admin-announcement-edit.jsp").forward(request, response);
    }
}