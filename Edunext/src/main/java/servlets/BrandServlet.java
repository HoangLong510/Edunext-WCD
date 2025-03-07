package servlets;

import dao.BrandDao;
import dao.CategoryDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.Console;
import models.Brand;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;
import models.Category;

@MultipartConfig
public class BrandServlet extends HttpServlet {

    BrandDao brandDao;
    CategoryDao cateDao;

    @Override
    public void init() throws ServletException {
        super.init();
        brandDao = new BrandDao();
        cateDao = new CategoryDao();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                showListBrand(req, resp);
                break;
            case "add":
                showFormAddBrand(req, resp);
                break;
            case "edit":
                showFormEditBrand(req, resp);
                break;
            case "sort":
                sortBrands(req, resp);
                break;
            case "delete":
                showConfirmDelete(req, resp);
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
            case "edit":
                editBrand(req, resp);
                break;
            case "delete":
                deleteBrand(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid page or action parameter");
        }
    }

    private void showFormAddBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/Management/brand/brandForm.jsp").forward(req, resp);
    }

    private void addBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String name = req.getParameter("name");
        Part filePart = req.getPart("image");
        // Kiểm tra nếu tệp không null và có kích thước lớn hơn 0
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            // Gọi phương thức uploadFile để tải tệp lên và lấy đường dẫn
            imageUrl = uploadFile(filePart);
        }
        Brand newBrand = new Brand(name, imageUrl);

        boolean success = true;
        try {
            brandDao.create(newBrand);
        } catch (Exception e) {
            success = false;
        }

        // Trả về JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.print("{\"status\": \"" + (success ? "success" : "error") + "\", \"option\": \"brand\"}");
        out.flush();

    }

    private void showListBrand(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Brand> brands = brandDao.getAll();
        req.setAttribute("brands", brands);
        req.getRequestDispatcher("/Management/brand/list.jsp").forward(req, resp);
    }

    private String uploadFile(Part filePart) throws IOException {
        ServletContext servletContext = getServletContext();
        String realPath = servletContext.getRealPath("/uploads"); // Đường dẫn thực tế trên server
        System.out.println("Real path: " + realPath);
        if (filePart != null && filePart.getSize() > 0) {
            // Lấy tên file từ client
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Tạo tên file duy nhất (có thể sử dụng UUID để tránh trùng lặp)
            String uniqueFileName = System.currentTimeMillis() + "_" + fileName;

            // Kiểm tra nếu thư mục "uploads" chưa tồn tại thì tạo mới
            if (!Files.exists(Paths.get(realPath))) {
                Files.createDirectories(Paths.get(realPath));
            }

            // Đường dẫn lưu file trên server
            String filePath = realPath + "/" + uniqueFileName;

            // Ghi file vào thư mục "uploads"
            filePart.write(filePath);

            // Trả về đường dẫn tương đối để lưu vào database
            return "uploads/" + uniqueFileName;
        }
        return null;
    }

    private void showFormEditBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Brand brand = brandDao.getOne(id); // Lấy brand từ DB theo ID
            req.setAttribute("id", brand.getId());
            req.setAttribute("name", brand.getName());
            req.setAttribute("image", brand.getImage());
            req.getRequestDispatcher("/Management/brand/brandForm.jsp").forward(req, resp);
        }
    }

    private void editBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String idStr = req.getParameter("id");
        String name = req.getParameter("name");
        Part filePart = req.getPart("image");

        if (idStr == null || name == null || name.trim().isEmpty()) {
            resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing brand name or id");
            return;
        }

        int id = Integer.parseInt(idStr);

        // Kiểm tra nếu có tệp hình ảnh, tải lên tệp mới
        String imageUrl = null;
        if (filePart != null && filePart.getSize() > 0) {
            imageUrl = uploadFile(filePart);  // Phương thức uploadFile như bạn đã viết
        }

        // Lấy đối tượng thương hiệu từ database
        Brand brand = brandDao.getOne(id);

        if (brand != null) {
            // Cập nhật thông tin thương hiệu
            brand.setName(name);
            if (imageUrl != null) {
                brand.setImage(imageUrl);  // Cập nhật hình ảnh nếu có
            }

            // Cập nhật thương hiệu trong cơ sở dữ liệu
            boolean success = true;
            try {
                brandDao.update(brand);
            } catch (Exception e) {
                success = false;
            }
            // Trả về JSON
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");

            PrintWriter out = resp.getWriter();
            out.print("{\"status\": \"" + (success ? "success" : "error") + "\", \"option\": \"brand\"}");
            out.flush();
        }
    }

    private void deleteBrand(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        int brandId = Integer.parseInt(req.getParameter("id"));

        boolean success = true;
        try {
            brandDao.deactivateBrand(brandId);
        } catch (Exception e) {
            success = false;
        }
        // Trả về JSON
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        PrintWriter out = resp.getWriter();
        out.print("{\"status\": \"" + (success ? "success" : "error") + "\", \"option\": \"brand\"}");
        out.flush();

    }

    private void sortBrands(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String statusParam = req.getParameter("status");
        boolean status = true; // Mặc định là true (Active)
        if (statusParam != null && statusParam.equals("false")) {
            status = false; // Nếu statusParam là "false" thì lọc theo inactive
        }

        // Gọi phương thức trong BrandDao để lấy danh sách sắp xếp
        List<Brand> brands = brandDao.getBrandsByStatus(status);
        // Đưa danh sách brand vào request attribute để hiển thị
        req.setAttribute("brands", brands);

        // Chuyển hướng đến JSP để hiển thị danh sách brand đã được sắp xếp
        req.getRequestDispatcher("/Management/brand/list.jsp").forward(req, resp);
    }

    private void showConfirmDelete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);
            Brand brand = brandDao.getOne(id); 
            req.setAttribute("id", brand.getId());
            req.setAttribute("name", brand.getName());
            req.setAttribute("status", brand.isStatus());
            req.getRequestDispatcher("/Management/brand/delete.jsp").forward(req, resp);
        }
    }

}
