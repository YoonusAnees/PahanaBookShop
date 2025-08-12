package com.pahana.bookshop.model;

public class Stationery {
    private int id;
    private String name;
    private String description;
    private double price;
    private Integer quantity;

    public Stationery() {}

    // Constructor including id and quantity (for fetching from DB)
    public Stationery(int id, String name, String description, double price, Integer quantity) {
        this.id = id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
    }

    // Constructor without id (for insert)
    public Stationery(String name, String description, double price, Integer quantity) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.quantity = quantity;
    }

    // Constructor without quantity (optional)
    public Stationery(String name, String description, double price) {
        this.name = name;
        this.description = description;
        this.price = price;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Integer getQuantity() { return quantity; }
    public void setQuantity(Integer quantity) { this.quantity = quantity; }
}
