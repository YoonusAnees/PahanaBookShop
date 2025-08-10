package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.model.Book;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    public CartItem findCartItem(int customerId, int bookId) {
        String sql = "SELECT * FROM cart WHERE customerId = ? AND bookId = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, bookId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setCustomerId(rs.getInt("customerId"));
                    item.setBookId(rs.getInt("bookId"));
                    item.setQuantity(rs.getInt("quantity"));
                    // You can fetch Book details if needed here or elsewhere
                    return item;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addToCart(int customerId, int bookId, int quantity) {
        String sql = "INSERT INTO cart (customerId, bookId, quantity) VALUES (?, ?, ?)";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            ps.setInt(2, bookId);
            ps.setInt(3, quantity);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantity(int cartId, int newQuantity) {
        String sql = "UPDATE cart SET quantity = ? WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, newQuantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public List<CartItem> getCartItemsByCustomerId(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        String sql = "SELECT c.*, b.title, b.author, b.category, b.price, b.quantity as bookQuantity, b.image " +
                     "FROM cart c JOIN books b ON c.bookId = b.id WHERE c.customerId = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = new CartItem();
                    item.setId(rs.getInt("id"));
                    item.setCustomerId(rs.getInt("customerId"));
                    item.setBookId(rs.getInt("bookId"));
                    item.setQuantity(rs.getInt("quantity"));

                    Book book = new Book();
                    book.setId(rs.getInt("bookId"));
                    book.setTitle(rs.getString("title"));
                    book.setAuthor(rs.getString("author"));
                    book.setCategory(rs.getString("category"));
                    book.setPrice(rs.getDouble("price"));
                    book.setQuantity(rs.getInt("bookQuantity"));
                    book.setImage(rs.getString("image"));

                    item.setBook(book);

                    cartItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
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
