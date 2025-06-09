/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

/**
 *
 * @author Home
 */
import java.sql.Connection;
import java.util.Vector;
import model.Product;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Home
 */
public class ProductDAO extends DBContext {
    Connection conn = null;
    PreparedStatement ps = null;
    ResultSet rs = null;

    public Vector<Product> getAllProduct(String sql) {
        Vector<Product> listProduct = new Vector<>();
        try {
            ps = conn.prepareStatement(sql);
            rs = ps.executeQuery();
            while (rs.next()) {
                Product p = new Product(
                        rs.getInt(1),  
                        rs.getInt(2),  
                        rs.getInt(3),  
                        rs.getString(4),  
                        rs.getInt(5),  
                        rs.getString(6), 
                        rs.getDouble(7),  
                        rs.getDouble(8), 
                        rs.getDouble(9),  
                        rs.getDouble(10), 
                        rs.getDouble(11), 
                        rs.getString(12), 
                        rs.getString(13) 
                );
                listProduct.add(p);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return listProduct;
    }
    
    public Product getProductByID(String productID) {
        String query = "select* from Products\n"
                + "where ProductID = ?";
        try {
            conn = new DBContext().connection;
            ps = conn.prepareStatement(query);
            ps.setString(1, productID);
            rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(
                        rs.getInt(1),  
                        rs.getInt(2),  
                        rs.getInt(3),  
                        rs.getString(4),  
                        rs.getInt(5),  
                        rs.getString(6), 
                        rs.getDouble(7),  
                        rs.getDouble(8), 
                        rs.getDouble(9),  
                        rs.getDouble(10), 
                        rs.getDouble(11), 
                        rs.getString(12), 
                        rs.getString(13));
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public void insertProduct(Product p) {
        String sql = "INSERT INTO [dbo].[Products] " +
                     "([SellerID], [CategoryID], [ProductName], [Price], [Description], " +
                     "[Weight], [Calories], [Protein], [Fat], [Carbs], [Tags], [Image]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getSellerID());
            ps.setInt(2, p.getCategoryID());
            ps.setString(3, p.getProductName());
            ps.setInt(4, p.getPrice());
            ps.setString(5, p.getDescription());
            ps.setDouble(6, p.getWeight());
            ps.setDouble(7, p.getCalories());
            ps.setDouble(8, p.getProtein());
            ps.setDouble(9, p.getFat());
            ps.setDouble(10, p.getCarbs());
            ps.setString(11, p.getTags());
            ps.setString(12, p.getImage());
            ps.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Vector<Product> searchProducts(String searchQuery) {
    Vector<Product> listProduct = new Vector<>();
    String sql = "SELECT * FROM Products WHERE ProductName LIKE ? OR Tags LIKE ?";
    try {
        ps = conn.prepareStatement(sql);
        ps.setString(1, "%" + searchQuery + "%");
        ps.setString(2, "%" + searchQuery + "%");
        rs = ps.executeQuery();
        while (rs.next()) {
            Product p = new Product(
                    rs.getInt(1), 
                    rs.getInt(2),  
                    rs.getInt(3),  
                    rs.getString(4),  
                    rs.getInt(5),  
                    rs.getString(6),  
                    rs.getDouble(7), 
                    rs.getDouble(8),  
                    rs.getDouble(9),  
                    rs.getDouble(10), 
                    rs.getDouble(11), 
                    rs.getString(12),
                    rs.getString(13)  
            );
            listProduct.add(p);
        }
    } catch (SQLException ex) {
        ex.printStackTrace();
    }
    return listProduct;
}

    public void updateProduct(Product p, int productID) {
        String sql = "UPDATE [dbo].[Products] " +
                     "SET [SellerID] = ?, [CategoryID] = ?, [ProductName] = ?, [Price] = ?, " +
                     "[Description] = ?, [Weight] = ?, [Calories] = ?, [Protein] = ?, " +
                     "[Fat] = ?, [Carbs] = ?, [Tags] = ?, [Image] = ? " +
                     "WHERE ProductID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, p.getSellerID());
            ps.setInt(2, p.getCategoryID());
            ps.setString(3, p.getProductName());
            ps.setInt(4, p.getPrice());
            ps.setString(5, p.getDescription());
            ps.setDouble(6, p.getWeight());
            ps.setDouble(7, p.getCalories());
            ps.setDouble(8, p.getProtein());
            ps.setDouble(9, p.getFat());
            ps.setDouble(10, p.getCarbs());
            ps.setString(11, p.getTags());
            ps.setString(12, p.getImage());
            ps.setInt(13, p.getProductID());
            int updatedRows = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void deleteProduct(int productID) {
        String sql = "DELETE FROM [dbo].[Products] WHERE ProductID = ?";
        try {
            ps = conn.prepareStatement(sql);
            ps.setInt(1, productID);
            int deletedRows = ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
