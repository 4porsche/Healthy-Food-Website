package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.Map;
import model.Product;
import model.Categories;
import repository.ProductDAO;

@WebServlet(name = "MyProductController", urlPatterns = {"/my-products"})
public class MyProductController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
//        HttpSession session = request.getSession(false);
//        int sellerId = 0;
//        
//        if (session != null) {
//            sellerId = (int) session.getAttribute("userId");
//        }

        ProductDAO dao = new ProductDAO();
        Map<String, Integer> categoriesList = dao.getMyProductCountByCategory(8);
//        Map<String, Integer> categoriesList = dao.getProductCountByCategoryBySeller(sellerId);

        List<Product> myProductList = dao.getMyProduct(8);
//        List<Product> myProductList = dao.getMyProduct(sellerId);

        request.setAttribute("categoriesList", categoriesList);
        request.setAttribute("myProductList", myProductList);
        request.getRequestDispatcher("my-products.jsp").forward(request, response);
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
            productList = dao.getMyProduct(8);
        } else if ("newest".equals(sortType)) {
            sortedList = dao.sortMyProductNewestList(8);
        } else if ("popular".equals(sortType)) {
            sortedList = dao.sortMyProductPopularList(8);
        }

        Map<String, Integer> categoriesList = dao.getMyProductCountByCategory(8);

        request.setAttribute("productList", productList);
        request.setAttribute("categoriesList", categoriesList);
        request.setAttribute("searchedList", searchedList);
        request.setAttribute("sortedList", sortedList);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("my-products.jsp").forward(request, response);
    }

}
