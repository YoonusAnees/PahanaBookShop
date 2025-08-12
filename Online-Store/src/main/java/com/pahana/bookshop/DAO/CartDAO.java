package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.model.Stationery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

	 public List<CartItem> getCartItemsByCustomerId(int customerId) {
	        List<CartItem> cartItems = new ArrayList<>();
	        String sql = "SELECT c.id AS cartId, c.quantity, " +
	                "b.id AS bookId, b.title, b.author, b.price AS bookPrice, " +
	                "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice " +
	                "FROM cart c " +
	                "LEFT JOIN books b ON c.bookId = b.id " +
	                "LEFT JOIN stationery s ON c.stationeryId = s.id " +
	                "WHERE c.customerId = ?";

	        try (Connection conn = DBConnectionFactory.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {

	            ps.setInt(1, customerId);

	            try (ResultSet rs = ps.executeQuery()) {
	                while (rs.next()) {
	                    CartItem item = new CartItem();
	                    item.setId(rs.getInt("cartId"));
	                    item.setQuantity(rs.getInt("quantity"));

	                    int bookId = rs.getInt("bookId");
	                    boolean bookIdIsNull = rs.wasNull();  // check right after getInt

	                    int stationeryId = rs.getInt("stationeryId");
	                    boolean stationeryIdIsNull = rs.wasNull();  // check right after getInt

	                    if (!bookIdIsNull) {
	                        Book book = new Book();
	                        book.setId(bookId);
	                        book.setTitle(rs.getString("title"));
	                        book.setAuthor(rs.getString("author"));
	                        book.setPrice(rs.getDouble("bookPrice"));
	                        item.setBook(book);
	                        item.setStationery(null);
	                    } else if (!stationeryIdIsNull) {
	                        Stationery stationery = new Stationery();
	                        stationery.setId(stationeryId);
	                        stationery.setName(rs.getString("stationeryName"));
	                        stationery.setPrice(rs.getDouble("stationeryPrice"));
	                        item.setStationery(stationery);
	                        item.setBook(null);
	                    }

	                    cartItems.add(item);

	                    // Debug output - remove or comment out in production
	                    System.out.println("CartItem id=" + item.getId() + ", quantity=" + item.getQuantity());
	                    if (item.getBook() != null) {
	                        System.out.println("  Book: " + item.getBook().getTitle() + ", price: " + item.getBook().getPrice());
	                    }
	                    if (item.getStationery() != null) {
	                        System.out.println("  Stationery: " + item.getStationery().getName() + ", price: " + item.getStationery().getPrice());
	                    }
	                }
	            }
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	        return cartItems;
	    }
	 
	 public CartItem findCartItem(int customerId, Integer bookId, Integer stationeryId) {
		    String sql = "SELECT c.id AS cartId, c.quantity, " +
		            "b.id AS bookId, b.title, b.author, b.price AS bookPrice, " +
		            "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice " +
		            "FROM cart c " +
		            "LEFT JOIN books b ON c.bookId = b.id " +
		            "LEFT JOIN stationery s ON c.stationeryId = s.id " +
		            "WHERE c.customerId = ? AND ((? IS NOT NULL AND c.bookId = ?) OR (? IS NOT NULL AND c.stationeryId = ?))";

		    try (Connection conn = DBConnectionFactory.getConnection();
		         PreparedStatement ps = conn.prepareStatement(sql)) {
		        ps.setInt(1, customerId);
		        // For bookId parameters
		        if (bookId != null) {
		            ps.setInt(2, bookId);
		            ps.setInt(3, bookId);
		        } else {
		            ps.setNull(2, Types.INTEGER);
		            ps.setNull(3, Types.INTEGER);
		        }
		        // For stationeryId parameters
		        if (stationeryId != null) {
		            ps.setInt(4, stationeryId);
		            ps.setInt(5, stationeryId);
		        } else {
		            ps.setNull(4, Types.INTEGER);
		            ps.setNull(5, Types.INTEGER);
		        }

		        try (ResultSet rs = ps.executeQuery()) {
		            if (rs.next()) {
		                CartItem item = new CartItem();
		                item.setId(rs.getInt("cartId"));
		                item.setQuantity(rs.getInt("quantity"));

		                int bId = rs.getInt("bookId");
		                boolean bookIsNull = rs.wasNull();

		                int sId = rs.getInt("stationeryId");
		                boolean stationeryIsNull = rs.wasNull();

		                if (!bookIsNull) {
		                    Book book = new Book();
		                    book.setId(bId);
		                    book.setTitle(rs.getString("title"));
		                    book.setAuthor(rs.getString("author"));
		                    book.setPrice(rs.getDouble("bookPrice"));
		                    item.setBook(book);
		                    item.setStationery(null);
		                } else if (!stationeryIsNull) {
		                    Stationery stationery = new Stationery();
		                    stationery.setId(sId);
		                    stationery.setName(rs.getString("stationeryName"));
		                    stationery.setPrice(rs.getDouble("stationeryPrice"));
		                    item.setStationery(stationery);
		                    item.setBook(null);
		                }
		                return item;
		            }
		        }
		    } catch (SQLException e) {
		        e.printStackTrace();
		    }
		    return null;
		}


	 public void addToCart(int customerId, Integer bookId, Integer stationeryId, int quantity) {
	        String sql = "INSERT INTO cart (customerId, bookId, stationeryId, quantity) VALUES (?, ?, ?, ?)";
	        try (Connection conn = DBConnectionFactory.getConnection();
	             PreparedStatement ps = conn.prepareStatement(sql)) {
	            ps.setInt(1, customerId);
	            if (bookId != null)
	                ps.setInt(2, bookId);
	            else
	                ps.setNull(2, Types.INTEGER);

	            if (stationeryId != null)
	                ps.setInt(3, stationeryId);
	            else
	                ps.setNull(3, Types.INTEGER);

	            ps.setInt(4, quantity);

	            ps.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	        }
	    }

    public void updateQuantity(int cartId, int quantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeCartItem(int cartId) {
        String sql = "DELETE FROM cart WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    

    public void reduceBookStock(int bookId, int quantity) {
        String sql = "UPDATE books SET quantity = quantity - ? WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void reduceStationeryStock(int stationeryId, int quantity) {
    	String sql = "UPDATE stationery SET quantity = quantity - ? WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, quantity);
            ps.setInt(2, stationeryId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCartByCustomer(int customerId) {
        String sql = "DELETE FROM cart WHERE customerId = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
