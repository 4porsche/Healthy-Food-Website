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
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.Product;
import model.User;
import repository.AdminDAO;
import repository.ProductDAO;
import repository.UserDAO;

/**
 *
 * @author PC
 */
public class AdminServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    private AdminDAO adminDAO = new AdminDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("doGet action: " + action); // Debug output

        if ("view".equals(action)) {
            List<User> users = adminDAO.getAllUsers();
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        } else if ("search".equals(action)) {
            String query = request.getParameter("query");
            List<User> users = adminDAO.searchUsers(query);
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        } else if ("filter".equals(action)) {
            String roleIdParam = request.getParameter("roleId");
            List<User> users;

            // Xử lý trường hợp "All Roles"
            if ("all".equals(roleIdParam)) {
                users = adminDAO.getAllUsers();
            } else {
                try {
                    int roleId = Integer.parseInt(roleIdParam);
                    users = adminDAO.filterUsersByRole(roleId);
                } catch (NumberFormatException e) {
                    // Xử lý lỗi nếu giá trị không hợp lệ
                    System.err.println("Invalid roleId: " + roleIdParam);
                    users = adminDAO.getAllUsers();
                }
            }
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        } else {
            List<User> users = adminDAO.getAllUsers();
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin-dashboard.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("toggleActive".equals(action)) {
            String email = request.getParameter("email");
            adminDAO.toggleActive(email);
        } else if ("assignRole".equals(action)) {
            String email = request.getParameter("email");
            String roleIdParam = request.getParameter("roleId");

            // XỬ LÝ NULL CHO roleId
            if (roleIdParam == null || roleIdParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing roleId parameter");
                return;
            }

            try {
                int roleId = Integer.parseInt(roleIdParam);
                adminDAO.assignRole(email, roleId);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid roleId format");
                return;
            }
        } else if ("crud".equals(action)) {
            String crudAction = request.getParameter("crudAction");
            String userIdParam = request.getParameter("userId");
            int userId = 0; // Mặc định cho tạo mới

            // CHỈ LẤY userId KHI UPDATE HOẶC DELETE
            if ("update".equals(crudAction) || "delete".equals(crudAction)) {
                if (userIdParam == null || userIdParam.isEmpty()) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing userId parameter");
                    return;
                }
                try {
                    userId = Integer.parseInt(userIdParam);
                } catch (NumberFormatException e) {
                    response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid userId format");
                    return;
                }
            }

            String fullname = request.getParameter("fullname");
            String username = request.getParameter("username");
            String email = request.getParameter("email");

            // QUAN TRỌNG: LẤY PASSWORD TỪ REQUEST
            String password = request.getParameter("password");

            int roleId = 0;
            String roleIdParam = request.getParameter("roleId");
            if (roleIdParam != null && !roleIdParam.isEmpty()) {
                try {
                    roleId = Integer.parseInt(roleIdParam);
                } catch (NumberFormatException e) {
                    // Xử lý tùy chọn nếu cần
                }
            }

            boolean isActive = request.getParameter("isActive") != null;
            String googleId = request.getParameter("googleId");

            // SỬ DỤNG CONSTRUCTOR PHÙ HỢP CHO TỪNG TRƯỜNG HỢP
            User user;
            if ("create".equals(crudAction)) {
                // Constructor cho tạo mới (có password)
                user = new User(userId, fullname, username, password, email, roleId, isActive, googleId);
            } else {
                // Constructor cho update (có userId)
                user = new User(userId, fullname, username, password, email, roleId, isActive, googleId);
            }

            if ("create".equals(crudAction)) {
                adminDAO.createUser(user);
            } else if ("update".equals(crudAction)) {
                adminDAO.updateUser(user);
            } else if ("delete".equals(crudAction)) {
                adminDAO.deleteUser(userId);
            }
        }

        response.sendRedirect("admin-dashboard?action=view");
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
