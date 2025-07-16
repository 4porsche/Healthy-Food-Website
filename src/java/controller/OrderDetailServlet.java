/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import jakarta.servlet.RequestDispatcher;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.util.List;
import model.Order;
import repository.ManagerDAO;
import java.sql.SQLException;
import java.util.logging.Logger;
import model.OrderDetail;

/**
 *
 * @author PC
 */

public class OrderDetailServlet extends HttpServlet {
   private static final Logger logger = Logger.getLogger(OrderDetailServlet.class.getName());
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet OrderDetailServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet OrderDetailServlet at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        String orderIdParam = request.getParameter("id");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            logger.warning("Missing order ID parameter");
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing order ID");
            return;
        }
        
        try {
            int orderId = Integer.parseInt(orderIdParam);
            ManagerDAO dao = new ManagerDAO();
            
            // Lấy thông tin đơn hàng
            Order order = dao.getOrderById(orderId);
            if (order == null) {
                logger.warning("Order not found for ID: " + orderId);
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Order not found");
                return;
            }
            
            // Lấy chi tiết đơn hàng
            List<OrderDetail> orderDetails = dao.getOrderDetails(orderId);
            
            // Đặt thuộc tính cho JSP
            request.setAttribute("order", order);
            request.setAttribute("orderDetails", orderDetails);
            
            // Chuyển tiếp đến JSP
            RequestDispatcher dispatcher = request.getRequestDispatcher("/orderDetail.jsp");
            dispatcher.forward(request, response);
            
        } catch (NumberFormatException e) {
            logger.warning("Invalid order ID format: " + orderIdParam);
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid order ID format");
        } catch (SQLException e) {
            logger.severe("Database error: " + e.getMessage());
            e.printStackTrace();
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Database error");
        }
    
    
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    }

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
