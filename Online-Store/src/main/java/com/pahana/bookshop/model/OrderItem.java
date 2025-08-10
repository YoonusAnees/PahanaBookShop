package com.pahana.bookshop.model;

public class OrderItem {
    private int id;
    private int orderId;
    private int bookId;
    private int quantity;
    private double price;

    // Book object (optional)
    private Book book;

    public OrderItem() {}

    public OrderItem(int bookId, int quantity, double price) {
        this.bookId = bookId;
        this.quantity = quantity;
        this.price = price;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getOrderId() { return orderId; }
    public void setOrderId(int orderId) { this.orderId = orderId; }

    public int getBookId() { return bookId; }
    public void setBookId(int bookId) { this.bookId = bookId; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }
}
