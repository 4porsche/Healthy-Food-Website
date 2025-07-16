package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Map;
import repository.OrderDAO;

public class VNPayReturnServlet extends HttpServlet {
   
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            Map<String, String> fields = new HashMap<>();
        Enumeration<String> params = request.getParameterNames();
        while (params.hasMoreElements()) {
            String fieldName = params.nextElement();
            String fieldValue = request.getParameter(fieldName);
            fields.put(fieldName, fieldValue);
        }
        
        // Kiểm tra mã phản hồi
        String vnp_ResponseCode = fields.get("vnp_ResponseCode");
        HttpSession session = request.getSession();
        Integer orderId = (Integer) session.getAttribute("currentOrderId");
        
        // Kiểm tra orderId trong session
        if (orderId == null) {
            response.sendRedirect("payment-result.jsp?status=error&message=Không tìm thấy đơn hàng");
            return;
        }
        
        try {
            OrderDAO orderDAO = new OrderDAO();
            
            if ("00".equals(vnp_ResponseCode)) {
                // Thanh toán thành công
                orderDAO.updateOrderStatus(orderId, "paid");
                session.removeAttribute("cart");
                session.removeAttribute("currentOrderId");
                response.sendRedirect("payment-result.jsp?status=success&orderId=" + orderId);
            } else {
                // Thanh toán thất bại
                orderDAO.updateOrderStatus(orderId, "failed");
                response.sendRedirect("payment-result.jsp?status=failed&orderId=" + orderId);
            }
            
        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("payment-result.jsp?status=error&message=" + e.getMessage());
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
}