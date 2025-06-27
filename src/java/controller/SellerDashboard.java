package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
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
        int sellerId = 8;

        String action = request.getParameter("action");

        if ("report".equals(action)) {
            request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
            return;
        } else if ("product".equals(action)) {
            ProductDAO dao = new ProductDAO();
            List<Product> productList = dao.getMyProduct(sellerId);

            request.setAttribute("productList", productList);

            request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
            return;
        }

        request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("seller-dashboard.jsp").forward(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }

}
