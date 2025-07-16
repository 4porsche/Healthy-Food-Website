package repository;

import model.Cart;
import model.CartItem;
import java.sql.*;
import repository.DBContext;

public class CartDAO extends DBContext {
    
    public void saveCart(int userID, Cart cart) throws SQLException {
        String sql = "MERGE INTO Cart AS target "
                   + "USING (VALUES (?, ?, ?)) AS source (UserID, ProductID, Quantity) "
                   + "ON target.UserID = source.UserID AND target.ProductID = source.ProductID "
                   + "WHEN MATCHED THEN UPDATE SET Quantity = source.Quantity "
                   + "WHEN NOT MATCHED THEN INSERT (UserID, ProductID, Quantity) "
                   + "VALUES (source.UserID, source.ProductID, source.Quantity);";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            for (CartItem item : cart.getItems()) {
                stmt.setInt(1, userID);
                stmt.setInt(2, item.getProductID());
                stmt.setInt(3, item.getQuantity());
                stmt.addBatch();
            }
            stmt.executeBatch();
        }
    }
    
    public Cart getCartByUser(int userID) throws SQLException {
        Cart cart = new Cart();
        String sql = "SELECT p.ProductID, p.ProductName, p.Price, p.ImageUrl, c.Quantity "
                   + "FROM Cart c JOIN Products p ON c.ProductID = p.ProductID "
                   + "WHERE c.UserID = ?";
        
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, userID);
            ResultSet rs = stmt.executeQuery();
            
            while (rs.next()) {
                CartItem item = new CartItem();
                item.setProductID(rs.getInt("ProductID"));
                item.setProductName(rs.getString("ProductName"));
                item.setPrice(rs.getDouble("Price"));
                item.setImageUrl(rs.getString("ImageUrl"));
                item.setQuantity(rs.getInt("Quantity"));
                cart.addItem(item);
            }
        }
        return cart;
    }
    public CartItem getProductInfo(int productID) throws SQLException {
        String sql = "SELECT ProductName, Price, ImageUrl FROM Products WHERE ProductID = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, productID);
            ResultSet rs = stmt.executeQuery();
            
            if (rs.next()) {
                CartItem item = new CartItem();
                item.setProductID(productID);
                item.setProductName(rs.getString("ProductName"));
                item.setPrice(rs.getDouble("Price"));
                item.setImageUrl(rs.getString("ImageUrl"));
                return item;
            }
        }
        return null;
    }
}