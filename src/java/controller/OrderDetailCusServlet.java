package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import repository.OrderDAO;
import repository.OrderDetailDAO;


public class OrderDetailCusServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        System.out.println("[DEBUG] OrderDetailCusServlet started");
        
        try {
            String orderIdParam = request.getParameter("orderID");
            System.out.println("[DEBUG] orderIdParam: " + orderIdParam);
            
            if (orderIdParam == null || orderIdParam.isEmpty()) {
                System.out.println("[ERROR] Missing orderId parameter");
                response.sendRedirect("order-history?error=Không tìm thấy đơn hàng");
                return;
            }
            
            int orderId = Integer.parseInt(orderIdParam);
            System.out.println("[DEBUG] Parsed orderId: " + orderId);
            
            OrderDAO orderDAO = new OrderDAO();
            Order order = orderDAO.getOrderById(orderId);
            System.out.println("[DEBUG] Order: " + order);
            
            if (order == null) {
                System.out.println("[ERROR] Order not found for id: " + orderId);
                response.sendRedirect("order-history?error=Không tìm thấy đơn hàng");
                return;
            }
            
            OrderDetailDAO detailDAO = new OrderDetailDAO();
            List<OrderDetail> orderDetails = detailDAO.getOrderDetailsByOrderId(orderId);
            System.out.println("[DEBUG] Order details count: " + (orderDetails != null ? orderDetails.size() : 0));
            
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            
            System.out.println("[DEBUG] Forwarding to order-detail.jsp");
            request.getRequestDispatcher("order-detail.jsp").forward(request, response);
            
        } catch (SQLException e) {
            System.err.println("[SQL ERROR] " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi cơ sở dữ liệu: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            System.err.println("[FORMAT ERROR] Invalid orderId format");
            e.printStackTrace();
            response.sendRedirect("order-history?error=ID đơn hàng không hợp lệ");
        } catch (Exception e) {
            System.err.println("[GENERAL ERROR] " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("errorMessage", "Lỗi hệ thống: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
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

    @Override
    public String getServletInfo() {
        return "Order Detail Servlet";
    }
}