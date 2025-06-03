/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author Home
 */
public class Product {
    private int productID;
    private int sellerID;
    private int categoryID;
    private String productName;
    private int price;
    private String description;
    private double weight;
    private double calories;
    private double protein;
    private double fat;
    private double carbs;
    private String tags;
    private String image;

    // Constructor
    public Product() {}

    public Product(int productID, int sellerID, int categoryID, String productName, int price, String description,
                   double weight, double calories, double protein, double fat, double carbs, String tags, String image) {
        this.productID = productID;
        this.sellerID = sellerID;
        this.categoryID = categoryID;
        this.productName = productName;
        this.price = price;
        this.description = description;
        this.weight = weight;
        this.calories = calories;
        this.protein = protein;
        this.fat = fat;
        this.carbs = carbs;
        this.tags = tags;
        this.image = image;
    }

    // Getters and Setters
    public int getProductID() { return productID; }
    public void setProductID(int productID) { this.productID = productID; }
    public int getSellerID() { return sellerID; }
    public void setSellerID(int sellerID) { this.sellerID = sellerID; }
    public int getCategoryID() { return categoryID; }
    public void setCategoryID(int categoryID) { this.categoryID = categoryID; }
    public String getProductName() { return productName; }
    public void setProductName(String productName) { this.productName = productName; }
    public int getPrice() { return price; }
    public void setPrice(int price) { this.price = price; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }
    public double getWeight() { return weight; }
    public void setWeight(double weight) { this.weight = weight; }
    public double getCalories() { return calories; }
    public void setCalories(double calories) { this.calories = calories; }
    public double getProtein() { return protein; }
    public void setProtein(double protein) { this.protein = protein; }
    public double getFat() { return fat; }
    public void setFat(double fat) { this.fat = fat; }
    public double getCarbs() { return carbs; }
    public void setCarbs(double carbs) { this.carbs = carbs; }
    public String getTags() { return tags; }
    public void setTags(String tags) { this.tags = tags; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}
