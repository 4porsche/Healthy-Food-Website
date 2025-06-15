package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import java.util.Map;
import repository.ProductDAO;
import model.Product;

@WebServlet(name = "ProductDetailController", urlPatterns = {"/product-detail"})
public class ProductDetailController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        int productId = Integer.parseInt(request.getParameter("pid"));

        ProductDAO dao = new ProductDAO();
        Map<String, Integer> categoriesList = dao.getProductCountByCategory();
        request.setAttribute("categoriesList", categoriesList);
        
        Product detail = dao.getProductById(productId);
        request.setAttribute("detail", detail);

        if (detail != null) {
            List<Product> similarProducts = dao.getSimilarProducts(detail.getCategoryId(), productId);
            request.setAttribute("similarProducts", similarProducts);
        }

        request.getRequestDispatcher("product-detail.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

}
