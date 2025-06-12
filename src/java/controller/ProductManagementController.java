package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import repository.ProductDAO;
import model.Product;

@WebServlet(name="ProductManagementController", urlPatterns={"/manage-product"})
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
        processRequest(request, response);
    }

    
}
