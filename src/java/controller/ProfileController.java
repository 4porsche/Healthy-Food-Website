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
import java.util.List;
import model.CustomerProfile;
import model.Requests;
import model.User;
import repository.RequestsDao;

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
        HttpSession session = request.getSession();

// Kiểm tra người dùng đã đăng nhập chưa
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

// Kiểm tra userid có hợp lệ không
        String userIdParam = request.getParameter("userid");
        if (userIdParam == null || userIdParam.isEmpty()) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userID;
        try {
            userID = Integer.parseInt(userIdParam);
        } catch (NumberFormatException e) {
            response.sendRedirect("login.jsp");
            return;
        }

// Lấy thông tin khách hàng từ DAO
        ProfileDao dao = new ProfileDao();
        CustomerProfile cp = dao.getCustomer(userID, 3);
        if (cp == null) {
            request.setAttribute("error", "Không tìm thấy hồ sơ khách hàng.");
            request.getRequestDispatcher("customerprofile.jsp").forward(request, response);
            return;
        }

// Lấy danh sách yêu cầu tư vấn
        RequestsDao rd = new RequestsDao();
        List<Requests> requests = rd.getConsultationsByUserId(userID); // sử dụng đúng id người dùng

// Đặt thuộc tính cho JSP
        request.setAttribute("customer", cp);
        request.setAttribute("userid", userID);
        request.setAttribute("requests", requests);

// Chuyển hướng đến trang JSP
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
