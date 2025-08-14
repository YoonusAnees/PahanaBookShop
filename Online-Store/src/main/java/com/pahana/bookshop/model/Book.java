package com.pahana.bookshop.model;

public class Book {
    private int id;
    private String title;
    private String author;
    private String category;
    private double price;
    private int quantity;
    private String image; 

    public Book() {}

    public Book(String title, String author, String category, double price, int quantity, String image) {
        this.title = title;
        this.author = author;
        this.category = category;
        this.price = price;
        this.quantity = quantity;
        this.image = image;
    }

    public Book(int id, String title, String author, String category, double price, int quantity, String image) {
        this(title, author, category, price, quantity, image);
        this.id = id;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public String getImage() { return image; }
    public void setImage(String image) { this.image = image; }
}
