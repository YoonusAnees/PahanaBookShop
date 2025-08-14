package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Book;
import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import com.pahana.bookshop.model.Stationery;

import java.sql.*;
import java.util.*;

public class OrderDAO {

    private static final String INSERT_ORDER =
        "INSERT INTO orders (customerId, fullName, email, address) VALUES (?, ?, ?, ?)";
    
    private static final String INSERT_ORDER_ITEM =
        "INSERT INTO order_items (orderId, bookId, stationeryId, quantity, price, customer_id) VALUES (?, ?, ?, ?, ?, ?)";

    private static final String SELECT_ALL_ORDERS =
        "SELECT * FROM orders ORDER BY orderDate DESC";



    private static final String SELECT_ORDER_BY_ID =
        "SELECT * FROM orders WHERE id = ?";

    private static final String SELECT_ORDER_ITEMS_BY_ORDER_ID =
        "SELECT * FROM order_items WHERE orderId = ?";

    private static final String UPDATE_ORDER =
        "UPDATE orders SET fullName=?, email=?, address=? WHERE id=?";

    private static final String DELETE_ORDER_ITEMS =
        "DELETE FROM order_items WHERE orderId=?";

    private static final String DELETE_ORDER =
        "DELETE FROM orders WHERE id=?";
    
    private static final String SELECT_ALL_ORDERS_WITH_ITEMS =
    	    "SELECT o.id AS order_id, o.customerId, o.fullName, o.email, o.address, o.orderDate, " +
    	    "oi.id AS order_item_id, oi.bookId, oi.stationeryId, oi.quantity, oi.price, " +
    	    "b.title AS book_title, b.category AS book_category, " + // Added book category
    	    "s.name AS stationery_name " +
    	    "FROM orders o " +
    	    "LEFT JOIN order_items oi ON o.id = oi.orderId " +
    	    "LEFT JOIN books b ON oi.bookId = b.id " +
    	    "LEFT JOIN stationery s ON oi.stationeryId = s.id " +
    	    "ORDER BY o.orderDate DESC";

    public int saveOrder(Order order) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement orderStmt = conn.prepareStatement(INSERT_ORDER, Statement.RETURN_GENERATED_KEYS)) {

            conn.setAutoCommit(false);

            orderStmt.setInt(1, order.getCustomerId());
            orderStmt.setString(2, order.getFullName());
            orderStmt.setString(3, order.getEmail());
            orderStmt.setString(4, order.getAddress());
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);

                try (PreparedStatement itemStmt = conn.prepareStatement(INSERT_ORDER_ITEM)) {
                    for (OrderItem item : order.getItems()) {
                        itemStmt.setInt(1, orderId);
                        if (item.getBookId() != null) {
                            itemStmt.setInt(2, item.getBookId());
                            itemStmt.setNull(3, Types.INTEGER);
                        } else {
                            itemStmt.setNull(2, Types.INTEGER);
                            itemStmt.setInt(3, item.getStationeryId());
                        }
                        itemStmt.setInt(4, item.getQuantity());
                        itemStmt.setDouble(5, item.getPrice());
                        itemStmt.setInt(6, order.getCustomerId());
                        itemStmt.addBatch();
                    }
                    itemStmt.executeBatch();
                }

                conn.commit();
                return orderId;
            } else {
                conn.rollback();
                throw new SQLException("Failed to retrieve order ID.");
            }
        }
    }

    public List<Order> getAllOrders() throws SQLException {
        List<Order> orders = new ArrayList<>();
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ALL_ORDERS);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customerId"));
                order.setFullName(rs.getString("fullName"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setOrderDate(rs.getTimestamp("orderDate"));
                orders.add(order);
            }
        }
        return orders;
    }

    public List<Order> getAllOrdersWithItems() throws SQLException {
        Map<Integer, Order> orderMap = new LinkedHashMap<>();

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(SELECT_ALL_ORDERS_WITH_ITEMS);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                int orderId = rs.getInt("order_id");
                Order order = orderMap.get(orderId);

                if (order == null) {
                    order = new Order();
                    order.setId(orderId);
                    order.setCustomerId(rs.getInt("customerId"));
                    order.setFullName(rs.getString("fullName"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setOrderDate(rs.getTimestamp("orderDate"));
                    order.setItems(new ArrayList<>());
                    orderMap.put(orderId, order);
                }

                int orderItemId = rs.getInt("order_item_id");
                if (orderItemId > 0) {
                    OrderItem item = mapResultSetToOrderItem(rs, orderId);
                    order.getItems().add(item);
                }
            }
        }
        return new ArrayList<>(orderMap.values());
    }
    
    

    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ORDER_BY_ID)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setCustomerId(rs.getInt("customerId"));
                    order.setFullName(rs.getString("fullName"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setOrderDate(rs.getTimestamp("orderDate"));
                    order.setItems(getOrderItems(orderId));
                }
            }
        }
        return order;
    }

    private List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_ORDER_ITEMS_BY_ORDER_ID)) {

            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    item.setBookId((Integer) rs.getObject("bookId"));
                    item.setStationeryId((Integer) rs.getObject("stationeryId"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    items.add(item);
                }
            }
        }
        return items;
    }

    public void updateOrder(Order order) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_ORDER)) {

            stmt.setString(1, order.getFullName());
            stmt.setString(2, order.getEmail());
            stmt.setString(3, order.getAddress());
            stmt.setInt(4, order.getId());
            stmt.executeUpdate();
        }
    }

    public void deleteOrder(int orderId) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection()) {
            conn.setAutoCommit(false);

            try (PreparedStatement itemStmt = conn.prepareStatement(DELETE_ORDER_ITEMS)) {
                itemStmt.setInt(1, orderId);
                itemStmt.executeUpdate();
            }

            try (PreparedStatement orderStmt = conn.prepareStatement(DELETE_ORDER)) {
                orderStmt.setInt(1, orderId);
                orderStmt.executeUpdate();
            }

            conn.commit();
        }
    }

    private OrderItem mapResultSetToOrderItem(ResultSet rs, int orderId) throws SQLException {
        OrderItem item = new OrderItem();
        item.setId(rs.getInt("order_item_id"));
        item.setOrderId(orderId);
        item.setBookId((Integer) rs.getObject("bookId"));
        item.setStationeryId((Integer) rs.getObject("stationeryId"));
        item.setQuantity(rs.getInt("quantity"));
        item.setPrice(rs.getDouble("price"));

        if (item.getBookId() != null) {
            Book book = new Book();
            book.setId(item.getBookId());
            book.setTitle(rs.getString("book_title"));
            book.setCategory(rs.getString("book_category")); // Set the category
            item.setBook(book);
        }
        if (item.getStationeryId() != null) {
            Stationery stationery = new Stationery();
            stationery.setId(item.getStationeryId());
            stationery.setName(rs.getString("stationery_name"));
            item.setStationery(stationery);
        }

        return item;
    }
}
