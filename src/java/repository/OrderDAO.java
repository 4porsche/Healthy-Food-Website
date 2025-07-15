package repository;
import java.sql.*;
import java.util.*;
import model.Order;
import model.OrderDetail;

public class OrderDAO extends DBContext{
      public int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO Orders (UserID, CustomerName, CustomerEmail, CustomerPhone, "
                   + "DeliveryAddress, OrderDate, TotalPrice, DeliveryStatus) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = connection;
             PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setObject(1, order.getUserID()); // Cho phép null
            stmt.setString(2, order.getCustomerName());
            stmt.setString(3, order.getCustomerEmail());
            stmt.setString(4, order.getCustomerPhone());
            stmt.setString(5, order.getDeliveryAddress());
            stmt.setDate(6, order.getOrderDate());
            stmt.setInt(7, order.getTotalPrice());
            stmt.setString(8, order.getDeliveryStatus());
            
            stmt.executeUpdate();
            
            try (ResultSet generatedKeys = stmt.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                } else {
                    throw new SQLException("Creating order failed, no ID obtained.");
                }
            }
        }
      }

    public void updateOrderStatus(int orderId, String status) throws SQLException {
        String sql = "UPDATE Orders SET DeliveryStatus = ? WHERE OrderID = ?";
        
        try (Connection conn = connection;
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        }
    }
   public Order getOrderById(int orderId) throws SQLException {
        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (Connection conn = super.connection;
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setUserID(rs.getObject("UserID", Integer.class)); // Handle NULL
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setCustomerEmail(rs.getString("CustomerEmail"));
                    order.setCustomerPhone(rs.getString("CustomerPhone"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setOrderDate(rs.getDate("OrderDate"));
                    order.setTotalPrice(rs.getInt("TotalPrice"));
                    order.setDeliveryStatus(rs.getString("DeliveryStatus"));
                    return order;
                }
            }
        }
        return null;
    }
}