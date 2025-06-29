/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package repository;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import model.Requests;
import java.sql.Timestamp;

/**
 *
 * @author Admin
 */
public class RequestsDao extends DBContext{
//    public List<Requests> getAllRequestsForNutritionist() {
//        List<Requests> list = new ArrayList<>();
//        String sql = "select a.RequestID, a.CustomerID, b.Fullname, a.RequestDate, a.PreferredDate, a.Status, a.ResponseNote from ConsulationRequests a join Users b ON a.CustomerID = b.UserID";
//        try {
//
//            PreparedStatement ps = connection.prepareStatement(sql);
//            ResultSet rs = ps.executeQuery();
//
//            while (rs.next()) {
//                int requestID = rs.getInt("RequestID");
//                int customerID = rs.getInt("CustomerID");
//                String customerName = rs.getString("Fullname");
//
//                Date requestDate = rs.getDate("RequestDate");
//                Date preferredDate = rs.getDate("PreferredDate");
//                String status = rs.getString("Status");
//                String note = rs.getString("ResponseNote");
//                Requests c = new Requests(requestID, customerID, customerName, requestDate, preferredDate, status, note);
//                list.add(c);
//            }
//        } catch (Exception e) {
//            System.out.println(e);
//        }
//        return list;
//    }

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
    
    public int countPageConsultation(int perPage) {
        String sql = "select count(*) from ConsulationRequests";
        int totalPage = 0;
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                int totalRecords = rs.getInt(1);
                totalPage = totalRecords / perPage;
                if (totalRecords % perPage != 0) {
                    totalPage++;
                }
            }
        } catch (SQLException e) {
            System.out.println("Error counting consultation pages: " + e.getMessage());
        }
        return totalPage;
    }

    public List<Requests> getConsultationRequestsPagination(int begin, int count) {
        List<Requests> list = new ArrayList<>();
        String sql = "SELECT * FROM ConsulationRequests a join Users b on a.CustomerID = b.UserID ORDER BY RequestDate OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try {
            PreparedStatement ps = connection.prepareStatement(sql);
            int offset = (begin - 1) * count;
            ps.setInt(1, offset);
            ps.setInt(2, count);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                Requests c = new Requests();
                c.setRequestID(rs.getInt("RequestID"));
                c.setCustomerID(rs.getInt("CustomerID"));
                c.setRequestDate(rs.getDate("RequestDate"));
                c.setCustomerName(rs.getString("Fullname"));
                c.setPreferredDate(rs.getDate("PreferredDate"));
                c.setStatus(rs.getString("Status"));
                c.setResponseNote(rs.getString("ResponseNote"));
                list.add(c);
            }
        } catch (SQLException e) {
            System.out.println("Error loading consultation list: " + e.getMessage());
        }
        return list;
    }
    
    public void addRequest(int customerid,  Date prefferedDate) throws SQLException{
          String sql = "insert into ConsulationRequests (CustomerID, PreferredDate, Status) VALUES (?, ?, 'Pending') ";
        try {
            PreparedStatement ps = connection.prepareStatement(sql);
//            ps.setString(1, addid);
            ps.setInt(1, customerid);
            ps.setTimestamp(2, new Timestamp(prefferedDate.getTime()));
            ps.executeUpdate();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
}
