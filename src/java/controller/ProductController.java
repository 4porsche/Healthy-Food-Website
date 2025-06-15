package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.Product;
import repository.ProductDAO;

@WebServlet(name = "ProductController", urlPatterns = {"/products"})
public class ProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        ProductDAO dao = new ProductDAO();
        Map<String, Integer> categoriesList = dao.getProductCountByCategory();
        List<Product> productList = dao.getAllProduct();

        request.setAttribute("categoriesList", categoriesList);
        request.setAttribute("productList", productList);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String searchTxt = request.getParameter("txt");
        String sortType = request.getParameter("sort");

        ProductDAO dao = new ProductDAO();

        List<Product> productList = null;
        List<Product> searchedList = dao.getSearchedList(searchTxt);
        List<Product> sortedList = null;
        
        if (sortType == null || sortType.isEmpty()) {
            productList = dao.getAllProduct();
        }
        else if ("newest".equals(sortType)) {
            sortedList = dao.sortNewestList();
        } else if ("popular".equals(sortType))  {
            sortedList = dao.sortPopularList();
        }
        
        Map<String, Integer> categoriesList = dao.getProductCountByCategory();
        
        request.setAttribute("productList", productList);
        request.setAttribute("categoriesList", categoriesList);
        request.setAttribute("searchedList", searchedList);
        request.setAttribute("sortedList", sortedList);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

}
