package com.pahana.bookshop.model;

import java.util.Date;
import java.util.List;

public class Order {
    private int id;
    private int customerId;
    private String fullName;
    private String email;
    private String address;
    private Date orderDate;
    private List<OrderItem> items;

    // Constructors
    public Order() {}

    public Order(int customerId, String fullName, String email, String address, List<OrderItem> items) {
        this.customerId = customerId;
        this.fullName = fullName;
        this.email = email;
        this.address = address;
        this.items = items;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public Date getOrderDate() { return orderDate; }
    public void setOrderDate(Date orderDate) { this.orderDate = orderDate; }

    public List<OrderItem> getItems() { return items; }
    public void setItems(List<OrderItem> items) { this.items = items; }
}
