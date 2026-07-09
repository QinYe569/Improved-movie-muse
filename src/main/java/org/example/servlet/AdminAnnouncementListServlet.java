package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.entity.Announcement;
import org.example.service.AnnouncementService;
import org.example.service.impl.AnnouncementServiceImpl;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "AdminAnnouncementListServlet", value = "/admin/announcements")
public class AdminAnnouncementListServlet extends HttpServlet {

    private AnnouncementService announcementService = new AnnouncementServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("currentAdmin") == null) {
            response.sendRedirect(request.getContextPath() + "/admin/login");
            return;
        }

        List<Announcement> announcements = announcementService.findAll();
        request.setAttribute("announcements", announcements);

        request.getRequestDispatcher("/admin/admin-announcement-list.jsp").forward(request, response);
    }
}