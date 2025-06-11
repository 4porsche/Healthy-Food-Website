package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Product;

public class ProductDAO extends DBContext {
    
    public List<Product> getAllProducts() {
        List<Product> products = new ArrayList<>();
        String sql = "SELECT * FROM Products";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setProductID(rs.getInt("ProductID"));
                product.setSellerID(rs.getInt("SellerID"));
                product.setCategoryID(rs.getInt("CategoryID"));
                product.setProductName(rs.getString("ProductName"));
                product.setPrice(rs.getInt("Price"));
                product.setDescription(rs.getString("Description"));
                product.setWeight(rs.getDouble("Weight"));
                product.setCalories(rs.getDouble("Calories"));
                product.setProtein(rs.getDouble("Protein"));
                product.setFat(rs.getDouble("Fat"));
                product.setCarbs(rs.getDouble("Carbs"));
                product.setTags(rs.getString("Tags"));
                products.add(product);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return products;
    }

    public void addProduct(Product product) {
        String sql = "INSERT INTO Products (SellerID, CategoryID, ProductName, Price, Description, Weight, Calories, Protein, Fat, Carbs, Tags) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, product.getSellerID());
            ps.setInt(2, product.getCategoryID());
            ps.setString(3, product.getProductName());
            ps.setInt(4, product.getPrice());
            ps.setString(5, product.getDescription());
            ps.setDouble(6, product.getWeight());
            ps.setDouble(7, product.getCalories());
            ps.setDouble(8, product.getProtein());
            ps.setDouble(9, product.getFat());
            ps.setDouble(10, product.getCarbs());
            ps.setString(11, product.getTags());
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int productId) {
        String sql = "DELETE FROM Products WHERE ProductID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, productId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}