package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import repository.CartDAO;
import model.cart;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "UpdateCart", urlPatterns = {"/jsp/updatecart"})
public class UpdateCart extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        HttpSession session = request.getSession();
        Integer userID = (Integer) session.getAttribute("userID");
        
        // For testing, use userID 3 if not logged in
        if (userID == null) {
            userID = 3; // Set to Customer One for testing
        }
        
        CartDAO cartDAO = new CartDAO();
        String action = request.getParameter("action");
        String message = null;
        
        if (action != null) {
            try {
                // Get current cart items to find the current quantity
                List<cart> cartItems = cartDAO.getCartByUserID(userID);
                
                if (action.startsWith("increase_")) {
                    int cartID = Integer.parseInt(action.substring(9));
                    // Find the item and get its current quantity
                    for (cart item : cartItems) {
                        if (item.getCartID() == cartID) {
                            int newQuantity = item.getQuantity() + 1;
                            if (cartDAO.updateCartQuantity(cartID, newQuantity)) {
                                message = "Quantity updated successfully";
                            } else {
                                message = "Failed to update quantity";
                            }
                            break;
                        }
                    }
                }
                else if (action.startsWith("decrease_")) {
                    int cartID = Integer.parseInt(action.substring(9));
                    // Find the item and get its current quantity
                    for (cart item : cartItems) {
                        if (item.getCartID() == cartID) {
                            int currentQuantity = item.getQuantity();
                            if (currentQuantity > 1) {
                                int newQuantity = currentQuantity - 1;
                                if (cartDAO.updateCartQuantity(cartID, newQuantity)) {
                                    message = "Quantity updated successfully";
                                } else {
                                    message = "Failed to update quantity";
                                }
                            } else {
                                message = "Quantity cannot be less than 1, remove the item instead!";
                            }
                            break;
                        }
                    }
                }
                else if (action.startsWith("remove_")) {
                    int cartID = Integer.parseInt(action.substring(7));
                    if (cartDAO.removeCartItem(cartID)) {
                        message = "Item removed from cart";
                    } else {
                        message = "Failed to remove item";
                    }
                }
            } catch (NumberFormatException e) {
                message = "Invalid cart item ID";
                System.err.println("Invalid cart ID format: " + e.getMessage());
            }
        }
        
        // Store message in session
        if (message != null) {
            session.setAttribute("cartMessage", message);
        }
        
        // Redirect back to cart page
        response.sendRedirect("cart.jsp");
    }
} 