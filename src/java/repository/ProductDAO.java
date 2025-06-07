package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import model.Categories;
import model.Product;

public class ProductDAO extends DBContext {

    public List<Product> getAllProduct() {
        String sql = "select * from Products";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, weight, calories, protein, fat, carbs, tags);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getFeatureProduct() {
        String sql = "SELECT TOP 5 *\n"
                + "FROM Products\n"
                + "ORDER BY Protein DESC, Fat ASC;";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, weight, calories, protein, fat, carbs, tags);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getRecentProduct() {
        String sql = "SELECT TOP 5 *\n"
                + "FROM Products\n"
                + "ORDER BY ProductID DESC;";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, weight, calories, protein, fat, carbs, tags);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Categories> getCategoriesList() {
        String sql = "select * from Categories";
        List<Categories> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int categoryId = rs.getInt("CategoryID");
                String categoryName = rs.getString("CategoryName");

                Categories c = new Categories(categoryId, categoryName);
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getMyProduct(int sellerId) {
        String sql = "select * from Products where SellerID = ?";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, weight, calories, protein, fat, carbs, tags);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    // category + đếm total product ở mỗi category
    public Map<String, Integer> getProductCountByCategory() {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT c.CategoryName, COUNT(p.ProductID) AS totalProducts FROM Categories c LEFT JOIN Products p ON c.categoryId = p.categoryId GROUP BY c.categoryName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String categoryName = rs.getString("CategoryName");
                int count = rs.getInt("totalProducts");
                result.put(categoryName, count);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }

    // category + đếm total product ở mỗi category của mỗi seller
    public Map<String, Integer> getProductCountByCategoryBySeller(int sellerId) {
        Map<String, Integer> result = new HashMap<>();
        String sql = "SELECT c.CategoryName, COUNT(p.ProductID) AS totalProducts FROM Categories c LEFT JOIN Products p ON c.categoryId = p.categoryId WHERE SellerId = ? GROUP BY c.categoryName";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String categoryName = rs.getString("CategoryName");
                int count = rs.getInt("totalProducts");
                result.put(categoryName, count);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }
}
