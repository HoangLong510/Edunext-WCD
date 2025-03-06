package servlets;

import dao.BrandDao;
import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import models.Brand;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.List;

@MultipartConfig
public class BrandServlet extends HttpServlet {

    BrandDao brandDao;

    @Override
    public void init() throws ServletException {
        super.init();
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
                showListBrand(req, resp);
                break;
            case "add":
                showFormAddBrand(req, resp);
                break;
            case "edit":
                showFormEditBrand(req, resp);
                break;
            case "delete":
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
        brandDao.create(newBrand);
        resp.sendRedirect("brand");
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
            brandDao.update(brand);

            // Sau khi cập nhật thành công, chuyển hướng về trang danh sách
            resp.sendRedirect("brand");
        } else {
            // Nếu không tìm thấy thương hiệu, gửi lỗi
            resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Brand not found");
        }
    }

}
