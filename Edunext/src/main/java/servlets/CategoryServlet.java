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

    private CategoryDao cateDao;
    private BrandDao brandDao;

    @Override
    public void init() throws ServletException {
        super.init();
        cateDao = new CategoryDao();
        brandDao = new BrandDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="list";
        }
        switch (action) {
            case "list":
                request.getRequestDispatcher("/Management/category/list.jsp").forward(request, response);
                break;
            case "add":
                request.getRequestDispatcher("/Management/category/categoryForm.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("id", request.getParameter("id"));
                request.getRequestDispatcher("/Management/category/categoryForm.jsp").forward(request, response);
                break;
            case "delete":
                response.sendRedirect("Management?option=category&action=list");
                break;
        }
    }
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        System.out.println("doPost() called | action=" + action);

        if (action == null) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing action parameter");
            return;
        }

        switch (action) {
            case "add":
                addCate(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

    private void showListCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Category> cates = cateDao.getAll();
            System.out.println("✅ Fetched Categories: " + cates.size());
            req.setAttribute("cates", cates);
            req.getRequestDispatcher("/Management/category/list.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println("❌ Error fetching categories: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving categories");
        }
    }

    private void showFormAddCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Brand> brands = brandDao.getAll();
            System.out.println("✅ Number of brands: " + brands.size());
            req.setAttribute("brands", brands);
            req.getRequestDispatcher("/Management/category/add.jsp").forward(req, resp);
        } catch (Exception e) {
            System.out.println("❌ Error fetching brands: " + e.getMessage());
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving brands");
        }
    }

    private void addCate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String image = req.getParameter("image");

        if (name == null || name.trim().isEmpty() || image == null || image.trim().isEmpty()) {
            System.out.println("❌ Missing category name or image");
            resp.sendRedirect("/Edunext/Management?page=category&error=Missing+name+or+image");
            return;
        }

        try {
            Category newCate = new Category(name, image);
            cateDao.create(newCate);
            System.out.println("✅ Category added: " + name);
            resp.sendRedirect("/Edunext/Management?page=category&success=Category+added");
        } catch (Exception e) {
            System.out.println("❌ Error adding category: " + e.getMessage());
            resp.sendRedirect("/Edunext/Management?page=category&error=Failed+to+add+category");
        }
    }
}
