package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.CartItem;
import com.pahana.bookshop.model.Stationery;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CartDAO {

    private Connection getConnection() throws SQLException {
        return DBConnectionFactory.getConnection();
    }

    private static final String SELECT_CART_BY_CUSTOMER_ID =
        "SELECT c.id AS cartId, c.quantity, " +
        "b.id AS bookId, b.title, b.author, b.price AS bookPrice, b.quantity AS bookStock, " +
        "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice, s.quantity AS stationeryStock " +
        "FROM cart c " +
        "LEFT JOIN books b ON c.bookId = b.id " +
        "LEFT JOIN stationery s ON c.stationeryId = s.id " +
        "WHERE c.customerId = ?";

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

    private static final String SELECT_CART_ITEM_BY_ID =
        "SELECT c.id AS cartId, c.customerId, c.quantity, " +
        "b.id AS bookId, b.title, b.author, b.price AS bookPrice, b.quantity AS bookStock, " +
        "s.id AS stationeryId, s.name AS stationeryName, s.price AS stationeryPrice, s.quantity AS stationeryStock " +
        "FROM cart c " +
        "LEFT JOIN books b ON c.bookId = b.id " +
        "LEFT JOIN stationery s ON c.stationeryId = s.id " +
        "WHERE c.id = ?";

    // ✅ Add item
    public void addToCart(int customerId, Integer bookId, Integer stationeryId, int quantity) {
        try (Connection conn = getConnection();
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

    // ✅ Get all items by customer
    public List<CartItem> getCartItemsByCustomerId(int customerId) {
        List<CartItem> cartItems = new ArrayList<>();
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CART_BY_CUSTOMER_ID)) {
            ps.setInt(1, customerId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                cartItems.add(mapResultSetToCartItem(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return cartItems;
    }

    // ✅ Find single item in cart (by book or stationery)
    public CartItem findCartItem(int customerId, Integer bookId, Integer stationeryId) {
        String sql = "SELECT * FROM cart WHERE customerId = ? AND " +
                     "((? IS NOT NULL AND bookId = ?) OR (? IS NOT NULL AND stationeryId = ?))";
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, customerId);
            if (bookId != null) { ps.setInt(2, bookId); ps.setInt(3, bookId); }
            else { ps.setNull(2, Types.INTEGER); ps.setNull(3, Types.INTEGER); }
            if (stationeryId != null) { ps.setInt(4, stationeryId); ps.setInt(5, stationeryId); }
            else { ps.setNull(4, Types.INTEGER); ps.setNull(5, Types.INTEGER); }

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToCartItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Get single cart item by ID
    public CartItem getCartItemById(int cartId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_CART_ITEM_BY_ID)) {
            ps.setInt(1, cartId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return mapResultSetToCartItem(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // ✅ Update quantity
    public void updateQuantity(int cartId, int quantity) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(UPDATE_CART_QUANTITY)) {
            ps.setInt(1, quantity);
            ps.setInt(2, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Remove one item
    public void removeCartItem(int cartId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(DELETE_CART_ITEM)) {
            ps.setInt(1, cartId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Clear cart
    public void clearCartByCustomer(int customerId) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(CLEAR_CART_BY_CUSTOMER)) {
            ps.setInt(1, customerId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Reduce stock (book)
    public void reduceBookStock(int bookId, int quantity) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(REDUCE_BOOK_STOCK)) {
            ps.setInt(1, quantity);
            ps.setInt(2, bookId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // ✅ Reduce stock (stationery)
    public void reduceStationeryStock(int stationeryId, int quantity) {
        try (Connection conn = getConnection();
             PreparedStatement ps = conn.prepareStatement(REDUCE_STATIONERY_STOCK)) {
            ps.setInt(1, quantity);
            ps.setInt(2, stationeryId);
            ps.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // 🔑 Map SQL → CartItem
    private CartItem mapResultSetToCartItem(ResultSet rs) throws SQLException {
        CartItem item = new CartItem();
        item.setId(rs.getInt("cartId"));
        item.setQuantity(rs.getInt("quantity"));

        int bookId = rs.getInt("bookId");
        if (!rs.wasNull()) {
            Book book = new Book();
            book.setId(bookId);
            book.setTitle(rs.getString("title"));
            book.setAuthor(rs.getString("author"));
            book.setPrice(rs.getDouble("bookPrice"));
            book.setQuantity(rs.getInt("bookStock"));
            item.setBook(book);
        }

        int stationeryId = rs.getInt("stationeryId");
        if (!rs.wasNull()) {
            Stationery s = new Stationery();
            s.setId(stationeryId);
            s.setName(rs.getString("stationeryName"));
            s.setPrice(rs.getDouble("stationeryPrice"));
            s.setQuantity(rs.getInt("stationeryStock"));
            item.setStationery(s);
        }
        return item;
    }
}
