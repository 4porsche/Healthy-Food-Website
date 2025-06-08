/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Admin
 */
public class CustomerProfile {
    private int userid;
    private String fullname;
    private String password;
    private String email;
    private String phone;
    private String gender;
    private double height;
    private double weight;
    private double BMI;
    private String activitylevel;
    private String goal;

    public CustomerProfile() {
    }

    public CustomerProfile(int userid, String fullname, String password, String email, String phone, String gender, double height, double weight, double BMI, String activitylevel, String goal) {
        this.userid = userid;
        this.fullname = fullname;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.height = height;
        this.weight = weight;
        this.BMI = BMI;
        this.activitylevel = activitylevel;
        this.goal = goal;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }
    
    
    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public double getHeight() {
        return height;
    }

    public void setHeight(double height) {
        this.height = height;
    }

    public double getWeight() {
        return weight;
    }

    public void setWeight(double weight) {
        this.weight = weight;
    }

    public double getBMI() {
        return BMI;
    }

    public void setBMI(double BMI) {
        this.BMI = BMI;
    }

    public String getActivitylevel() {
        return activitylevel;
    }

    public void setActivitylevel(String activitylevel) {
        this.activitylevel = activitylevel;
    }

    public String getGoal() {
        return goal;
    }

    public void setGoal(String goal) {
        this.goal = goal;
    }

    @Override
    public String toString() {
        return "CustomerProfile{" + "userid=" + userid + ", fullname=" + fullname + ", password=" + password + ", email=" + email + ", phone=" + phone + ", gender=" + gender + ", height=" + height + ", weight=" + weight + ", BMI=" + BMI + ", activitylevel=" + activitylevel + ", goal=" + goal + '}';
    }

   

    
    
}
