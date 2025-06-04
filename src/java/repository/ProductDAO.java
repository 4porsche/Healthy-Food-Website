/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import model.Product;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Admin
 */
public class ProductDAO extends DBContext {

    public List<Product> getAllProduct() {
        String sql = "select * from Products";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
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
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
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
            PreparedStatement stm = connection.prepareStatement(sql);
            ResultSet rs = stm.executeQuery();
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
}
