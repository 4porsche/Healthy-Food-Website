/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import dal.ProfileDao;
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
public class EditProfileController extends HttpServlet {

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
            out.println("<title>Servlet EditProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet EditProfileController at " + request.getContextPath() + "</h1>");
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
//        response.setContentType("text/html;charset=UTF-8");
        try {
            int userID;
             ProfileDao pd = new ProfileDao();
                     
            try {
                userID = Integer.parseInt(request.getParameter("userid"));
                if (userID <= 0) {
                    throw new NumberFormatException("User ID must be positive.");
                }
            } catch (NumberFormatException e) {
                
                request.setAttribute("error", "User ID không hợp lệ.");
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }
            
            double height, weight, BMI;
                CustomerProfile cp = pd.getCustomer(userID);
            try {
                height = Double.parseDouble(request.getParameter("height"));
                weight = Double.parseDouble(request.getParameter("weight"));
                BMI = Double.parseDouble(request.getParameter("bmi"));
            } catch (NumberFormatException e) {
                request.setAttribute("error", "Chiều cao, cân nặng, và BMI phải là số.");
                request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

            if (height <= 0 || height > 300 || weight <= 0 || weight > 300 || BMI <= 0 || BMI > 100) {
                request.setAttribute("error", "Chiều cao, cân nặng, hoặc BMI không hợp lệ (quá lớn hoặc nhỏ).");
                 request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

            String activity = request.getParameter("activitylevel");
            String goal = request.getParameter("goal");

            if (activity == null || activity.trim().isEmpty() || goal == null || goal.trim().isEmpty()) {
                request.setAttribute("error", "Mức độ hoạt động và mục tiêu không được để trống.");
                 request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("inputbody.jsp").forward(request, response);
                return;
            }

           

            pd.update(height, weight, BMI, activity, goal, userID);
            request.getRequestDispatcher("profile").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Có lỗi xảy ra trong quá trình cập nhật.");
            request.getRequestDispatcher("inputbody.jsp").forward(request, response);
        }
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
