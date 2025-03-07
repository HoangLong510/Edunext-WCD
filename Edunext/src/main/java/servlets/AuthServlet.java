package servlets;

import dao.UserDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import models.User;

public class AuthServlet extends HttpServlet {

    UserDao userDao;

    @Override
    public void init() throws ServletException {
        super.init();
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "login";
        }

        switch (action) {
            case "login":
                getFormLogin(req, resp);
                break;
            case "register":
                getFormRegister(req, resp);
                break;
            case "logout":
                userLogout(req, resp);
                break;
            default:
                throw new AssertionError();
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            resp.sendRedirect("auth?action=login");
        }

        switch (action) {
            case "login":
                userLogin(req, resp);
                break;
            case "register":
                userRegister(req, resp);
                break;
            default:
                throw new AssertionError();
        }
    }

    private void getFormLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("auth/login.jsp").forward(req, resp);
    }

    private void getFormRegister(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("auth/register.jsp").forward(req, resp);
    }

    private void userRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String fullName = req.getParameter("fullName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String confirmPassword = req.getParameter("confirmPassword");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");
        String role = "user";

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

        // check email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required");
        } else {
            String regex = "^[\\w!#$%&'*+/=?`{|}~^-]+(?:\\.[\\w!#$%&'*+/=?`{|}~^-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,6}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(email);
            if (!matcher.matches()) {
                errors.put("email", "Email is invalid");
            } else {
                boolean emailExists = userDao.checkEmailExists(email);
                if (emailExists == true) {
                    errors.put("email", "Email already exists");
                }
            }
        }

        // check password
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password is required");
        } else {
            String regex = "^.{6,30}$";
            Pattern pattern = Pattern.compile(regex);
            Matcher matcher = pattern.matcher(password);
            if (!matcher.matches()) {
                errors.put("password", "Password must be between 6 and 30 characters");
            }
        }

        // check confirmPassword
        if (confirmPassword == null || confirmPassword.trim().isEmpty()) {
            errors.put("confirmPassword", "Confirm password is required");
        } else {
            if (!password.equals(confirmPassword)) {
                errors.put("confirmPassword", "Password and confirm password are not the same");
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

        User user = new User(email, password, fullName, phone, address, role);

        if (errors.isEmpty()) {
            userDao.create(user);
            resp.sendRedirect("auth?action=login");
        } else {
            req.setAttribute("userData", user);
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("auth/register.jsp").forward(req, resp);
        }
    }

    private void userLogin(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Map<String, String> errors = new HashMap<>();

        // check email
        if (email == null || email.trim().isEmpty()) {
            errors.put("email", "Email is required");
        } else {
            boolean emailExists = userDao.checkEmailExists(email);
            if (emailExists == false) {
                errors.put("email", "Email does not exist");
            }
        }

        // check password
        if (password == null || password.trim().isEmpty()) {
            errors.put("password", "Password is required");
        }

        if (errors.isEmpty()) {
            User user = userDao.login(email, password);
            if (user == null) {
                errors.put("password", "Password is incorrect");
                req.setAttribute("errors", errors);
                req.getRequestDispatcher("auth/login.jsp").forward(req, resp);
            } else {
                HttpSession session = req.getSession();
                session.setAttribute("user", user);
                resp.sendRedirect(req.getContextPath());
            }
        } else {
            req.setAttribute("errors", errors);
            req.getRequestDispatcher("auth/login.jsp").forward(req, resp);
        }
    }

    private void userLogout(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        session.removeAttribute("user");
        
        String referer = req.getHeader("referer");
        
        if (referer != null && !referer.isEmpty()) {
            resp.sendRedirect(referer);
        } else {
            resp.sendRedirect("");
        }
    }

}
