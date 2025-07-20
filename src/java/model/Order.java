package model;

import java.sql.Date;

public class Order {
    private int orderID;
    private Integer userID;
    private String customerName;
    private String customerEmail;
    private String customerPhone;
    private String deliveryAddress;
    private Date orderDate;
    private int totalPrice;
    private String deliveryStatus;

    public Order() {
    }

    public Order(int orderID, Integer userID, String customerName, String customerEmail, 
                 String customerPhone, String deliveryAddress, Date orderDate, 
                 int totalPrice, String deliveryStatus) {
        this.orderID = orderID;
        this.userID = userID;
        this.customerName = customerName;
        this.customerEmail = customerEmail;
        this.customerPhone = customerPhone;
        this.deliveryAddress = deliveryAddress;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.deliveryStatus = deliveryStatus;
    }

    // Getters and Setters
    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public Integer getUserID() {
        return userID;
    }

    public void setUserID(Integer userID) {
        this.userID = userID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public String getCustomerEmail() {
        return customerEmail;
    }

    public void setCustomerEmail(String customerEmail) {
        this.customerEmail = customerEmail;
    }

    public String getCustomerPhone() {
        return customerPhone;
    }

    public void setCustomerPhone(String customerPhone) {
        this.customerPhone = customerPhone;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public int getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(int totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getDeliveryStatus() {
        return deliveryStatus;
    }

    public void setDeliveryStatus(String deliveryStatus) {
        this.deliveryStatus = deliveryStatus;
    }

    @Override
    public String toString() {
        return "Order{" +
                "orderID=" + orderID +
                ", userID=" + userID +
                ", customerName='" + customerName + '\'' +
                ", customerEmail='" + customerEmail + '\'' +
                ", customerPhone='" + customerPhone + '\'' +
                ", deliveryAddress='" + deliveryAddress + '\'' +
                ", orderDate=" + orderDate +
                ", totalPrice=" + totalPrice +
                ", deliveryStatus='" + deliveryStatus + '\'' +
                '}';
    }
}