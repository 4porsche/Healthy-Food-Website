package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import model.User;
import repository.AdminDAO;

public class AdminServlet extends HttpServlet {
    
    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        System.out.println("doGet action: " + action);

        if ("view".equals(action)) {
            List<User> users = adminDAO.getAllUsers();
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else if ("search".equals(action)) {
            String query = request.getParameter("query");
            List<User> users = adminDAO.searchUsers(query);
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else if ("filter".equals(action)) {
            String roleIdParam = request.getParameter("roleId");
            List<User> users;
            
            if ("all".equals(roleIdParam)) {
                users = adminDAO.getAllUsers();
            } else {
                try {
                    int roleId = Integer.parseInt(roleIdParam);
                    users = adminDAO.filterUsersByRole(roleId);
                } catch (NumberFormatException e) {
                    System.err.println("Invalid roleId: " + roleIdParam);
                    users = adminDAO.getAllUsers();
                }
            }
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
        } else {
            List<User> users = adminDAO.getAllUsers();
            request.setAttribute("userList", users);
            request.getRequestDispatcher("admin.jsp").forward(request, response);
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
            int userId = 0;
            
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
            String password = request.getParameter("password");
            
            // THÊM TRƯỜNG PHONE
            String phone = request.getParameter("phone");
            
            int roleId = 0;
            String roleIdParam = request.getParameter("roleId");
            if (roleIdParam != null && !roleIdParam.isEmpty()) {
                try {
                    roleId = Integer.parseInt(roleIdParam);
                } catch (NumberFormatException e) {
                    // Xử lý nếu cần
                }
            }

            boolean isActive = request.getParameter("isActive") != null;
            String googleId = request.getParameter("googleId");
            
            // Tạo user với thông tin phone mới
            User user = new User();
            user.setUserID(userId);
            user.setFullname(fullname);
            user.setUsername(username);
            user.setPassword(password);
            user.setEmail(email);
            user.setPhone(phone); // THIẾT LẬP PHONE
            user.setRoleID(roleId);
            user.setIsActive(isActive);
            user.setGoogleId(googleId);
            
            if ("create".equals(crudAction)) {
                adminDAO.createUser(user);
            } else if ("update".equals(crudAction)) {
                adminDAO.updateUser(user);
            } else if ("delete".equals(crudAction)) {
                adminDAO.deleteUser(userId);
            }
        }

        response.sendRedirect("AdminServlet?action=view");
    }
    
    @Override
    public String getServletInfo() {
        return "Admin Management Servlet";
    }
}