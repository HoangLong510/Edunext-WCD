package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

public class Management extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String page = request.getParameter("page");
        String pageAction = request.getParameter("pageAction");
        System.out.println("Page: " + page + ", PageAction: " + pageAction);
        if (page == null || page.isEmpty()) {
            page = "general";
        }

        if ("category".equals(page) || "product".equals(page) || "brand".equals(page)) {
            if ("add".equals(pageAction) || "edit".equals(pageAction)) {
                request.getRequestDispatcher("/Management/" + page + "/" + pageAction + ".jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("/Management/" + page + "/list.jsp").forward(request, response);
        } else {
            String contentPage = "/Management/general/general.jsp";
            request.setAttribute("contentPage", contentPage);
            request.getRequestDispatcher("/includes/admin_dashboard.jsp").forward(request, response);
        }
    }
}
