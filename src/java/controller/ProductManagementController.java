package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import repository.ProductDAO;
import model.Product;

@WebServlet(name = "ProductManagementController", urlPatterns = {"/manage-product"})
public class ProductManagementController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        processRequest(request, response);

        ProductDAO dao = new ProductDAO();
        List<Product> productList = dao.getMyProduct(8);

        request.setAttribute("productList", productList);

        request.getRequestDispatcher("manage-product.jsp").forward(request, response);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        
        String searchTxt = request.getParameter("txt");
        String sortType_raw = request.getParameter("sort");
        int sortType = 0;
        
        String action = request.getParameter("action");
        

        ProductDAO dao = new ProductDAO();
        List<Product> productList = null;

        if (searchTxt != null && !searchTxt.trim().isEmpty()) {
            productList = dao.getMySearchedList(searchTxt.trim(), 8);
        } else if (sortType_raw != null && !sortType_raw.trim().isEmpty()) {
            sortType = Integer.parseInt(sortType_raw);
            productList = dao.getMyProductByCategory(8, sortType);
        } else {
            productList = dao.getMyProduct(8);
        }
        
        if ("add".equals(action)) {
            String name = request.getParameter("name");
            
            if (dao.checkProductNameExist(name)) {
                session.setAttribute("ms", "Tên sản phẩm đã tồn tại!");
            } else {
                // test
                int sellerId = 8;
                int categoryId = Integer.parseInt(request.getParameter("category"));
                int price = Integer.parseInt(request.getParameter("price"));
                String description = request.getParameter("description");
                String ingredient = request.getParameter("ingredient");
                double weight = Double.parseDouble(request.getParameter("weight"));
                double calories = Double.parseDouble(request.getParameter("calories"));
                double protein = Double.parseDouble(request.getParameter("protein"));
                double fat = Double.parseDouble(request.getParameter("fat"));
                double carbs = Double.parseDouble(request.getParameter("carbs"));
                String tags = request.getParameter("tags");
                String imageUrl = request.getParameter("imageUrl");
                
                dao.addProduct(sellerId, categoryId, name, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
            }
        }
        request.setAttribute("productList", productList);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("manage-product.jsp").forward(request, response);

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
