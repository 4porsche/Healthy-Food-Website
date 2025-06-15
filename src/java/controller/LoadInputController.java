/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import repository.ProfileDao;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.CustomerProfile;

/**
 *
 * @author Admin
 */
public class LoadInputController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try {
            String userIdRaw = request.getParameter("userid");

            // Kiểm tra null hoặc rỗng
            if (userIdRaw == null || userIdRaw.isEmpty()) {
                request.setAttribute("error", "Chưa có ID người dùng.");
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

            // Kiểm tra có phải số hay không
            int userID;
            try {
                userID = Integer.parseInt(userIdRaw);
            } catch (NumberFormatException e) {
                request.setAttribute("error", "ID người dùng không hợp lệ.");
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

            // Lấy thông tin người dùng
            ProfileDao dao = new ProfileDao();
            CustomerProfile cp = dao.getCustomer(userID);

            // Kiểm tra người dùng có tồn tại không
            if (cp == null) {
                request.setAttribute("error", "Không tìm thấy thông tin người dùng.");
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

            // Gửi thông tin đến form update
            request.setAttribute("loadcustomer", cp);
            request.getRequestDispatcher("inputbody.jsp").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống.");
            request.getRequestDispatcher("inputbody.jsp").forward(request, response);
        }

    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
