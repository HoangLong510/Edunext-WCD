package servlets;

import dao.CategoryDao;
import dao.BrandDao;
import dao.ProductDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.IOException;
import java.nio.file.Path;
import java.util.List;
import models.Category;
import models.Brand;
import models.Product;

@MultipartConfig
public class ProductServlet extends HttpServlet {

    ProductDao proDao;
    CategoryDao cateDao;
    BrandDao brandDao; // Dao để lấy Brand

    @Override
    public void init() throws ServletException {
        super.init();
        proDao = new ProductDao();
        cateDao = new CategoryDao();
        brandDao = new BrandDao(); // Khởi tạo brandDao
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
                showListProduct(request, response);
                break;
            case "add":
                showFormAddProduct(request, response);
                break;
            case "edit":
                showFormEditProduct(request, response);
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
        List<Brand> brands = brandDao.getAll(); // Lấy tất cả các brand
        req.setAttribute("cates", cates);
        req.setAttribute("brands", brands); // Truyền danh sách brand
        req.getRequestDispatcher("/Management/product/productForm.jsp").forward(req, resp);
    }

    private void addProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        // Lấy các tham số từ form
        String name = req.getParameter("name");
        String description = req.getParameter("description");
        String priceStr = req.getParameter("price");
        String quantityStr = req.getParameter("quantity");
        String categoryIdStr = req.getParameter("category_id");
        String brandIdStr = req.getParameter("brand_id");

        // Kiểm tra và chuyển đổi giá trị price
        double price = 0;
        try {
            price = Double.parseDouble(priceStr);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid price value.");
            req.getRequestDispatcher("Management/product/productForm.jsp").forward(req, resp);
            return;
        }

        // Kiểm tra và chuyển đổi giá trị quantity
        int quantity = 0;
        try {
            quantity = Integer.parseInt(quantityStr);
        } catch (NumberFormatException e) {
            req.setAttribute("errorMessage", "Invalid quantity value.");
            req.getRequestDispatcher("Management/product/productForm.jsp").forward(req, resp);
            return;
        }

        // Lấy brandId và categoryId
        int brandId = Integer.parseInt(brandIdStr);
        int categoryId = Integer.parseInt(categoryIdStr);

        try {
            // Kiểm tra upload ảnh
            Part filePart = req.getPart("image");
            String uploadedImage = uploadFile(filePart);  // Phương thức uploadFile để xử lý file tải lên

            String image = uploadedImage != null ? uploadedImage : "";  // Nếu có tệp thì lưu đường dẫn ảnh đã tải lên, nếu không thì để trống

            // Lấy đối tượng Brand và Category từ database
            Brand brand = brandDao.getOne(brandId);
            Category category = cateDao.getOne(categoryId);

            // Kiểm tra Brand và Category có hợp lệ không
            if (brand != null && category != null) {
                // Tạo đối tượng Product mới
                Product newProduct = new Product(name, price, description, quantity, image, category, brand);

                // Lưu sản phẩm vào cơ sở dữ liệu
                proDao.create(newProduct);

                // Chuyển hướng về danh sách sản phẩm
                resp.sendRedirect("product?action=list");
            } else {
                // Nếu Brand hoặc Category không hợp lệ
                req.setAttribute("errorMessage", "Invalid brand or category selected.");
                req.getRequestDispatcher("Management/product/productForm.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            // Nếu có lỗi xảy ra trong quá trình xử lý
            req.setAttribute("errorMessage", "An error occurred while adding the product.");
            req.getRequestDispatcher("Management/product/productForm.jsp").forward(req, resp);
        }
    }

    private void showFormEditProduct(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("id"));
        List<Category> cates = cateDao.getAll();
        List<Brand> brands = brandDao.getAll(); // Lấy tất cả các brand
        req.setAttribute("cates", cates);
        req.setAttribute("brands", brands); // Truyền danh sách brand
        Product product = proDao.getOne(id);
        req.setAttribute("product", product);
        req.getRequestDispatcher("/Management/product/productForm.jsp").forward(req, resp);
    }

    private void updateProduct(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("id"));
        String name = req.getParameter("name");
        double price = Double.parseDouble(req.getParameter("price"));
        String description = req.getParameter("description");
        int quantity = Integer.parseInt(req.getParameter("quantity"));
        int categoryId = Integer.parseInt(req.getParameter("categoryId"));
        int brandId = Integer.parseInt(req.getParameter("brandId"));
        Category cate = cateDao.getOne(categoryId);
        Brand brand = brandDao.getOne(brandId);

        // Kiểm tra nếu có file hình ảnh mới thì upload
        String imageFile = uploadFile(req.getPart("image"));

        Product updatedProduct = new Product(name, price, description, quantity, name, cate, brand);
        proDao.update(updatedProduct);
        resp.sendRedirect("Management/product?action=list");
    }

    private String uploadFile(Part filePart) throws IOException {
        if (filePart == null) {
            return null;
        }
        String fileName = Path.of(filePart.getSubmittedFileName()).getFileName().toString(); // Lấy tên file
        String uploadDir = getServletContext().getRealPath("/") + "uploads";
        File uploadFolder = new File(uploadDir);
        if (!uploadFolder.exists()) {
            uploadFolder.mkdir(); // Tạo thư mục nếu chưa tồn tại
        }
        filePart.write(uploadDir + File.separator + fileName); // Lưu file vào thư mục uploads
        return "uploads/" + fileName; // Trả về đường dẫn đến ảnh đã tải lên
    }

}
