package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.nio.file.Paths;
import java.util.List;
import model.Product;
import repository.ProductDAO;

@WebServlet(name = "SellerDashboard", urlPatterns = {"/seller-dashboard"})
public class SellerDashboard extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userid") == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        int sellerId = (Integer) session.getAttribute("userid");

        String action = request.getParameter("action");       // action=product hoặc report
        String subaction = request.getParameter("subaction"); // subaction=search, filter nếu có

        if ("report".equals(action)) {
            // Chỉ forward layout, phần <jsp:include> trong JSP xử lý nội dung
            request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
            return;
        }

        if ("product".equals(action)) {
            ProductDAO dao = new ProductDAO();
            List<Product> productList = null;

            String searchTxt = request.getParameter("txt");
            String sortType_raw = request.getParameter("sort");
            int sortType = 0;

            if ("search".equals(subaction) && searchTxt != null && !searchTxt.trim().isEmpty()) {
                productList = dao.getMySearchedList(searchTxt.trim(), sellerId);
                request.setAttribute("txtS", searchTxt);
            } else if ("filter".equals(subaction) && sortType_raw != null && !sortType_raw.trim().isEmpty()) {
                try {
                    sortType = Integer.parseInt(sortType_raw);
                    productList = dao.getMyProductByCategory(sellerId, sortType);
                    request.setAttribute("sortT", sortType);
                } catch (NumberFormatException e) {
                    productList = dao.getMyProduct(sellerId);
                }
            } else {
                productList = dao.getMyProduct(sellerId);
            }

            request.setAttribute("productList", productList);
            request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
            return;
        }

        // Default fallback
        request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userid") == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        int sellerId = (Integer) session.getAttribute("userid");

        String action = request.getParameter("action");

        ProductDAO dao = new ProductDAO();
        List<Product> productList = null;

        if ("add".equals(action)) {
            String name = request.getParameter("name");
            String capitalizedName = capitalizeFirstLetter(name);

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
                    dao.addProduct(sellerId, categoryId, capitalizedName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                    session.setAttribute("ms", "Thêm sản phẩm thành công");
                    response.sendRedirect("manage-product1");
                    return;
                } catch (Exception e) {
                    e.printStackTrace();
                    session.setAttribute("ms", "Lỗi khi thêm sản phẩm");
                }
            }
        } else if ("delete".equals(action)) {
            try {
                int productId = Integer.parseInt(request.getParameter("productId"));
                dao.deleteProduct(productId);
                session.setAttribute("ms", "Sản phẩm đã được xóa thành công");
                response.sendRedirect("manage-product1");
                return;
            } catch (Exception e) {
                e.printStackTrace();
                session.setAttribute("ms", "Lỗi khi xóa sản phẩm");
            }
        }
        request.setAttribute("productList", productList);

        request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
    }

    public String capitalizeFirstLetter(String input) {
        input = input.trim().toLowerCase();
        return Character.toUpperCase(input.charAt(0)) + input.substring(1);
    }

}
