package repository;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

public class DBContext {

    protected Connection connection;

    public DBContext() {
        try {
            String url = "jdbc:sqlserver://DESKTOP-DU9E5B7\\NINH:1433;databaseName=HealthyFoodDB";
            String username = "sa";
            String password = "123";
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (ClassNotFoundException | SQLException e) {
            System.out.println(e);
        }
    }
    public boolean isConnected() {
        try {
            return connection != null && !connection.isClosed();
        } catch (SQLException ex) {
            Logger.getLogger(DBContext.class.getName()).log(Level.SEVERE, null, ex);
            return false;
        }
    }
    
    public ResultSet selectData(String sql) {
        ResultSet rs = null;
        try {
            Statement st = connection.createStatement(
                    ResultSet.TYPE_SCROLL_SENSITIVE,
                    ResultSet.CONCUR_UPDATABLE);
            rs = st.executeQuery(sql);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return rs; 
    }
    
    // Phương thức main để kiểm tra kết nối
    public static void main(String[] args) {
        DBContext dbContext = new DBContext();
        if (dbContext.isConnected()) {
            System.out.println("Kết nối cơ sở dữ liệu thành công!");
        } else {
            System.out.println("Kết nối cơ sở dữ liệu thất bại.");
        }
    
    }
}


