package servlets;

import dao.BrandDao;
import dao.CategoryDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import models.Brand;
import models.Category;
import java.io.IOException;
import java.util.List;

public class CategoryServlet extends HttpServlet {

    CategoryDao cateDao;
    BrandDao brandDao;

    @Override
    public void init() throws ServletException {
        super.init();
        cateDao = new CategoryDao();
        brandDao = new BrandDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String page = req.getParameter("page");
        String pageAction = req.getParameter("pageAction");

        if (page == null || page.isEmpty()) {
            page = "list";
        }

        if ("category".equals(page)) {
            if ("add".equals(pageAction)) {
                showFormAddCate(req, resp);
                return;
            } else if ("edit".equals(pageAction)) {
                showFormEditCate(req, resp);
                return;
            } else {
                showListCate(req, resp);
                return;
            }
        }

        switch (page) {
            case "list":
                showListCate(req, resp);
                break;
            case "add":
                showFormAddCate(req, resp);
                break;
            case "edit":
                showFormEditCate(req, resp);
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
                addCate(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page or action parameter");
        }
    }

    private void showListCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> cates = cateDao.getAll();
        req.setAttribute("cates", cates);
        req.getRequestDispatcher("/Management/category/list.jsp").forward(req, resp);
    }

    private void showFormAddCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        System.out.println("showFormAddCate called");
        List<Brand> brands = brandDao.getAll();
        System.out.println("Number of brands: " + brands.size()); 
        req.setAttribute("brands", brands);
        req.getRequestDispatcher("/Management/category/add.jsp").forward(req, resp);
        System.out.println("Forwarded to add.jsp");
    }

    private void addCate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        int brandId = Integer.parseInt(req.getParameter("brandId"));
        Brand brand = brandDao.getOne(brandId);
        Category newCate = new Category(name, brand);
        cateDao.create(newCate);
        resp.sendRedirect("Management/category?page=list");
    }

    private void showFormEditCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        Category cate = cateDao.getOne(id);
        List<Brand> brands = brandDao.getAll();
        req.setAttribute("cate", cate);
        req.setAttribute("brands", brands);
        req.getRequestDispatcher("/Management/category/edit.jsp").forward(req, resp);
    }
}
