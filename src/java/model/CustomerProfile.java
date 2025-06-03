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
    private String fullname;
    private String email;
    private String phone;
    private String gender;
    private int height;
    private int weight;
    private double BMI;
    private String activitylevel;
    private String goal;

    public CustomerProfile() {
    }

    public CustomerProfile(String fullname, String email, String phone, String gender, int height, int weight, double BMI, String activitylevel, String goal) {
        this.fullname = fullname;
        this.email = email;
        this.phone = phone;
        this.gender = gender;
        this.height = height;
        this.weight = weight;
        this.BMI = BMI;
        this.activitylevel = activitylevel;
        this.goal = goal;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
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

    public int getHeight() {
        return height;
    }

    public void setHeight(int height) {
        this.height = height;
    }

    public int getWeight() {
        return weight;
    }

    public void setWeight(int weight) {
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
        return "CustomerProfile{" + "fullname=" + fullname + ", email=" + email + ", phone=" + phone + ", gender=" + gender + ", height=" + height + ", weight=" + weight + ", BMI=" + BMI + ", activitylevel=" + activitylevel + ", goal=" + goal + '}';
    }
    
    
}
