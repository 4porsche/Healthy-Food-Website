/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import model.Order;
import model.OrderDetail;
import repository.OrderDAO;
import repository.OrderDetailDAO;

/**
 *
 * @author PC
 */
public class OrderDetailCusServlet extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
       try {
        String orderIdParam = request.getParameter("orderId");
        
        if (orderIdParam == null || orderIdParam.isEmpty()) {
            response.sendRedirect("order-history.jsp?error=Không tìm thấy đơn hàng");
            return;
        }
        
        int orderId = Integer.parseInt(orderIdParam);
        
        OrderDAO orderDAO = new OrderDAO();
        Order order = orderDAO.getOrderById(orderId);
        
        if (order == null) {
            response.sendRedirect("order-history.jsp?error=Không tìm thấy đơn hàng");
            return;
        }
        
        OrderDetailDAO detailDAO = new OrderDetailDAO();
        List<OrderDetail> orderDetails = detailDAO.getOrderDetailsByOrderId(orderId);
        
        request.setAttribute("order", order);
        request.setAttribute("orderDetails", orderDetails);
        
        request.getRequestDispatcher("order-detail.jsp").forward(request, response);
        
    } catch (SQLException | NumberFormatException e) {
        e.printStackTrace();
        response.sendRedirect("order-history.jsp?error=Lỗi hệ thống");
    }}

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
        processRequest(request, response);
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
