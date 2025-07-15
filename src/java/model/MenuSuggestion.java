/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;
import java.sql.Date;
/**
 *
 * @author PC
 */
public class MenuSuggestion {
     private int suggestionId;
    private String title;
    private String description;
    private int nutritionistId;
    private Date createdDate;
    private String status;

    public MenuSuggestion() {
    }

    public MenuSuggestion(int suggestionId, String title, String description, int nutritionistId, Date createdDate, String status) {
        this.suggestionId = suggestionId;
        this.title = title;
        this.description = description;
        this.nutritionistId = nutritionistId;
        this.createdDate = createdDate;
        this.status = status;
    }

    public int getSuggestionId() {
        return suggestionId;
    }

    public void setSuggestionId(int suggestionId) {
        this.suggestionId = suggestionId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getNutritionistId() {
        return nutritionistId;
    }

    public void setNutritionistId(int nutritionistId) {
        this.nutritionistId = nutritionistId;
    }

    public Date getCreatedDate() {
        return createdDate;
    }

    public void setCreatedDate(Date createdDate) {
        this.createdDate = createdDate;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }
    
}
