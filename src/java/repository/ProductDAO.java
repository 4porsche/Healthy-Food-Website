package repository;

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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
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
    public Map<String, Integer> getMyProductCountByCategory(int sellerId) {
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

    public List<Product> getSearchedList(String txt) {
        String sql = "SELECT * FROM Products WHERE [ProductName] LIKE ? OR [Ingredient] LIKE ? OR [Tags] LIKE ?";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, "%" + txt + "%");
            ps.setString(2, "%" + txt + "%");
            ps.setString(3, "%" + txt + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return list;
    }
    
    public List<Product> getMySearchedList(String txt, int sellerId) {
        String sql = "SELECT * FROM Products WHERE SellerID = ? AND ([ProductName] LIKE ? OR [Ingredient] LIKE ? OR [Tags] LIKE ?)";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setString(2, "%" + txt + "%");
            ps.setString(3, "%" + txt + "%");
            ps.setString(4, "%" + txt + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int categoryId = rs.getInt("CategoryID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return list;
    }

    public List<Product> sortNewestList() {
        String sql = "SELECT * FROM Products ORDER BY ProductID DESC";
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> sortMyProductNewestList(int sellerId) {
        String sql = "SELECT * FROM Products WHERE SellerID = ? ORDER BY ProductID DESC";
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> sortPopularList() {
        String sql = "SELECT \n"
                + "    P.*,\n"
                + "    ISNULL(SUM(OD.Quantity), 0) AS TotalSold\n"
                + "FROM \n"
                + "    Products P\n"
                + "LEFT JOIN \n"
                + "    OrderDetails OD ON P.ProductID = OD.ProductID\n"
                + "GROUP BY \n"
                + "    P.ProductID, P.SellerID, P.CategoryID, P.ProductName, P.Price,\n"
                + "    P.Description, P.Weight, P.Calories, P.Protein, P.Fat, P.Carbs, P.Tags\n"
                + "ORDER BY \n"
                + "    TotalSold DESC";
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> sortMyProductPopularList(int sellerId) {
        String sql = "SELECT \n"
                + "    P.*,\n"
                + "    ISNULL(SUM(OD.Quantity), 0) AS TotalSold\n"
                + "FROM \n"
                + "    Products P\n"
                + "LEFT JOIN \n"
                + "    OrderDetails OD ON P.ProductID = OD.ProductID\n"
                + "WHERE P.SellerID = ?"
                + "GROUP BY \n"
                + "    P.ProductID, P.SellerID, P.CategoryID, P.ProductName, P.Price,\n"
                + "    P.Description, P.Weight, P.Calories, P.Protein, P.Fat, P.Carbs, P.Tags\n"
                + "ORDER BY \n"
                + "    TotalSold DESC";
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
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public Product getProductById(int id) {
        String sql = "SELECT * FROM Products WHERE ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return new Product(rs.getInt("ProductID"),
                        rs.getInt("SellerID"),
                        rs.getInt("CategoryID"),
                        rs.getString("ProductName"),
                        rs.getInt("Price"),
                        rs.getString("Description"),
                        rs.getString("Ingredient"),
                        rs.getDouble("Weight"),
                        rs.getDouble("Calories"),
                        rs.getDouble("Protein"),
                        rs.getDouble("Fat"),
                        rs.getDouble("Carbs"),
                        rs.getString("Tags"),
                        rs.getString("ImageUrl"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return null;
    }

    public List<Product> getSimilarProducts(int categoryId, int excludeProductId) {
        String sql = "SELECT TOP 5 \n"
                + "    P.*,\n"
                + "    ISNULL(SUM(OD.Quantity), 0) AS TotalSold\n"
                + "FROM \n"
                + "    Products P\n"
                + "LEFT JOIN \n"
                + "    OrderDetails OD ON P.ProductID = OD.ProductID\n"
                + "WHERE \n"
                + "    P.CategoryID = ? AND P.ProductID <> ?\n"
                + "GROUP BY \n"
                + "    P.ProductID, P.SellerID, P.CategoryID, P.ProductName, P.Price, P.Description,\n"
                + "    P.Ingredient, P.Weight, P.Calories, P.Protein, P.Fat, P.Carbs, P.Tags, P.ImageUrl\n"
                + "ORDER BY \n"
                + "    TotalSold DESC;";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ps.setInt(2, excludeProductId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println("🔴 SQL Error: " + e.getMessage());
        }
        return list;
    }

    public List<Product> getProductByCategory(int categoryId) {
        String sql = "SELECT * FROM Products WHERE CategoryID = ?";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                int sellerId = rs.getInt("SellerID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }

    public List<Product> getMyProductByCategory(int sellerId, int categoryId) {
        String sql = "SELECT * FROM Products WHERE SellerID = ? AND CategoryID = ?";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setInt(2, categoryId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                int productId = rs.getInt("ProductID");
                String productName = rs.getString("ProductName");
                int price = rs.getInt("Price");
                String description = rs.getString("Description");
                String ingredient = rs.getString("Ingredient");
                double weight = rs.getDouble("Weight");
                double calories = rs.getDouble("Calories");
                double protein = rs.getDouble("Protein");
                double fat = rs.getDouble("Fat");
                double carbs = rs.getDouble("Carbs");
                String tags = rs.getString("Tags");
                String imageUrl = rs.getString("ImageUrl");

                Product p = new Product(productId, sellerId, categoryId, productName, price, description, ingredient, weight, calories, protein, fat, carbs, tags, imageUrl);
                list.add(p);
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
    public List<String> getCategoryNameList() {
        String sql = "SELECT CategoryName FROM Categories";
        List<String> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString(1));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return list;
    }
    
}
