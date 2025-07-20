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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Cart;
import model.CartItem;
import model.User;
import repository.CartDAO;

/**
 *
 * @author PC
 */
public class UpdateCartServlet extends HttpServlet {
   private CartDAO cartDAO = new CartDAO();
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
            out.println("<title>Servlet UpdateCartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateCartServlet at " + request.getContextPath () + "</h1>");
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
        
           try {
            String productIdParam = request.getParameter("productID");
            String quantityParam = request.getParameter("quantity");
            
            if (productIdParam == null || quantityParam == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing parameters");
                return;
            }
            
            int productId = Integer.parseInt(productIdParam);
            int quantity = Integer.parseInt(quantityParam);
            
            HttpSession session = request.getSession(false); // false = không tạo session mới
            
            // Kiểm tra session và cart
            if (session == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Session not found");
                return;
            }
            
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            if (cart == null) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Cart not found in session");
                return;
            }
            
            if (cart.containsKey(productId)) {
                CartItem item = cart.get(productId);
                item.setQuantity(quantity);
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Product not found in cart");
                return;
            }
            
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid number format");
        } catch (ClassCastException e) {
            response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Invalid cart type in session");
        }
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
