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
public class ProfileDao extends DBContext{
      public CustomerProfile getCustomer(int id) {
          CustomerProfile cp = null;
        String sql = "select * from Users a join CustomerProfiles b on a.UserID = b.CustomerID where userID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String fullname = rs.getString("Fullname");
                String email = rs.getString("Email");
                String phone = rs.getString("Phone");
                String gender = rs.getString("Gender");
                int height = rs.getInt("Height");
                int weight = rs.getInt("Weight");
                double BMI = rs.getDouble("BMI");
                String activity = rs.getString("ActivityLevel");
                String goal = rs.getString("Goal");
                cp = new CustomerProfile(fullname, email, phone, gender, height, weight, BMI, activity, goal);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
       return cp;
    }
      
      
      public static void main(String[] args) {
        ProfileDao dao = new ProfileDao();
        CustomerProfile cp = dao.getCustomer(3);
          System.out.println(cp.getFullname());
    }
}
