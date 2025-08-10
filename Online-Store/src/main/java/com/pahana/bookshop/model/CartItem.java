package com.pahana.bookshop.model;

public class CartItem {
    private int id;
    private int customerId;
    private Book book;
    private int quantity;
    
    private int bookId;

    public int getBookId() {
        return bookId;
    }

    public void setBookId(int bookId) {
        this.bookId = bookId;
    }


    public CartItem() {}

    public CartItem(int id, int customerId, Book book, int quantity) {
        this.id = id;
        this.customerId = customerId;
        this.book = book;
        this.quantity = quantity;
    }
    
    public CartItem(int id, int customerId, int bookId, Book book, int quantity) {
        this.id = id;
        this.customerId = customerId;
        this.bookId = bookId;
        this.book = book;
        this.quantity = quantity;
    }


    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getCustomerId() { return customerId; }
    public void setCustomerId(int customerId) { this.customerId = customerId; }

    public Book getBook() { return book; }
    public void setBook(Book book) { this.book = book; }

    public int getQuantity() { return quantity; }
    public void setQuantity(int quantity) { this.quantity = quantity; }
}