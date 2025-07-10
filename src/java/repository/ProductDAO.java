package repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

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
        String sql = """
                     SELECT TOP 5 *
                     FROM Products
                     ORDER BY Protein DESC, Fat ASC;""";
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

    public Map<Integer, String> getCategoryMap() {
        Map<Integer, String> result = new HashMap<>();
        String sql = "SELECT * FROM Categories";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getInt("CategoryID"),
                        rs.getString("CategoryName"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }

    // category + đếm total product ở mỗi category
    public Map<Integer, Integer> getProductCountByCategory() {
        Map<Integer, Integer> result = new HashMap<>();
        String sql = "SELECT CategoryID, COUNT(*) AS Total FROM Products GROUP BY CategoryID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getInt("CategoryID"),
                        rs.getInt("Total"));
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return result;
    }

    // category + đếm total product ở mỗi category của mỗi seller
    public Map<Integer, Integer> getMyProductCountByCategory(int sellerId) {
        Map<Integer, Integer> result = new HashMap<>();
        String sql = "SELECT CategoryID, COUNT(*) AS Total FROM Products WHERE SellerID = ? GROUP BY CategoryID";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                result.put(rs.getInt("CategoryID"),
                        rs.getInt("Total"));
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
                + "    P.ProductID, P.SellerID, P.CategoryID, P.ProductName, P.Price, P.Description,\n"
                + "    P.Ingredient, P.Weight, P.Calories, P.Protein, P.Fat, P.Carbs, P.Tags, P.ImageUrl\n"
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
                + "WHERE P.SellerID = ? "
                + "GROUP BY \n"
                + "    P.ProductID, P.SellerID, P.CategoryID, P.ProductName, P.Price, P.Description,\n"
                + "    P.Ingredient, P.Weight, P.Calories, P.Protein, P.Fat, P.Carbs, P.Tags, P.ImageUrl\n"
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

    public boolean checkProductNameExist(String name) {
        String sql = "SELECT * FROM Products WHERE [ProductName] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, name);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return true;
            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return false;
    }

    public void addProduct(int sellerId, int categoryId, String name, int price, String description, String ingredient, double weight, double calories, double protein, double fat, double carbs, String tags, String imageUrl) {
        String sql = "INSERT INTO [Products] ([SellerID], [CategoryID], [ProductName], [Price], [Description], [Ingredient], [Weight], [Calories], [Protein], [Fat], [Carbs], [Tags], [ImageUrl])\n"
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setInt(2, categoryId);
            ps.setString(3, name);
            ps.setInt(4, price);
            ps.setString(5, description);
            ps.setString(6, ingredient);
            ps.setDouble(7, weight);
            ps.setDouble(8, calories);
            ps.setDouble(9, protein);
            ps.setDouble(10, fat);
            ps.setDouble(11, carbs);
            ps.setString(12, tags);
            ps.setString(13, imageUrl);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateProduct(int productId, int sellerId, int categoryId, String name, int price, String description, String ingredient, double weight, double calories, double protein, double fat, double carbs, String tags, String imageUrl) {
        String sql = "UPDATE [Products] SET "
                + "[SellerID] = ?, "
                + "[CategoryID] = ?, "
                + "[ProductName] = ?, "
                + "[Price] = ?, "
                + "[Description] = ?, "
                + "[Ingredient] = ?, "
                + "[Weight] = ?, "
                + "[Calories] = ?, "
                + "[Protein] = ?, "
                + "[Fat] = ?, "
                + "[Carbs] = ?, "
                + "[Tags] = ?, "
                + "[ImageUrl] = ? "
                + "WHERE [ProductID] = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setInt(2, categoryId);
            ps.setString(3, name);
            ps.setInt(4, price);
            ps.setString(5, description);
            ps.setString(6, ingredient);
            ps.setDouble(7, weight);
            ps.setDouble(8, calories);
            ps.setDouble(9, protein);
            ps.setDouble(10, fat);
            ps.setDouble(11, carbs);
            ps.setString(12, tags);
            ps.setString(13, imageUrl);
            ps.setInt(14, productId);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void deleteProduct(int id) {
        String sql = "DELETE FROM [Products] WHERE ProductID = ?";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.executeUpdate();
        } catch (SQLException e) {
            System.out.println(e);
        }
    }

    public List<Product> getMyProductByTag(int sellerId, String tag) {
        String sql = "SELECT * FROM Products WHERE SellerID = ? AND Tags LIKE ?";
        List<Product> list = new ArrayList<>();

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, sellerId);
            ps.setString(2, "%" + tag + "%");
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

    public Set<String> getAllTagsBySeller(int sellerId) {
        List<Product> allProducts = getMyProduct(sellerId); // Phải gọi đúng method lấy ALL product, KHÔNG bị filter
        Set<String> allTags = new LinkedHashSet<>();

        for (Product product : allProducts) {
            if (product.getTags() != null && !product.getTags().trim().isEmpty()) {
                String[] tags = product.getTags().split(",");
                for (String tag : tags) {
                    allTags.add(tag.trim());
                }
            }
        }
        return allTags;
    }

}
