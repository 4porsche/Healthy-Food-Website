package controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;
import repository.UserDAO;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String returnUrl = request.getParameter("returnUrl");

        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userid", user.getUserID());
            session.setAttribute("username", user.getUsername());
            session.setAttribute("fullname", user.getFullname());

            // Chuyển hướng đến URL trước đó nếu có
            if (returnUrl != null && !returnUrl.isEmpty()) {
                response.sendRedirect(returnUrl);
                return;
            }

            // Chuyển hướng theo role nếu không có returnUrl
            int roleID = user.getRoleID();
            switch (roleID) {
                case 1:
                    response.sendRedirect("admin.jsp");
                    break;
                case 4:
                    response.sendRedirect("requests");
                    break;
                case 3:
                    response.sendRedirect("home");
                    break;
                case 5:
                    response.sendRedirect("seller.jsp");
                    break;
                case 6:
                    response.sendRedirect("shipper.jsp");
                    break;
                case 7: // Manager
                    response.sendRedirect("managerHome.jsp");
                    break;
                default:
                    response.sendRedirect("login.jsp?error=role");
                    break;
            }
        } else {
            request.getRequestDispatcher("login.jsp?error=invalid").forward(request, response);
        }
    }
}