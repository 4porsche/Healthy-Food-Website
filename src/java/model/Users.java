package model;

public class Users {

    private int userId;
    private String fullname;
    private String username;
    private String password;
    private String email;
    private int roleId;

    public Users() {
    }

    public Users(int userId, String fullname, String username, String password, String email, int roleId) {
        this.userId = userId;
        this.fullname = fullname;
        this.username = username;
        this.password = password;
        this.email = email;
        this.roleId = roleId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
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

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

}
