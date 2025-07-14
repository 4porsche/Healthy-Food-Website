package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;
import model.Product;
import model.Categories;
import model.Users;
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
            productList = dao.getMyProductByTag(sellerId, selectedTag);
        } else if (categoryId != -1) {
            productList = dao.getMyProductByCategory(8, categoryId);
        } else if (searchTxt != null && !searchTxt.trim().isEmpty()) {
            productList = dao.getMySearchedList(searchTxt, sellerId);
        } else if (sortType != null && !sortType.trim().isEmpty()) {
            if ("newest".equals(sortType)) {
                productList = dao.sortMyProductNewestList(sellerId);
            } else {
                productList = dao.sortMyProductPopularList(sellerId);
            }
        } else {
            productList = dao.getMyProduct(sellerId);
        }

        Map<Integer, String> categoryNameMap = dao.getCategoryMap();
        Map<Integer, Integer> categoryCountMap = dao.getMyProductCountByCategory(sellerId);

        Set<String> allTags = dao.getAllTagsBySeller(sellerId);

        request.setAttribute("tagList", allTags);
        request.setAttribute("productList", productList);
        request.setAttribute("categoryNameMap", categoryNameMap);
        request.setAttribute("categoryCountMap", categoryCountMap);
        request.setAttribute("selectedCategoryId", categoryId);
        request.setAttribute("txtS", searchTxt);
        request.setAttribute("sortT", sortType);
        request.getRequestDispatcher("my-products.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

    }

}
