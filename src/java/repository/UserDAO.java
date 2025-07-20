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
import model.User;

/**
 *
 * @author PC
 */
public class UserDAO extends DBContext {

    private DBContext dbContext = new DBContext();

    public User login(String username, String password) {
        String sql = "SELECT * FROM Users WHERE Username=? AND Password=?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                User u = new User();
                u.setUserID(rs.getInt("UserID"));
                u.setFullname(rs.getString("Fullname"));
                u.setUsername(rs.getString("Username"));
                u.setPassword(rs.getString("Password"));
                u.setEmail(rs.getString("Email"));
                u.setRoleID(rs.getInt("RoleID"));
                return u;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public boolean register(User user) {
        String sql = "INSERT INTO Users (Fullname, Username, Password, Email, RoleID) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, user.getFullname());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getPassword());
            ps.setString(4, user.getEmail());
            ps.setInt(5, user.getRoleID());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean emailExists(String email) {
        String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {

            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public User getUserByEmail(String email) {
     System.out.println("Getting user by email: " + email);
    String sql = "SELECT * FROM Users WHERE Email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getInt("UserID"),
                rs.getString("Fullname"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Email"),
                    rs.getString("Phone"),
                rs.getInt("RoleID"),
                rs.getBoolean("IsActive"),
                rs.getString("google_id")
            );
            System.out.println("User found: " + user.getEmail());
            return user;
        }
    } catch (SQLException e) {
        System.err.println("Error in getUserByEmail:");
        e.printStackTrace();
    }
    System.out.println("No user found for email: " + email);
    return null;
}

    public void updatePassword(int userId, String newPassword) {
        String sql = "UPDATE Users SET Password = ? WHERE UserID = ?";
        try (PreparedStatement st = connection.prepareStatement(sql)) {
            st.setString(1, newPassword);
            st.setInt(2, userId);
            st.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }

    }

     public User getUserByGoogleId(String googleId) {
        System.out.println("Getting user by Google ID: " + googleId);
    String sql = "SELECT * FROM Users WHERE google_id = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, googleId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            User user = new User(
                rs.getInt("UserID"),
                rs.getString("Fullname"),
                rs.getString("Username"),
                rs.getString("Password"),
                rs.getString("Email"),
                      rs.getString("Phone"),
                rs.getInt("RoleID"),
                rs.getBoolean("IsActive"),
                rs.getString("google_id")
            );
            System.out.println("User found: " + user.getEmail());
            return user;
        }
    } catch (SQLException e) {
        System.err.println("Error in getUserByGoogleId:");
        e.printStackTrace();
    }
    System.out.println("No user found for Google ID: " + googleId);
    return null;
}

    public void addGoogleUser(String googleId, String fullname, String email) {
        System.out.println("Adding Google user: " + email);
    String sql = "INSERT INTO Users (Fullname, Email, google_id, RoleID, IsActive) VALUES (?, ?, ?, ?, ?)";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, fullname);
        ps.setString(2, email);
        ps.setString(3, googleId);
        ps.setInt(4, 3); // Customer role
        ps.setBoolean(5, true); // Active
        
        int rowsAffected = ps.executeUpdate();
        System.out.println("Rows affected: " + rowsAffected);
        
    } catch (SQLException e) {
        System.err.println("Error in addGoogleUser:");
        e.printStackTrace();
    }
    }
    public void updateGoogleId(int userId, String googleId) {
        String sql = "UPDATE Users SET google_id = ? WHERE UserID = ?";
        try (PreparedStatement ps = connection.prepareStatement(sql)) {
            ps.setString(1, googleId);
            ps.setInt(2, userId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    public boolean isEmailRegistered(String email) {
    String sql = "SELECT COUNT(*) FROM Users WHERE email = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, email);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1) > 0;
        }
    } catch (SQLException e) {
        e.printStackTrace();
    }
    return false;
}
    public void updateUsername(int userId, String username) {
    String sql = "UPDATE Users SET Username = ? WHERE UserID = ?";
    try (PreparedStatement ps = connection.prepareStatement(sql)) {
        ps.setString(1, username);
        ps.setInt(2, userId);
        ps.executeUpdate();
    } catch (SQLException e) {
        e.printStackTrace();
    }
}

  
}
