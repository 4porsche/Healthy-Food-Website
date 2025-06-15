/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.JsonObject;
import com.google.gson.JsonParser;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.Base64;
import model.User;
import repository.UserDAO;

/**
 *
 * @author PC
 */
public class GoogleLoginServlet extends HttpServlet {

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
            out.println("<title>Servlet GoogleLoginServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet GoogleLoginServlet at " + request.getContextPath() + "</h1>");
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
            String idToken = request.getParameter("id_token");
            if (idToken == null || idToken.isEmpty()) {
                response.sendRedirect("login.jsp?error=google");
                return;
            }
            
            JsonObject payload = decodeIdToken(idToken);
            if (payload == null) {
                response.sendRedirect("login.jsp?error=google");
                return;
            }

            String googleId = payload.get("sub").getAsString();
            String email = payload.get("email").getAsString();
            String fullname = payload.get("name").getAsString();

            System.out.println("Google Login Attempt:");
            System.out.println("Google ID: " + googleId);
            System.out.println("Email: " + email);
            System.out.println("Fullname: " + fullname);

            UserDAO dao = new UserDAO();
            
            // Kiểm tra email đã tồn tại và chưa liên kết với Google
            User existingUserByEmail = dao.getUserByEmail(email);
            if (existingUserByEmail != null && 
                (existingUserByEmail.getGoogleId() == null || existingUserByEmail.getGoogleId().isEmpty())) {
                System.out.println("Email already exists but not linked to Google: " + email);
                response.sendRedirect("login.jsp?error=google_email_exists");
                return;
            }

            // Tiếp tục xử lý
            User user = dao.getUserByGoogleId(googleId);
            
            if (user == null) {
                System.out.println("No user found with Google ID, checking by email...");
                
                // Nếu email đã tồn tại và đã liên kết với Google
                if (existingUserByEmail != null) {
                    System.out.println("Linking existing account to Google: " + email);
                    user = existingUserByEmail;
                } else {
                    System.out.println("Creating new user for Google: " + email);
                    dao.addGoogleUser(googleId, fullname, email);
                    user = dao.getUserByGoogleId(googleId);
                    
                    if (user == null) {
                        System.out.println("Failed to create new user");
                        response.sendRedirect("login.jsp?error=google");
                        return;
                    }
                }
            }

            // Đăng nhập thành công
            loginSuccess(request, response, user);
            
        } catch (Exception e) {
            System.err.println("Error in GoogleLoginServlet:");
            e.printStackTrace();
            response.sendRedirect("login.jsp?error=system");
        }
    }

    private void loginSuccess(HttpServletRequest request, HttpServletResponse response, User user) 
            throws IOException {
        // Đảm bảo roleID = 3 nếu là user mới
        if (user.getRoleID() == 0) {
            user.setRoleID(3);
        }

        HttpSession session = request.getSession();
        session.setAttribute("user", user);
        session.setAttribute("fullname", user.getFullname());
        
        // Tạo username từ email nếu không có
        if (user.getUsername() == null || user.getUsername().isEmpty()) {
            String username = user.getEmail().split("@")[0];
            session.setAttribute("username", username);
        } else {
            session.setAttribute("username", user.getUsername());
        }

        System.out.println("Login successful for: " + user.getEmail());
        System.out.println("Role ID: " + user.getRoleID());

        // Chuyển hướng dựa trên role
        int roleID = user.getRoleID();
        if (roleID == 1) {
            response.sendRedirect("admin.jsp");
        } else if (roleID == 3 || roleID == 0) {
            response.sendRedirect("home.jsp");
        } else if (roleID == 5) {
            response.sendRedirect("seller.jsp");
        } else if (roleID == 6) {
            response.sendRedirect("shipper.jsp");
        } else {
            response.sendRedirect("login.jsp?error=role");
        }
    }

    private JsonObject decodeIdToken(String idToken) {
        try {
            String[] parts = idToken.split("\\.");
            if (parts.length < 2) {
                System.out.println("Invalid JWT format");
                return null;
            }

            // Sử dụng Base64.getUrlDecoder() thay vì getDecoder()
            byte[] decodedBytes = Base64.getUrlDecoder().decode(parts[1]);
            String payloadJson = new String(decodedBytes, "UTF-8");
            
            System.out.println("JWT Payload: " + payloadJson);
            return JsonParser.parseString(payloadJson).getAsJsonObject();
            
        } catch (Exception e) {
            System.err.println("Error decoding ID token:");
            e.printStackTrace();
            return null;
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
