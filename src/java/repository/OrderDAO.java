package repository;

import java.sql.*;
import java.util.*;
import model.Order;
import model.OrderDetail;

public class OrderDAO extends DBContext {

    public int createOrder(Order order) throws SQLException {
        String sql = "INSERT INTO Orders (UserID, CustomerName, CustomerEmail, CustomerPhone, "
                + "DeliveryAddress, OrderDate, TotalPrice, DeliveryStatus) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = connection; PreparedStatement stmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

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

        try (Connection conn = connection; PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, status);
            stmt.setInt(2, orderId);
            stmt.executeUpdate();
        }
    }

    public Order getOrderById(int orderId) throws SQLException {
        System.out.println("[DEBUG] Getting order by ID: " + orderId);

        String sql = "SELECT * FROM Orders WHERE OrderID = ?";
        try (Connection conn = super.connection; PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, orderId);
            System.out.println("[SQL] " + ps.toString());

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    Integer userId = rs.getObject("UserID", Integer.class);
                    order.setUserID(userId);
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setCustomerEmail(rs.getString("CustomerEmail"));
                    order.setCustomerPhone(rs.getString("CustomerPhone"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setOrderDate(rs.getDate("OrderDate"));
                    order.setTotalPrice(rs.getInt("TotalPrice"));
                    order.setDeliveryStatus(rs.getString("DeliveryStatus"));

                    System.out.println("[DEBUG] Order found: " + order);
                    return order;
                }
            }
        }

        System.out.println("[DEBUG] No order found for ID: " + orderId);
        return null;
    }
    public List<Order> getOrdersByUserId(int userId) {
        List<Order> orders = new ArrayList<>();
        String sql = "SELECT * FROM Orders WHERE UserID = ? ORDER BY OrderDate DESC";
        
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setInt(1, userId);
            try (ResultSet rs = st.executeQuery()) {
                while (rs.next()) {
                    Order order = new Order();
                    order.setOrderID(rs.getInt("OrderID"));
                    order.setUserID(rs.getInt("UserID"));
                    order.setCustomerName(rs.getString("CustomerName"));
                    order.setCustomerEmail(rs.getString("CustomerEmail"));
                    order.setCustomerPhone(rs.getString("CustomerPhone"));
                    order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                    order.setOrderDate(rs.getDate("OrderDate"));
                    order.setTotalPrice(rs.getInt("TotalPrice"));
                    order.setDeliveryStatus(rs.getString("DeliveryStatus"));
                    
                    orders.add(order);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return orders;
    }
}
