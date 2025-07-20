package repository;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.User;

public class AdminDAO extends DBContext {

     public List<User> getAllUsers() {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users";
        try (PreparedStatement ps = connection.prepareStatement(sql); 
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                User user = new User(
                        rs.getInt("UserID"),
                        rs.getString("Fullname"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("Phone"), // Thêm trường Phone
                        rs.getInt("RoleID"),
                        rs.getBoolean("IsActive"),
                        rs.getString("google_id")
                );
                users.add(user);
                System.out.println("Retrieved user: " + user.getUsername());
            }
            System.out.println("Total users retrieved: " + users.size());
        } catch (SQLException e) {
            System.out.println("SQL Error in getAllUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

    public boolean toggleActive(String email) {
        String sql = "UPDATE Users SET IsActive = CASE WHEN IsActive = 1 THEN 0 ELSE 1 END WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, email);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in toggleActive: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean assignRole(String email, int roleId) {
        String sql = "UPDATE Users SET RoleID = ? WHERE Email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ps.setString(2, email);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in assignRole: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean createUser(User user) {
        String sql = "INSERT INTO Users (Fullname, Username, Password, Email, Phone, RoleID, IsActive, google_id) "
                + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)"; // Thêm trường Phone
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone()); // Thiết lập giá trị phone
            ps.setInt(6, user.getRoleID());
            ps.setBoolean(7, user.isIsActive());
            ps.setString(8, user.getGoogleId());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in createUser: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

     public boolean updateUser(User user) {
        String sql = "UPDATE Users SET Fullname = ?, Username = ?, Password = ?, "
                + "Email = ?, Phone = ?, RoleID = ?, IsActive = ? WHERE UserID = ?"; // Thêm trường Phone
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setString(5, user.getPhone()); // Thiết lập giá trị phone
            ps.setInt(6, user.getRoleID());
            ps.setBoolean(7, user.isIsActive());
            ps.setInt(8, user.getUserID());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in updateUser: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteUser(int userId) {
        String sql = "DELETE FROM Users WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            System.out.println("SQL Error in deleteUser: " + e.getMessage());
            e.printStackTrace();
        }
        return false;
    }

    public List<User> searchUsers(String query) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE Fullname LIKE ? OR Username LIKE ? OR Email LIKE ? OR Phone LIKE ?"; // Thêm Phone
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, "%" + query + "%");
            ps.setString(2, "%" + query + "%");
            ps.setString(3, "%" + query + "%");
            ps.setString(4, "%" + query + "%"); // Tìm kiếm theo phone
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("Fullname"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("Phone"), // Thêm trường Phone
                        rs.getInt("RoleID"),
                        rs.getBoolean("IsActive"),
                        rs.getString("google_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in searchUsers: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }

      public List<User> filterUsersByRole(int roleId) {
        List<User> users = new ArrayList<>();
        String sql = "SELECT * FROM Users WHERE RoleID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setInt(1, roleId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                users.add(new User(
                        rs.getInt("UserID"),
                        rs.getString("Fullname"),
                        rs.getString("Username"),
                        rs.getString("Password"),
                        rs.getString("Email"),
                        rs.getString("Phone"), // Thêm trường Phone
                        rs.getInt("RoleID"),
                        rs.getBoolean("IsActive"),
                        rs.getString("google_id")
                ));
            }
        } catch (SQLException e) {
            System.out.println("SQL Error in filterUsersByRole: " + e.getMessage());
            e.printStackTrace();
        }
        return users;
    }
}
