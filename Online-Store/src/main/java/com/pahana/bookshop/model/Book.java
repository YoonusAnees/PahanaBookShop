package com.pahana.bookshop.model;

public class Book {

	  private int id;
	    private String authorId;
	    private String authorName;
	    private int stock;
	    private double price;
	    private String title;
		public Book(int id, String authorId, String authorName, int stock, double price, String title) {
			super();
			this.id = id;
			this.authorId = authorId;
			this.authorName = authorName;
			this.stock = stock;
			this.price = price;
			this.title = title;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public String getAuthorId() {
			return authorId;
		}
		public void setAuthorId(String authorId) {
			this.authorId = authorId;
		}
		public String getAuthorName() {
			return authorName;
		}
		public void setAuthorName(String authorName) {
			this.authorName = authorName;
		}
		public int getStock() {
			return stock;
		}
		public void setStock(int stock) {
			this.stock = stock;
		}
		public double getPrice() {
			return price;
		}
		public void setPrice(double price) {
			this.price = price;
		}
		public String getTitle() {
			return title;
		}
		public void setTitle(String title) {
			this.title = title;
		}
	    
	    
}
