package com.online.model;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

public class Order {

    // MATCH DATABASE COLUMN NAMES
    private int id;          // instead of orderId
    private int userId;
    private double total;
    private String status;
    private Timestamp createdAt;

    private List<OrderItem> items = new ArrayList<>();

    // ==========================
    // Getters & Setters
    // ==========================

    public int getId() {          // JSP and DAO expect getId()
        return id;
    }

    public void setId(int id) {   // DAO will use setId(rs.getInt("id"))
        this.id = id;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}
