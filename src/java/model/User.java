package model;

public class User {
    private int userID;
    private String fullname;
    private String username;
    private String password;
    private String email;
    private int roleID;
    private boolean isActive;

    public User() {
    }

    public User(int userID, String fullname, String username, String password, String email, int roleID, boolean isActive) {
        this.userID = userID;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.roleID = roleID;
        this.isActive = isActive;
    }

    // Getters and setters
    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public int getRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public boolean isIsActive() {
        return isActive;
    }

    public void setIsActive(boolean isActive) {
        this.isActive = isActive;
    }
    
    // Helper method to get role name
    public String getRoleName() {
        switch (roleID) {
            case 1: return "Admin";
            case 2: return "Guest";
            case 3: return "Customer";
            case 4: return "Nutritionist";
            case 5: return "Seller";
            case 6: return "Shipper";
            default: return "Unknown";
        }
    }
    
    // Helper method to get status text
    public String getStatusText() {
        return isActive ? "Active" : "Inactive";
    }
}