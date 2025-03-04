package servlets;

import dao.BrandDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Brand;
import java.io.IOException;
import java.util.List;

public class BrandServlet extends HttpServlet {

    BrandDao brandDao;

    @Override
    public void init() throws ServletException {
        super.init();
        brandDao = new BrandDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String page = req.getParameter("page");
        String pageAction = req.getParameter("pageAction");

        if (page == null || page.isEmpty()) {
            page = "list";
        }

        if ("brand".equals(page)) {
            if ("add".equals(pageAction)) {
                showFormAddBrand(req, resp);
                return;
            } else if ("edit".equals(pageAction)) {
                showFormEditBrand(req, resp);
                return;
            } else {
                showListBrand(req, resp);
                return;
            }
        }

        switch (page) {
            case "list":
                showListBrand(req, resp);
                break;
            case "add":
                showFormAddBrand(req, resp);
                break;
            case "edit":
                showFormEditBrand(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page or action parameter");
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "add":
                addBrand(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page or action parameter");
        }
    }

    private void showListBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Brand> brands = brandDao.getAll();
        req.setAttribute("brands", brands);
        req.getRequestDispatcher("/Management/brand/list.jsp").forward(req, resp);
    }

    private void showFormAddBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Management/brand/add.jsp").forward(req, resp);
    }

    private void addBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String logo = req.getParameter("logo");
        Brand newBrand = new Brand(name, description, logo);
        brandDao.create(newBrand);
        resp.sendRedirect("Management/brand?page=list");
    }

    private void showFormEditBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Brand brand = brandDao.getOne(id);
        req.setAttribute("brand", brand);
        req.getRequestDispatcher("/Management/brand/edit.jsp").forward(req, resp);
    }
}