package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import repository.ProductDAO;
import model.Product;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/manage-product"})
@MultipartConfig
public class ProductManagementController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);
        HttpSession session = request.getSession();
        int sellerId = 8;

        ProductDAO dao = new ProductDAO();
        List<Product> productList = dao.getMyProduct(sellerId);

        request.setAttribute("productList", productList);

        request.getRequestDispatcher("manage-product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        int sellerId = 8;

        String searchTxt = request.getParameter("txt");
        String sortType_raw = request.getParameter("sort");
        int sortType = 0;

        String action = request.getParameter("action");

        ProductDAO dao = new ProductDAO();
        List<Product> productList = null;

        if (searchTxt != null && !searchTxt.trim().isEmpty()) {
            productList = dao.getMySearchedList(searchTxt.trim(), sellerId);
        } else if (sortType_raw != null && !sortType_raw.trim().isEmpty()) {
            sortType = Integer.parseInt(sortType_raw);
            productList = dao.getMyProductByCategory(sellerId, sortType);
        } else {
            productList = dao.getMyProduct(sellerId);
        }

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String capitalizedName = capitalizeEachWord(name);

            if (dao.checkProductNameExist(capitalizedName)) {
                session.setAttribute("ms", "Tên sản phẩm đã tồn tại!");
            } else {
                int categoryId = Integer.parseInt(request.getParameter("category"));
                int price = Integer.parseInt(request.getParameter("price"));
                String description = request.getParameter("description");
                String ingredient = request.getParameter("ingredient");
                double weight = Double.parseDouble(request.getParameter("weight"));
                double calories = Double.parseDouble(request.getParameter("calories"));
                double protein = Double.parseDouble(request.getParameter("protein"));
                double fat = Double.parseDouble(request.getParameter("fat"));
                double carbs = Double.parseDouble(request.getParameter("carbs"));
                String[] tagsArray = request.getParameterValues("tags");
                Part imagePart = request.getPart("image");
                String imageFileName = Paths.get(imagePart.getSubmittedFileName()).getFileName().toString();
                String uploadPath = getServletContext().getRealPath("/img") + File.separator + imageFileName;
                imagePart.write(uploadPath);

                String tags = tagsArray != null ? String.join(", ", tagsArray) : "";
                String imageUrl = "img/" + imageFileName;
                try {
                    System.out.println("== DỮ LIỆU FORM ==");
                    System.out.println("Tên SP: " + capitalizedName);
                    System.out.println("Danh mục ID: " + categoryId);
                    System.out.println("Giá: " + price);
                    System.out.println("Tags: " + tags);
                    System.out.println("Image path: " + uploadPath);

                    dao.addProduct(sellerId, categoryId, capitalizedName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                    System.out.println("✅ Thêm sản phẩm thành công: " + capitalizedName);

                    
                    response.sendRedirect("manage-product");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    request.getSession().setAttribute("ms", "Lỗi khi thêm sản phẩm");
                }
            }
        }
        request.setAttribute("productList", productList);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("manage-product.jsp").forward(request, response);

    }

    public String capitalizeEachWord(String input) {
        String[] words = input.trim().toLowerCase().split("\\s+");
        StringBuilder sb = new StringBuilder();
        for (String word : words) {
            if (word.length() > 0) {
                sb.append(Character.toUpperCase(word.charAt(0)))
                        .append(word.substring(1))
                        .append(" ");
            }
        }
        return sb.toString().trim();
    }

//    public int mapCategorySlugToId(String slug) {
//        if (slug == null) {
//            return -1;
//        }
//
//        switch (slug) {
//            case "healthy-rolls":
//                return 1;
//            case "low-carbs":
//                return 2;
//            case "vegan-special":
//                return 3;
//            default:
//                return -1; // Hoặc 0/null nếu không hợp lệ
//        }
//    }
}
