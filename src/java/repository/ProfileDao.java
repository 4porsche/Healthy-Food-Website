/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import repository.DBContext;
import model.CustomerProfile;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Requests;

/**
 *
 * @author Admin
 */
public class ProfileDao extends DBContext {

    public CustomerProfile getCustomer(int id, int roleid) {
        CustomerProfile cp = null;
        String sql = "select * from Users a join CustomerProfiles b on a.UserID = b.CustomerID where userID = ? and roleID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setInt(1, id);
            ps.setInt(2, roleid);
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
                cp = new CustomerProfile(id, fullname, password, email, phone, gender, height, weight, BMI, activity, goal, roleid);

            }
        } catch (SQLException e) {
            System.out.println(e);
        }
        return cp;
    }

    public void update(double height, double weight, double bmi, String activitylevel, String goal, int id, int roleid) {
        String sql = "update CustomerProfiles set Height = ?, Weight = ?, BMI = ?, ActivityLevel = ?,  Goal = ? where CustomerID = ? and roleid = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setDouble(1, height);
            ps.setDouble(2, weight);
            ps.setDouble(3, bmi);
            ps.setString(4, activitylevel);
            ps.setString(5, goal);
            ps.setInt(6, id);
            ps.setInt(7, roleid);
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }

    public List<Requests> getAllRequestsForNutritionist() {
        List<Requests> list = new ArrayList<>();
        String sql = "select a.RequestID, a.CustomerID, b.Fullname, a.RequestDate, a.PreferredDate, a.Status, a.ResponseNote from ConsulationRequests a join Users b ON a.CustomerID = b.UserID";
        try {

            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int requestID = rs.getInt("RequestID");
                int customerID = rs.getInt("CustomerID");
                String customerName = rs.getString("Fullname");

                Date requestDate = rs.getDate("RequestDate");
                Date preferredDate = rs.getDate("PreferredDate");
                String status = rs.getString("Status");
                String note = rs.getString("ResponseNote");
                Requests c = new Requests(requestID, customerID, customerName, requestDate, preferredDate, status, note);
                list.add(c);
            }
        } catch (Exception e) {
            System.out.println(e);
        }
        return list;
    }

    public void updateResponse(int requestID, String status, String note) {
        String sql = "update ConsulationRequests set Status = ?, ResponseNote = ? where RequestID = ?";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, status);
            ps.setString(2, note);
            ps.setInt(3, requestID);
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
//        CustomerProfile cp = dao.getCustomer(3);
        List<Requests> r = dao.getAllRequestsForNutritionist();
//        dao.update(1, 1, 0, "Low", "lose weight", 3);
//        System.out.println(cp.toString());
        System.out.println(r.toString());
    }
}
