package servlets;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.RequestDispatcher;

public class Management extends HttpServlet {

    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String option = req.getParameter("option");
        String action = req.getParameter("action");
        System.out.println(option);
        System.out.println(action);
        if (option == null || action == null) {
            req.getRequestDispatcher("includes/admin_dashboard.jsp").forward(req, resp);
            return;
        }

        switch (option) {
            case "account":
                req.getRequestDispatcher("/Management/account?action=" + action).forward(req, resp);
                break;
            case "brand":
                req.getRequestDispatcher("/Management/brand?action=" + action).forward(req, resp);
                break;
            case "category":
                req.getRequestDispatcher("/Management/category?action=" + action).forward(req, resp);
                break;
            case "product":
                req.getRequestDispatcher("/Management/product?action=" + action).forward(req, resp);
                break;
            default:
                req.getRequestDispatcher("includes/admin_dashboard.jsp").forward(req, resp);
        }
    }
}
