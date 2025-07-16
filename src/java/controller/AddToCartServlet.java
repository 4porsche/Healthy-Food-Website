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
import java.util.HashMap;
import java.util.Map;
import model.CartItem;

/**
 *
 * @author PC
 */
public class AddToCartServlet extends HttpServlet {
   
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
            out.println("<title>Servlet AddToCartServlet</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet AddToCartServlet at " + request.getContextPath () + "</h1>");
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
            // Lấy thông tin sản phẩm từ request
            int productId = Integer.parseInt(request.getParameter("productId"));
            String productName = request.getParameter("productName");
            double price = Double.parseDouble(request.getParameter("price"));
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            String imageUrl = request.getParameter("imageUrl");
            
            // Tạo đối tượng CartItem
            CartItem item = new CartItem(productId, productName, price, quantity, imageUrl);
            
            // Lấy giỏ hàng từ session
            HttpSession session = request.getSession();
            Map<Integer, CartItem> cart = (Map<Integer, CartItem>) session.getAttribute("cart");
            
            // Nếu giỏ hàng chưa tồn tại, tạo mới
            if (cart == null) {
                cart = new HashMap<>();
            }
            
            // Kiểm tra sản phẩm đã có trong giỏ hàng chưa
            if (cart.containsKey(productId)) {
                // Nếu có, cập nhật số lượng
                CartItem existingItem = cart.get(productId);
                existingItem.setQuantity(existingItem.getQuantity() + quantity);
            } else {
                // Nếu chưa, thêm sản phẩm mới vào giỏ hàng
                cart.put(productId, item);
            }
            
            // Lưu giỏ hàng vào session
            session.setAttribute("cart", cart);
            
            // Chuyển hướng đến trang giỏ hàng
            response.sendRedirect("cart.jsp");
        } catch (NumberFormatException e) {
            e.printStackTrace();
            response.sendRedirect("error.jsp");
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
