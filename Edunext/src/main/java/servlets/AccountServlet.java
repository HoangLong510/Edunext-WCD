package servlets;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AccountServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="list";
        }
        switch (action) {
            case "list":
                request.getRequestDispatcher("/Management/account/list.jsp").forward(request, response);
                break;
            case "add":
                request.getRequestDispatcher("/Management/account/accountForm.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("id", request.getParameter("id"));
                request.getRequestDispatcher("/Management/account/accountForm.jsp").forward(request, response);
                break;
            case "delete":
                // Xử lý xóa
                response.sendRedirect("/Management/account?action=list");
                break;
        }
    }
}

