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
import repository.ProductDAO;
import model.Product;

@WebServlet(name = "EditProductController", urlPatterns = {"/edit-product"})
@MultipartConfig
public class EditProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("pid"));
        ProductDAO dao = new ProductDAO();
        Product p = dao.getProductById(id);
        request.setAttribute("detail", p);
        request.getRequestDispatcher("edit-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        HttpSession session = request.getSession();
        int sellerId = 8;

        ProductDAO dao = new ProductDAO();

        String name = request.getParameter("name");
        String capitalizedName = capitalizeEachWord(name);
        int id = Integer.parseInt(request.getParameter("id"));
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

        if (dao.checkProductNameExist(capitalizedName)) {
            session.setAttribute("ms", "Tên sản phẩm đã tồn tại!");
            request.getRequestDispatcher("edit-product.jsp").forward(request, response);
        } else {
            try {
                dao.updateProduct(id, sellerId, categoryId, name, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                session.setAttribute("ms", "Cập nhật sản phẩm thành công");
                response.sendRedirect("manage-product");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("ms", "Lỗi khi thêm sản phẩm");
            }
        }
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

}
