package org.example.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.entity.SearchHistory;
import org.example.entity.User;
import org.example.service.SearchHistoryService;
import org.example.service.impl.SearchHistoryServiceImpl;

import java.io.IOException;
import java.util.List;

/**
 * 搜索历史 Servlet
 * 显示用户的搜索历史
 */
@WebServlet(name = "SearchHistoryServlet", value = "/user/search-history")
public class SearchHistoryServlet extends HttpServlet {

    private SearchHistoryService searchHistoryService = new SearchHistoryServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        User currentUser = (User) request.getSession().getAttribute("currentUser");
        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            return;
        }

        // 加载搜索历史
        List<SearchHistory> historyList = searchHistoryService.findByUserId(currentUser.getId());
        request.setAttribute("historyList", historyList);
        request.setAttribute("currentUser", currentUser);

        request.getRequestDispatcher("/user/search-history.jsp").forward(request, response);
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
                    searchHistoryService.deleteSearchHistory(id);
                } catch (NumberFormatException e) {
                    // ignore
                }
            }
        } else if ("clear".equals(action)) {
            // 清空所有记录
            searchHistoryService.clearSearchHistory(currentUser.getId());
        }

        response.sendRedirect(request.getContextPath() + "/user/search-history");
    }
}
