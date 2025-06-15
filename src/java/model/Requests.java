/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.util.Date;

/**
 *
 * @author Admin
 */
public class Requests {
    private int requestID;
    private int customerID;
    private String customerName;
    private Date requestDate;
    private Date preferredDate;
    private String status;
    private String responseNote;

    public Requests() {
    }

    public Requests(int requestID, int customerID, String customerName, Date requestDate, Date preferredDate, String status, String responseNote) {
        this.requestID = requestID;
        this.customerID = customerID;
        this.customerName = customerName;
        this.requestDate = requestDate;
        this.preferredDate = preferredDate;
        this.status = status;
        this.responseNote = responseNote;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public int getCustomerID() {
        return customerID;
    }

    public void setCustomerID(int customerID) {
        this.customerID = customerID;
    }

    public String getCustomerName() {
        return customerName;
    }

    public void setCustomerName(String customerName) {
        this.customerName = customerName;
    }

    public Date getRequestDate() {
        return requestDate;
    }

    public void setRequestDate(Date requestDate) {
        this.requestDate = requestDate;
    }

    public Date getPreferredDate() {
        return preferredDate;
    }

    public void setPreferredDate(Date preferredDate) {
        this.preferredDate = preferredDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getResponseNote() {
        return responseNote;
    }

    public void setResponseNote(String responseNote) {
        this.responseNote = responseNote;
    }

    @Override
    public String toString() {
        return "Requests{" + "requestID=" + requestID + ", customerID=" + customerID + ", customerName=" + customerName + ", requestDate=" + requestDate + ", preferredDate=" + preferredDate + ", status=" + status + ", responseNote=" + responseNote + '}';
    }

    
    
    
}
