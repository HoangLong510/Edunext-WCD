package servlets;

import dao.CategoryDao;
import dao.ProductDao;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;
import models.Category;
import models.Product;

public class ProductServlet extends HttpServlet {

    ProductDao proDao;
    CategoryDao cateDao;

    @Override
    public void init() throws ServletException {
        super.init();
        proDao = new ProductDao();
        cateDao = new CategoryDao();
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
                request.getRequestDispatcher("/Management/product/list.jsp").forward(request, response);
                break;
            case "add":
                request.getRequestDispatcher("/Management/product/productForm.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("id", request.getParameter("id"));
                request.getRequestDispatcher("/Management/product/productForm.jsp").forward(request, response);
                break;
            case "delete":
                response.sendRedirect("/Management/product?action=list");
                break;
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
                addProduct(req, resp);
                break;
            case "edit":
                updateProduct(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page or action parameter");
        }
    }

    private void showListProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Product> products = proDao.getAll();
        req.setAttribute("products", products);
        req.getRequestDispatcher("/Management/product/list.jsp").forward(req, resp);
    }

    private void showFormAddProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> cates = cateDao.getAll();
        req.setAttribute("cates", cates);
        req.getRequestDispatcher("/Management/product/add.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Category cate = cateDao.getOne(categoryId);
        Product newProduct = new Product(name, price, cate);
        proDao.create(newProduct);
        resp.sendRedirect("Management/product?page=list");
    }

    private void showFormEditProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        List<Category> cates = cateDao.getAll();
        req.setAttribute("cates", cates);
        Product product = proDao.getOne(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("/Management/product/edit.jsp").forward(req, resp);
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        Category cate = cateDao.getOne(categoryId);
        Product product = new Product(id, name, price, cate);
        proDao.update(product);
        resp.sendRedirect("Management/product?page=list");
    }
}