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
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String action = request.getParameter("action");
        if(action == null){
            action ="list";
        }
        switch (action) {
            case "list":
                request.getRequestDispatcher("/Management/brand/list.jsp").forward(request, response);
                break;
            case "add":
                request.getRequestDispatcher("/Management/brand/brandForm.jsp").forward(request, response);
                break;
            case "edit":
                request.setAttribute("id", request.getParameter("id"));
                request.getRequestDispatcher("/Management/brand/brandForm.jsp").forward(request, response);
                break;
            case "delete":
                // Xử lý xóa thương hiệu
                response.sendRedirect("/Management/brand?Action=list");
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
        String image = req.getParameter("image");
        Brand newBrand = new Brand(name,  image);
        brandDao.create(newBrand);
        resp.sendRedirect("Management/brand?page=list");
    }

}