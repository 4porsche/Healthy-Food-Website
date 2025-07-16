package repository;

import model.MenuSuggestion;
import java.sql.*;
import java.util.*;
import model.MenuSuggestion;
import model.Order;
import model.OrderDetail;
import model.RevenueReport;
import model.RevenueReport;
import java.sql.Date;
import model.Shipping;
import repository.DBContext;

public class ManagerDAO extends DBContext {
    
    // Quản lý Menu Suggestions
    public List<MenuSuggestion> getAllMenuSuggestions() throws SQLException {
        List<MenuSuggestion> list = new ArrayList<>();
        String sql = "SELECT * FROM MenuSuggestions WHERE Status = 'Pending'";
        
        try (Statement stmt = connection.createStatement(); 
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                MenuSuggestion ms = new MenuSuggestion();
                ms.setSuggestionId(rs.getInt("SuggestionID"));
                ms.setTitle(rs.getString("Title"));
                ms.setDescription(rs.getString("Description"));
                ms.setCreatedDate(rs.getDate("CreatedDate"));
                ms.setStatus(rs.getString("Status"));
                list.add(ms);
            }
        }
        return list;
    }

    public MenuSuggestion getMenuSuggestionById(int id) throws SQLException {
        String sql = "SELECT * FROM MenuSuggestions WHERE SuggestionID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, id);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    MenuSuggestion ms = new MenuSuggestion();
                    ms.setSuggestionId(rs.getInt("SuggestionID"));
                    ms.setTitle(rs.getString("Title"));
                    ms.setDescription(rs.getString("Description"));
                    ms.setNutritionistId(rs.getInt("NutritionistID"));
                    ms.setCreatedDate(rs.getDate("CreatedDate"));
                    ms.setStatus(rs.getString("Status"));
                    return ms;
                }
            }
        }
        return null;
    }

    public boolean updateSuggestionStatus(int id, String status) throws SQLException {
        String sql = "UPDATE MenuSuggestions SET Status = ? WHERE SuggestionID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, status);
            stmt.setInt(2, id);
            int affectedRows = stmt.executeUpdate();
            return affectedRows > 0;
        }
    }
    
    // Quản lý đơn hàng
    public List<Order> getAllOrders() throws SQLException {
    List<Order> orders = new ArrayList<>();
    String sql = "SELECT * FROM Orders";
    
    try (Statement stmt = connection.createStatement(); 
         ResultSet rs = stmt.executeQuery(sql)) {
        
        while (rs.next()) {
            Order order = new Order();
            order.setOrderID(rs.getInt("OrderID"));
            
            // Xử lý userID có thể null
            int userId = rs.getInt("UserID");
            if (rs.wasNull()) {
                order.setUserID(null);
            } else {
                order.setUserID(userId);
            }
            
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
    return orders;

    }
    
    // Báo cáo doanh thu
    public List<RevenueReport> getRevenueByDateRange(Date startDate, Date endDate) throws SQLException {
        List<RevenueReport> reports = new ArrayList<>();
        String sql = "SELECT OrderDate, SUM(TotalPrice) AS DailyRevenue "
                   + "FROM Orders "
                   + "WHERE OrderDate BETWEEN ? AND ? "
                   + "GROUP BY OrderDate "
                   + "ORDER BY OrderDate";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setDate(1, startDate);
            stmt.setDate(2, endDate);
            
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    RevenueReport report = new RevenueReport();
                    report.setDate(rs.getDate("OrderDate"));
                    report.setRevenue(rs.getDouble("DailyRevenue"));
                    reports.add(report);
                }
            }
        }
        return reports;
    }
    public Order getOrderById(int orderId) throws SQLException {
    String sql = "SELECT * FROM Orders WHERE OrderID = ?";
    Order order = null;
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                order = new Order();
                order.setOrderID(rs.getInt("OrderID"));
                
                // Xử lý userID có thể null
                int userId = rs.getInt("UserID");
                if (rs.wasNull()) {
                    order.setUserID(null);
                } else {
                    order.setUserID(userId);
                }
                
                order.setCustomerName(rs.getString("CustomerName"));
                order.setCustomerEmail(rs.getString("CustomerEmail"));
                order.setCustomerPhone(rs.getString("CustomerPhone"));
                order.setDeliveryAddress(rs.getString("DeliveryAddress"));
                order.setOrderDate(rs.getDate("OrderDate"));
                order.setTotalPrice(rs.getInt("TotalPrice"));
                order.setDeliveryStatus(rs.getString("DeliveryStatus"));
            }
        }
    }
    return order;
}

public List<OrderDetail> getOrderDetails(int orderId) throws SQLException {
    List<OrderDetail> details = new ArrayList<>();
    String sql = "SELECT od.*, p.ProductName, p.ImageUrl "
               + "FROM OrderDetails od "
               + "JOIN Products p ON od.ProductID = p.ProductID "
               + "WHERE od.OrderID = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        try (ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                OrderDetail detail = new OrderDetail();
                detail.setOrderID(rs.getInt("OrderID"));
                detail.setProductID(rs.getInt("ProductID"));
                detail.setQuantity(rs.getInt("Quantity"));
                detail.setPrice(rs.getInt("Price"));
                detail.setProductName(rs.getString("ProductName"));
                detail.setImage(rs.getString("ImageUrl"));
                details.add(detail);
            }
        }
    }
    return details;
}
public Shipping getShippingByOrderId(int orderId) throws SQLException {
    String sql = "SELECT s.*, u.Fullname FROM Shipping s "
               + "JOIN Users u ON s.ShipperID = u.UserID "
               + "WHERE s.OrderID = ?";
    
    try (PreparedStatement stmt = connection.prepareStatement(sql)) {
        stmt.setInt(1, orderId);
        try (ResultSet rs = stmt.executeQuery()) {
            if (rs.next()) {
                Shipping shipping = new Shipping();
                shipping.setShippingID(rs.getInt("ShippingID"));
                shipping.setOrderID(rs.getInt("OrderID"));
                shipping.setShipperID(rs.getInt("ShipperID"));
                shipping.setStatus(rs.getString("Status"));
                shipping.setShipperName(rs.getString("Fullname"));
                return shipping;
            }
        }
    }
    return null;
}
}