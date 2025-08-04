package com.pahana.bookshop.model;

public class CartItem {

	 private int id;
	    private int customerId;
	    private int bookId;
	    private int quantity;
		public CartItem(int id, int customerId, int bookId, int quantity) {
			super();
			this.id = id;
			this.customerId = customerId;
			this.bookId = bookId;
			this.quantity = quantity;
		}
		public int getId() {
			return id;
		}
		public void setId(int id) {
			this.id = id;
		}
		public int getCustomerId() {
			return customerId;
		}
		public void setCustomerId(int customerId) {
			this.customerId = customerId;
		}
		public int getBookId() {
			return bookId;
		}
		public void setBookId(int bookId) {
			this.bookId = bookId;
		}
		public int getQuantity() {
			return quantity;
		}
		public void setQuantity(int quantity) {
			this.quantity = quantity;
		}
	    
	    
}
