package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import model.CartItem;
import model.Order;
import model.OrderDetail;
import model.User;
import repository.OrderDetailDAO;
import repository.OrderDAO;
import util.VNPayHelper;

public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        
        // Kiểm tra đăng nhập
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        String fullname = request.getParameter("fullname");
        String phone = request.getParameter("phone");
        String email = request.getParameter("email");
        String address = request.getParameter("address");
        String paymentMethod = request.getParameter("paymentMethod");
        
        // Lấy giỏ hàng từ session
        Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
        
        // Kiểm tra giỏ hàng rỗng
        if (cart == null || cart.isEmpty()) {
            response.sendRedirect("cart.jsp?error=Giỏ hàng trống");
            return;
        }
        
        // Tính tổng tiền
        int total = 0;
        for (CartItem item : cart.values()) {
            total += item.getPrice() * item.getQuantity();
        }
        
        // Tạo đối tượng Order - sử dụng userID từ session
        Order order = new Order();
        order.setUserID(user.getUserID()); // Lưu userID của người dùng
        order.setCustomerName(fullname);
        order.setCustomerPhone(phone);
        order.setCustomerEmail(email);
        order.setDeliveryAddress(address);
        order.setTotalPrice(total);
        order.setDeliveryStatus("pending");
        order.setOrderDate(new java.sql.Date(System.currentTimeMillis()));
        
        // Tạo danh sách OrderDetail
        List<OrderDetail> orderDetails = new ArrayList<>();
        for (CartItem item : cart.values()) {
            OrderDetail detail = new OrderDetail();
            detail.setProductID(item.getProductID());
            detail.setQuantity(item.getQuantity());
            detail.setPrice((int) item.getPrice());
            detail.setProductName(item.getProductName());
            detail.setImage(item.getImageUrl());
            orderDetails.add(detail);
        }
        
        try {
            // Lưu đơn hàng vào database
            OrderDAO orderDAO = new OrderDAO();
            int orderId = orderDAO.createOrder(order);
            
            // Đặt orderId cho từng chi tiết đơn hàng
            for (OrderDetail detail : orderDetails) {
                detail.setOrderID(orderId);
            }
            
            // Lưu chi tiết đơn hàng
            OrderDetailDAO detailDAO = new OrderDetailDAO();
            detailDAO.createOrderDetails(orderDetails);
            
            // Xử lý thanh toán VNPay
            if ("vnpay".equals(paymentMethod)) {
                // Lưu orderId vào session để sử dụng sau này
                session.setAttribute("currentOrderId", orderId);
                
                // Tạo URL thanh toán VNPay
                String paymentUrl = VNPayHelper.createVNPayPaymentUrl(orderId, total);
                
                // Chuyển hướng đến trang thanh toán VNPay
                if (paymentUrl != null) {
                    response.sendRedirect(paymentUrl);
                } else {
                    throw new ServletException("Không thể tạo URL thanh toán VNPay");
                }
            } else {
                // Thanh toán COD
                session.removeAttribute("cart");
                session.removeAttribute("currentOrderId");
                response.sendRedirect("payment-result.jsp?status=success");
            }
            
        } catch (SQLException | ServletException e) {
            e.printStackTrace();
            response.sendRedirect("payment-result.jsp?status=error");
        }
    }
}