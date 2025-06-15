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
import jakarta.servlet.http.HttpSession;
import model.CustomerProfile;

/**
 *
 * @author Admin
 */
public class ChangePasswordController extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet ChangePasswordController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ChangePasswordController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
//        processRequest(request, response);

//        HttpSession session = request.getSession();
//        CustomerProfile cp = (CustomerProfile) session.getAttribute("account");
//        
        ProfileDao pd = new ProfileDao();
        CustomerProfile cp = pd.getCustomer(3);
        if (cp == null) {
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        String currentpassword = request.getParameter("currentPassword");
        String newpassword = request.getParameter("newPassword");
        String confirmpassword = request.getParameter("confirmPassword");

        if (newpassword.contains(" ") || confirmpassword.contains(" ")) {
            request.setAttribute("error", "Mật khẩu không được chứa dấu cách!");
             request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        if (currentpassword.equals(newpassword)) {
            request.setAttribute("error", "Mật khẩu mới và mật khẩu cu giong nhau!");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        if (!currentpassword.equals(pd.getCustomer(cp.getUserid()).getPassword())) {
            request.setAttribute("error", "Sai mật khẩu hiện tại");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        if (!confirmpassword.equals(newpassword)) {
            request.setAttribute("error", "Mật khẩu mới và mật khẩu xác nhận khác nhau!");
            request.getRequestDispatcher("changepassword.jsp").forward(request, response);
            return;
        }

        pd.changePass(newpassword, cp.getUserid());
        request.setAttribute("success", "Đổi mật khẩu thành công!");
        request.getRequestDispatcher("profile").forward(request, response);
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
