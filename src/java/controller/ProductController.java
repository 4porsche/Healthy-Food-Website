package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Set;
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
        HttpSession session = request.getSession();
        if (session == null || session.getAttribute("userid") == null) {
            response.sendRedirect("login.jsp?error=sessionExpired");
            return;
        }

        int sellerId = (Integer) session.getAttribute("userid");

        String searchTxt = request.getParameter("txt");
        String sortType = request.getParameter("sort");
        String selectedTag = request.getParameter("tag");
        String categoryId_raw = request.getParameter("categoryId");
        int categoryId = -1;
        if (categoryId_raw != null && !categoryId_raw.trim().isEmpty()) {
            categoryId = Integer.parseInt(categoryId_raw);
        }

        ProductDAO dao = new ProductDAO();

        List<Product> productList = null;

        if (selectedTag != null && !selectedTag.trim().isEmpty()) {
            productList = dao.getProductByTag(selectedTag);
            
        } else if (categoryId != -1) {
            productList = dao.getProductByCategory(categoryId);
            
        } else if (searchTxt != null && !searchTxt.trim().isEmpty()) {
            productList = dao.getSearchedList(searchTxt);
            productList = (productList != null) ? productList : new ArrayList<>();
            
        } else if (sortType != null && !sortType.trim().isEmpty()) {
            if ("newest".equals(sortType)) {
                productList = dao.sortProductNewestList();
            } else {
                productList = dao.sortProductPopularList();
            }
            
        } else {
            productList = dao.getAllProduct();
        }

        Map<Integer, String> categoryNameMap = dao.getCategoryMap();
        Map<Integer, Integer> categoryCountMap = dao.getProductCountByCategory();

        Set<String> allTags = dao.getAllTags();

        request.setAttribute("tagList", allTags);
        request.setAttribute("productList", productList);
        request.setAttribute("categoryNameMap", categoryNameMap);
        request.setAttribute("categoryCountMap", categoryCountMap);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
    }

}
