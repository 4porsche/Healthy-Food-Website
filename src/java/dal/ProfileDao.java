/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dal;

import model.CustomerProfile;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Admin
 */
public class ProfileDao extends DBContext {

    public CustomerProfile getCustomer(int id) {
        CustomerProfile cp = null;
        String sql = "select * from Users a join CustomerProfiles b on a.UserID = b.CustomerID where userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String fullname = rs.getString("Fullname");
                String password = rs.getString("Password");
                String email = rs.getString("Email");

                String phone = rs.getString("Phone");
                String gender = rs.getString("Gender");
                double height = rs.getDouble("Height");
                double weight = rs.getDouble("Weight");
                double BMI = rs.getDouble("BMI");
                String activity = rs.getString("ActivityLevel");
                String goal = rs.getString("Goal");
                cp = new CustomerProfile(id, fullname, password, email, phone, gender, height, weight, BMI, activity, goal);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cp;
    }

    public void update(double height, double weight, double bmi, String activitylevel, String goal, int id) {
        String sql = "update CustomerProfiles set Height = ?, Weight = ?, BMI = ?, ActivityLevel = ?,  Goal = ? where CustomerID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, height);
            ps.setDouble(2, weight);
            ps.setDouble(3, bmi);
            ps.setString(4, activitylevel);
            ps.setString(5, goal);
            ps.setInt(6, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public void changePass(String pass, int id) {
        String sql = "update Users set Password = ? where UserID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, pass);
            ps.setInt(2, id);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public static void main(String[] args) {
        ProfileDao dao = new ProfileDao();
        CustomerProfile cp = dao.getCustomer(3);
//        dao.update(1, 1, 0, "Low", "lose weight", 3);
        System.out.println(cp.toString());
    }
}
