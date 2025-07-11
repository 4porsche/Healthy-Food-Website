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
public class ProfileController extends HttpServlet {

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
        ProfileDao dao = new ProfileDao();
        if (request.getParameter("userid") == null || request.getParameter("userid").isEmpty()) {
//            request.setAttribute("error", "Chưa có ID người dùng.");
            request.getRequestDispatcher("login.jsp").forward(request, response);
            return;
        }
        int userID = Integer.parseInt(request.getParameter("userid"));
        HttpSession session = request.getSession();
        CustomerProfile cp = (CustomerProfile) session.getAttribute("account");
        cp = dao.getCustomer(userID, 3);
//            CustomerProfile cp = dao.getCustomer(3);
        if (cp == null) {
            request.getRequestDispatcher("customerprofile.jsp").forward(request, response);
            return;
        }
        request.setAttribute("userid", userID);
        request.setAttribute("customer", cp);
        request.getRequestDispatcher("customerprofile.jsp").forward(request, response);
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
//        String fullname = request.getParameter("fullname");
//        String email = request.getParameter("email");
//        String phone = request.getParameter("phone");
//        String gender = request.getParameter("gender");
//        int height = Integer.parseInt(request.getParameter("height"));
//        int weight = Integer.parseInt(request.getParameter("weight"));
//        double BMI = Integer.parseInt(request.getParameter("BMI"));
//        String activity = request.getParameter("activitylevel");
//        String goal = request.getParameter("goal");

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
