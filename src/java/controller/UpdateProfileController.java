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
import model.CustomerProfile;
import repository.ProfileDao;

/**
 *
 * @author Admin
 */
public class UpdateProfileController extends HttpServlet {

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
            out.println("<title>Servlet UpdateProfileController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet UpdateProfileController at " + request.getContextPath() + "</h1>");
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
        try {
            int userID;
            ProfileDao pd = new ProfileDao();

            try {
                userID = Integer.parseInt(request.getParameter("userid"));
                if (userID <= 0) {
                    throw new NumberFormatException();
                }
            } catch (NumberFormatException e) {
                request.setAttribute("error", "User ID không hợp lệ.");
                request.getRequestDispatcher("profile").forward(request, response);
                return;
            }

            String fullname = request.getParameter("fullname");
            String email = request.getParameter("email");
            String phone = request.getParameter("phone");
            String gender = request.getParameter("gender");

            CustomerProfile cp = pd.getCustomer(userID, 3); // giả định role = 3

            if (fullname == null || fullname.trim().isEmpty()) {
                request.setAttribute("error", "Họ và tên không được để trống.");
                request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("profile").forward(request, response);
                return;
            }

            if (email == null || !email.matches("^[\\w.-]+@[\\w.-]+\\.[a-zA-Z]{2,6}$")) {
                request.setAttribute("error", "Email không hợp lệ.");
                request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("profile").forward(request, response);
                return;
            }

            if (phone == null || !phone.matches("^(0|\\+84)[0-9]{9}$")) {
                request.setAttribute("error", "Số điện thoại không hợp lệ.");
                request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("profile").forward(request, response);
                return;
            }

            if (gender == null || (!gender.equalsIgnoreCase("Nam") && !gender.equalsIgnoreCase("Nữ"))) {
                request.setAttribute("error", "Giới tính phải là Nam hoặc Nữ.");
                request.setAttribute("loadcustomer", cp);
                request.getRequestDispatcher("profile").forward(request, response);
                return;
            }

            // Cập nhật dữ liệu
            pd.updateprofilecustomer(phone, gender, userID, 3);
            pd.updateprofileuser(fullname, email, userID, 3);

            // Lấy lại thông tin đã cập nhật
            CustomerProfile updatedProfile = pd.getCustomer(userID, 3);

            // Lưu vào session
            HttpSession session = request.getSession();
            session.setAttribute("account", updatedProfile);

            request.setAttribute("success", "Cập nhật thành công.");
            request.setAttribute("customer", updatedProfile); // nếu cần giữ lại form

            request.getRequestDispatcher("profile").forward(request, response);

        } catch (Exception ex) {
            ex.printStackTrace();
            request.setAttribute("error", "Đã xảy ra lỗi khi cập nhật.");
            request.getRequestDispatcher("profile").forward(request, response);
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
