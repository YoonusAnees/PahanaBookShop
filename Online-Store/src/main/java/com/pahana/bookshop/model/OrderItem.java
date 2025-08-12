package com.pahana.bookshop.model;

public class OrderItem {
    private int id;
    private int orderId;
    private Integer bookId;
    private Integer stationeryId;
    private int quantity;
    private double price;
    private Book book;
    private Stationery stationery;

    public OrderItem() {}

    // For books
    public OrderItem(int bookId, int quantity, double price) {
        this.bookId = bookId;
        this.quantity = quantity;
        this.price = price;
    }

    // For stationery
    public OrderItem(int stationeryId, int quantity, double price, boolean isStationery) {
        this.stationeryId = stationeryId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }
    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }
    public Integer getStationeryId() { return stationeryId; }
    public void setStationeryId(Integer stationeryId) { this.stationeryId = stationeryId; }
    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }
    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
    public Stationery getStationery() { return stationery; }
    public void setStationery(Stationery stationery) { this.stationery = stationery; }
}