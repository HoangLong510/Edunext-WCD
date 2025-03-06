package servlets;

import dao.UserDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import models.User;

public class AccountServlet extends HttpServlet {

    UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                showListAccount(request, response);
                break;
            case "add":
                request.getRequestDispatcher("/Management/account/accountForm.jsp").forward(request, response);
                break;
            case "edit":
                showFormEditAccount(request, response);
                break;
            case "delete":
                deleteUser(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath());
        }
        
        switch (action) {
            case "edit":
                editAccount(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath());
        }
    }
    
    

    private void showListAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        List<User> users = userDao.getAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Management/account/list.jsp").forward(request, response);
    }

    private void deleteUser(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        userDao.deleteUser(id);
        List<User> users = userDao.getAll();
        request.setAttribute("users", users);
        request.getRequestDispatcher("/Management/account/list.jsp").forward(request, response);
    }

    private void showFormEditAccount(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        User user = userDao.getUserById(id);
        if (user == null) {
            response.sendRedirect(request.getContextPath());
        } else {
            request.setAttribute("formData", user);
            request.getRequestDispatcher("/Management/account/editAccount.jsp").forward(request, response);
        }
    }

    private void editAccount(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        int id = Integer.parseInt(request.getParameter("id"));
        String fullName = request.getParameter("fullName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String role = request.getParameter("role");
        
        Map<String, String> errors = new HashMap<>();
        
        // check fullName
        if (fullName == null || fullName.trim().isEmpty()) {
            errors.put("fullName", "Full name is required");
        } else {
            String regex = "^[a-zA-ZÀ-Ỹà-ỹ]{2,30}$|^[a-zA-ZÀ-Ỹà-ỹ]+(?:\\s[a-zA-ZÀ-Ỹà-ỹ]+){1,29}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(fullName);
            if (!matcher.matches()) {
                errors.put("fullName", "Full name must be between 2 and 30 characters. Full name must not contain numbers or special characters");
            }
        }
        
        // check phone
        if (phone == null || phone.trim().isEmpty()) {
            errors.put("phone", "Phone is required");
        } else {
            String regex = "^0(3[2-9]|5[2689]|7[06-9]|8[1-9]|9[0-9])[0-9]{7}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(phone);
            if (!matcher.matches()) {
                errors.put("phone", "Phone is invalid");
            }
        }

        // check address
        if (address == null || address.trim().isEmpty()) {
            errors.put("address", "Address is required");
        }
        
        User user = new User(id, email, password, fullName, phone, address, role);
        
        if (errors.isEmpty()) {
            userDao.editUser(user);
            response.sendRedirect("/Edunext/Management/account?action=list");
        } else {
            request.setAttribute("formData", user);
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/Management/account/editAccount.jsp").forward(request, response);
        }
    }
}
