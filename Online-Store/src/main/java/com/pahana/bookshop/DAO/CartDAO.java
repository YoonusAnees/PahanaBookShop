package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.model.Stationery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private static final String SELECT_CART_BY_CUSTOMER_ID =
        "SELECT c.id AS cartId, c.quantity, " +
        "b.id AS bookId, b.title, b.author, b.price AS bookPrice, " +
        "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice " +
        "FROM cart c " +
        "LEFT JOIN books b ON c.bookId = b.id " +
        "LEFT JOIN stationery s ON c.stationeryId = s.id " +
        "WHERE c.customerId = ?";

    private static final String SELECT_CART_ITEM =
        "SELECT c.id AS cartId, c.quantity, " +
        "b.id AS bookId, b.title, b.author, b.price AS bookPrice, " +
        "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice " +
        "FROM cart c " +
        "LEFT JOIN books b ON c.bookId = b.id " +
        "LEFT JOIN stationery s ON c.stationeryId = s.id " +
        "WHERE c.customerId = ? AND ((? IS NOT NULL AND c.bookId = ?) OR (? IS NOT NULL AND c.stationeryId = ?))";

    private static final String INSERT_CART_ITEM =
        "INSERT INTO cart (customerId, bookId, stationeryId, quantity) VALUES (?, ?, ?, ?)";

    private static final String UPDATE_CART_QUANTITY =
        "UPDATE cart SET quantity = ? WHERE id = ?";

    private static final String DELETE_CART_ITEM =
        "DELETE FROM cart WHERE id = ?";

    private static final String CLEAR_CART_BY_CUSTOMER =
        "DELETE FROM cart WHERE customerId = ?";

    private static final String REDUCE_BOOK_STOCK =
        "UPDATE books SET quantity = quantity - ? WHERE id = ?";

    private static final String REDUCE_STATIONERY_STOCK =
        "UPDATE stationery SET quantity = quantity - ? WHERE id = ?";

    public List<CartItem> getCartItemsByCustomerId(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CART_BY_CUSTOMER_ID)) {

            ps.setInt(1, customerId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartItem item = mapResultSetToCartItem(rs);
                    cartItems.add(item);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    public CartItem findCartItem(int customerId, Integer bookId, Integer stationeryId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CART_ITEM)) {

            ps.setInt(1, customerId);
            if (bookId != null) {
                ps.setInt(2, bookId);
                ps.setInt(3, bookId);
            } else {
                ps.setNull(2, Types.INTEGER);
                ps.setNull(3, Types.INTEGER);
            }
            if (stationeryId != null) {
                ps.setInt(4, stationeryId);
                ps.setInt(5, stationeryId);
            } else {
                ps.setNull(4, Types.INTEGER);
                ps.setNull(5, Types.INTEGER);
            }

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToCartItem(rs);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public void addToCart(int customerId, Integer bookId, Integer stationeryId, int quantity) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(INSERT_CART_ITEM)) {

            ps.setInt(1, customerId);
            if (bookId != null) ps.setInt(2, bookId); else ps.setNull(2, Types.INTEGER);
            if (stationeryId != null) ps.setInt(3, stationeryId); else ps.setNull(3, Types.INTEGER);
            ps.setInt(4, quantity);

            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void updateQuantity(int cartId, int quantity) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_CART_QUANTITY)) {

            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void removeCartItem(int cartId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_CART_ITEM)) {

            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void clearCartByCustomer(int customerId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(CLEAR_CART_BY_CUSTOMER)) {

            ps.setInt(1, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void reduceBookStock(int bookId, int quantity) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(REDUCE_BOOK_STOCK)) {

            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public void reduceStationeryStock(int stationeryId, int quantity) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(REDUCE_STATIONERY_STOCK)) {

            ps.setInt(1, quantity);
            ps.setInt(2, stationeryId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setId(rs.getInt("cartId"));
        item.setQuantity(rs.getInt("quantity"));

        int bookId = rs.getInt("bookId");
        boolean bookIsNull = rs.wasNull();

        int stationeryId = rs.getInt("stationeryId");
        boolean stationeryIsNull = rs.wasNull();

        if (!bookIsNull) {
            Book book = new Book();
            book.setId(bookId);
            book.setTitle(rs.getString("title"));
            book.setAuthor(rs.getString("author"));
            book.setPrice(rs.getDouble("bookPrice"));
            item.setBook(book);
            item.setStationery(null);
        } else if (!stationeryIsNull) {
            Stationery stationery = new Stationery();
            stationery.setId(stationeryId);
            stationery.setName(rs.getString("stationeryName"));
            stationery.setPrice(rs.getDouble("stationeryPrice"));
            item.setStationery(stationery);
            item.setBook(null);
        }
        return item;
    }
}
