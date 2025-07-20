/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.OrderDetail;
/**
 *
 * @author PC
 */
public class OrderDetailDAO extends DBContext{


    // Thêm phương thức mới để tạo nhiều order detail cùng lúc
    public void createOrderDetails(Iterable<OrderDetail> orderDetails) throws SQLException {
        String sql = "INSERT INTO OrderDetails (OrderID, ProductID, Quantity, Price, ProductName, ImageUrl) "
                   + "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (Connection conn = connection;
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            for (OrderDetail detail : orderDetails) {
                stmt.setInt(1, detail.getOrderID());
                stmt.setInt(2, detail.getProductID());
                stmt.setInt(3, detail.getQuantity());
                stmt.setInt(4, detail.getPrice());
                stmt.setString(5, detail.getProductName());
                stmt.setString(6, detail.getImage());
                stmt.addBatch(); // Thêm vào batch
            }
            
            stmt.executeBatch(); // Thực thi tất cả cùng lúc
        }
    }
 public List<OrderDetail> getOrderDetailsByOrderId(int orderId) throws SQLException, Exception {
    List<OrderDetail> details = new ArrayList<>();
    String sql = "SELECT * FROM OrderDetails WHERE OrderID = ?";
    
    try (Connection conn = new DBContext().getConnection();
         PreparedStatement stmt = conn.prepareStatement(sql)) {
        
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
}
