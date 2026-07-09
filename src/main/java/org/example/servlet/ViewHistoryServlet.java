package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.User;
import org.example.entity.ViewHistory;
import org.example.service.ViewHistoryService;
import org.example.service.impl.ViewHistoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 观看历史 Servlet
 * 显示用户的电影观看历史
 */
@WebServlet(name = "ViewHistoryServlet", value = "/user/view-history")
public class ViewHistoryServlet extends HttpServlet {

    private ViewHistoryService viewHistoryService = new ViewHistoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        // 加载观看历史
        List<ViewHistory> historyList = viewHistoryService.findByUserId(currentUser.getId());
        request.setAttribute("historyList", historyList);
        request.setAttribute("currentUser", currentUser);

        request.getRequestDispatcher("/user/view-history.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            // 删除单条记录
            String idParam = request.getParameter("id");
            if (idParam != null) {
                try {
                    int id = Integer.parseInt(idParam);
                    viewHistoryService.deleteViewHistory(id);
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        } else if ("clear".equals(action)) {
            // 清空所有记录
            viewHistoryService.clearViewHistory(currentUser.getId());
        }

        response.sendRedirect(request.getContextPath() + "/user/view-history");
    }
}
