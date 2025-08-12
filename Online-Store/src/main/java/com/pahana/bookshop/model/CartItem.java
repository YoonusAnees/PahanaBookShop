package com.pahana.bookshop.model;

public class CartItem {
    private int id;
    private int customerId;
    private Book book;
    private Stationery stationery;
    private int quantity;
    private Integer bookId;      // nullable
    private Integer stationeryId; // nullable

    // Constructors
    public CartItem() {}

    // For books
    public CartItem(int id, int customerId, Book book, int quantity) {
        this.id = id;
        this.customerId = customerId;
        this.book = book;
        this.quantity = quantity;
        this.bookId = book != null ? book.getId() : null;
    }

    // For stationery
    public CartItem(int id, int customerId, Stationery stationery, int quantity) {
        this.id = id;
        this.customerId = customerId;
        this.stationery = stationery;
        this.quantity = quantity;
        this.stationeryId = stationery != null ? stationery.getId() : null;
    }

    // Getters and setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Book getBook() { return book; }
    public void setBook(Book book) { 
        this.book = book;
        this.bookId = book != null ? book.getId() : null;
    }

    public Stationery getStationery() { return stationery; }
    public void setStationery(Stationery stationery) { 
        this.stationery = stationery;
        this.stationeryId = stationery != null ? stationery.getId() : null;
    }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }

    public Integer getBookId() { return bookId; }
    public void setBookId(Integer bookId) { this.bookId = bookId; }

    public Integer getStationeryId() { return stationeryId; }
    public void setStationeryId(Integer stationeryId) { this.stationeryId = stationeryId; }
}
