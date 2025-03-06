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
import models.Brand;
import models.Category;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig
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
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String action = req.getParameter("action");
        if (action == null) {
            action = "list";
        }
        switch (action) {
            case "list":
                showListCate(req, resp);
                break;
            case "add":
                showFormAddCate(req, resp);
                break;
            case "edit":
                showFormEditCate(req, resp);
                break;
            case "delete":
                deleteCate(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
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
            case "edit":
                editCate(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid action parameter");
        }
    }

    private void showListCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Category> cates = cateDao.getAll();
            req.setAttribute("cates", cates);
            req.getRequestDispatcher("/Management/category/list.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving categories");
        }
    }

    private void showFormAddCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            List<Brand> brands = brandDao.getAll();
            System.out.println("Brands list size: " + brands.size());
            req.setAttribute("brands", brands);
            req.getRequestDispatcher("/Management/category/categoryForm.jsp").forward(req, resp);
        } catch (Exception e) {
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error retrieving brands");
        }
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

    private void addCate(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String name = req.getParameter("name");
        String image = req.getParameter("image");
        int brandIdStr = Integer.parseInt(req.getParameter("brand_id"));

        try {
            Part filePart = req.getPart("image");
            String uploadedImage = uploadFile(filePart);
            if (uploadedImage != null) {
                image = uploadedImage; // Nếu có tệp thì sử dụng đường dẫn tệp đã tải lên
            }

            Brand brand = brandDao.getOne(brandIdStr); // Giả sử có phương thức getOne trong BrandDao

            if (brand != null) {
                Category newCate = new Category(name, image, brand);
                cateDao.create(newCate);
                resp.sendRedirect("category?action=list");
            } else {
                req.setAttribute("errorMessage", "Invalid brand selected.");
                req.getRequestDispatcher("Management/category/categoryForm.jsp").forward(req, resp);
            }
        } catch (Exception e) {
            resp.sendRedirect("category?action=list");
        }
    }

    private void showFormEditCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null && !idStr.isEmpty()) {
            int id = Integer.parseInt(idStr);

            Category cate = cateDao.getOne(id);

            List<Brand> brands = brandDao.getAll();
            req.setAttribute("id", cate.getId());
            req.setAttribute("name", cate.getName());
            req.setAttribute("image", cate.getImage());
            req.setAttribute("brands", brands);
            req.setAttribute("categoryBrandId", cate.getBrand().getId());

            // Chuyển tiếp request sang trang form
            req.getRequestDispatcher("/Management/category/categoryForm.jsp").forward(req, resp);
        }
    }

    private void deleteCate(HttpServletRequest req, HttpServletResponse resp) {
        throw new UnsupportedOperationException("Not supported yet."); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/GeneratedMethodBody
    }

    private void editCate(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            String idStr = req.getParameter("id");
            if (idStr != null && !idStr.isEmpty()) {
                int id = Integer.parseInt(idStr);
                Category cate = cateDao.getOne(id);

                String name = req.getParameter("name");
                Part filePart = req.getPart("image");
                int brandId = Integer.parseInt(req.getParameter("brand_id"));
                Brand brand = brandDao.getOne(brandId);

                String imageUrl = cate.getImage();
                if (filePart != null && filePart.getSize() > 0) {
                    imageUrl = uploadFile(filePart);
                }
                // Giả sử bạn có phương thức để cập nhật thông tin Category
                cate.setName(name);
                cate.setBrand(brand);
                if (imageUrl != null && !imageUrl.isEmpty()) {
                    cate.setImage(imageUrl); // Cập nhật nếu có ảnh mới
                }

                cateDao.update(cate);

                resp.sendRedirect("category?action=list");

            } else {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Category ID is required.");
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error processing category edit.");
        }
    }

}
