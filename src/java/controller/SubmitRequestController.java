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
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import model.User;
import repository.RequestsDao;

/**
 *
 * @author Admin
 */
public class SubmitRequestController extends HttpServlet {

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
            out.println("<title>Servlet SubmitRequestController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SubmitRequestController at " + request.getContextPath() + "</h1>");
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
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        HttpSession session = request.getSession();
        RequestsDao rd = new RequestsDao();

        String preferredDateStr = request.getParameter("preferredDate");

        try {
            // Lấy User từ session
            User user = (User) session.getAttribute("user");
//            if (user == null) {
//                session.setAttribute("requestMessage", "Bạn cần đăng nhập để gửi yêu cầu.");
//                response.sendRedirect("login.jsp");
//                return;
//            }

            int customerId = user.getUserID(); // Lấy ID từ user trong session
            session.setAttribute("customerId", customerId); // Lưu vào session nếu muốn sử dụng sau

            if (preferredDateStr == null || preferredDateStr.trim().isEmpty()) {
                session.setAttribute("requestMessage", "Vui lòng chọn ngày tư vấn mong muốn.");
                response.sendRedirect("profile?userid=" + customerId);
                return;
            }

            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd'T'HH:mm");
            Date preferredDate = sdf.parse(preferredDateStr);
            Date now = new Date();
            if (preferredDate.before(now)) {
                session.setAttribute("requestMessage", "Thời gian tư vấn phải sau thời gian hiện tại.");
                response.sendRedirect("profile?userid=" + customerId);
                return;
            }
            // Thêm yêu cầu và nhận lại object đã có RequestID
            rd.addRequest(customerId, preferredDate);

            session.setAttribute("requestMessage", "Yêu cầu tư vấn đã được gửi thành công!");
        } catch (SQLException e) {
            e.printStackTrace();
            session.setAttribute("requestMessage", "Lỗi khi gửi yêu cầu: " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("requestMessage", "Dữ liệu không hợp lệ. Vui lòng kiểm tra lại.");
        }

        response.sendRedirect("profile?userid=" + session.getAttribute("customerId"));

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
