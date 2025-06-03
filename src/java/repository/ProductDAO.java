/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

/**
 *
 * @author Home
 */
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

    public Vector<Product> getAllProduct(String sql) {
        Vector<Product> listProduct = new Vector<>();
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ResultSet rs = ptm.executeQuery();
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

    public void insertProduct(Product p) {
        String sql = "INSERT INTO [dbo].[Products] " +
                     "([SellerID], [CategoryID], [ProductName], [Price], [Description], " +
                     "[Weight], [Calories], [Protein], [Fat], [Carbs], [Tags], [Image]) " +
                     "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, p.getSellerID());
            ptm.setInt(2, p.getCategoryID());
            ptm.setString(3, p.getProductName());
            ptm.setInt(4, p.getPrice());
            ptm.setString(5, p.getDescription());
            ptm.setDouble(6, p.getWeight());
            ptm.setDouble(7, p.getCalories());
            ptm.setDouble(8, p.getProtein());
            ptm.setDouble(9, p.getFat());
            ptm.setDouble(10, p.getCarbs());
            ptm.setString(11, p.getTags());
            ptm.setString(12, p.getImage());
            ptm.executeUpdate();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    public Vector<Product> searchProducts(String searchQuery) {
    Vector<Product> listProduct = new Vector<>();
    String sql = "SELECT * FROM Products WHERE ProductName LIKE ? OR Tags LIKE ?";
    try {
        PreparedStatement ptm = connection.prepareStatement(sql);
        ptm.setString(1, "%" + searchQuery + "%");
        ptm.setString(2, "%" + searchQuery + "%");
        ResultSet rs = ptm.executeQuery();
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
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, p.getSellerID());
            ptm.setInt(2, p.getCategoryID());
            ptm.setString(3, p.getProductName());
            ptm.setInt(4, p.getPrice());
            ptm.setString(5, p.getDescription());
            ptm.setDouble(6, p.getWeight());
            ptm.setDouble(7, p.getCalories());
            ptm.setDouble(8, p.getProtein());
            ptm.setDouble(9, p.getFat());
            ptm.setDouble(10, p.getCarbs());
            ptm.setString(11, p.getTags());
            ptm.setString(12, p.getImage());
            ptm.setInt(13, p.getProductID());
            int updatedRows = ptm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }

    public void deleteProduct(int productID) {
        String sql = "DELETE FROM [dbo].[Products] WHERE ProductID = ?";
        try {
            PreparedStatement ptm = connection.prepareStatement(sql);
            ptm.setInt(1, productID);
            int deletedRows = ptm.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
    }
}
