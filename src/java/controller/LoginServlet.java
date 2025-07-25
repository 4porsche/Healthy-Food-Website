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

        UserDAO dao = new UserDAO();
        User user = dao.login(username, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("user", user); // Lưu cả đối tượng User
            session.setAttribute("userid", user.getUserID()); // Lưu userid vào session
            session.setAttribute("username", user.getUsername()); // Hoặc user.getFullName() nếu có
            session.setAttribute("fullname", user.getFullname());
            int roleID = user.getRoleID();
            switch (roleID) {
                case 1:
                    response.sendRedirect("AdminServlet");
                    break;
                case 3:
                    response.sendRedirect("home");
                    break;
                case 4:
                    response.sendRedirect("requests");
                    break;
                case 5:
                    response.sendRedirect("seller-dashboard");
                    break;
                case 6:
                    response.sendRedirect("shipper-dashboard");
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
