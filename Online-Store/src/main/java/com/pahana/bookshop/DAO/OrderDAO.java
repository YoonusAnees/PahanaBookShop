package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class OrderDAO {

    public int saveOrder(Order order) throws SQLException {
        String orderSql = "INSERT INTO orders (customerId, fullName, email, address) VALUES (?, ?, ?, ?)";

        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement orderStmt = conn.prepareStatement(orderSql, Statement.RETURN_GENERATED_KEYS)) {

            conn.setAutoCommit(false);

            orderStmt.setInt(1, order.getCustomerId());
            orderStmt.setString(2, order.getFullName());
            orderStmt.setString(3, order.getEmail());
            orderStmt.setString(4, order.getAddress());
            orderStmt.executeUpdate();

            ResultSet rs = orderStmt.getGeneratedKeys();
            if (rs.next()) {
                int orderId = rs.getInt(1);

                String itemSql = "INSERT INTO order_items (orderId, bookId, stationeryId, quantity, price, customer_id) " +
                                "VALUES (?, ?, ?, ?, ?, ?)";
                try (PreparedStatement itemStmt = conn.prepareStatement(itemSql)) {
                    List<OrderItem> items = order.getItems();
                    for (OrderItem item : items) {
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
        String sql = "SELECT * FROM orders ORDER BY `orderDate` DESC";  // <--- Use exact column name here

        try (PreparedStatement stmt =  DBConnectionFactory.getConnection().prepareStatement(sql);
             ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt("id"));
                order.setCustomerId(rs.getInt("customerId"));
                order.setFullName(rs.getString("fullName"));
                order.setEmail(rs.getString("email"));
                order.setAddress(rs.getString("address"));
                order.setOrderDate(rs.getTimestamp("orderDate")); // Make sure this matches column name exactly

                // Populate order items if needed here...

                orders.add(order);
            }
        }
        return orders;
    }


    private List<OrderItem> getOrderItems(int orderId) throws SQLException {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT * FROM order_items WHERE orderId = ?";
        
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    OrderItem item = new OrderItem();
                    item.setId(rs.getInt("id"));
                    if (rs.getObject("bookId") != null) {
                        item.setBookId(rs.getInt("bookId"));
                    }
                    if (rs.getObject("stationeryId") != null) {
                        item.setStationeryId(rs.getInt("stationeryId"));
                    }
                    item.setQuantity(rs.getInt("quantity"));
                    item.setPrice(rs.getDouble("price"));
                    items.add(item);
                }
            }
        }
        return items;
    }
    
 // In OrderDAO.java

    public void updateOrder(Order order) throws SQLException {
        String updateOrderSql = "UPDATE orders SET fullName=?, email=?, address=? WHERE id=?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(updateOrderSql)) {

            stmt.setString(1, order.getFullName());
            stmt.setString(2, order.getEmail());
            stmt.setString(3, order.getAddress());
            stmt.setInt(4, order.getId());

            stmt.executeUpdate();

            // Optionally: update order items here if needed
            // For simplicity, you might skip updating order items or delete & re-insert

        }
    }

    public void deleteOrder(int orderId) throws SQLException {
        try (Connection conn = DBConnectionFactory.getConnection()) {
            conn.setAutoCommit(false);

            // Delete order items first (FK constraint)
            try (PreparedStatement itemStmt = conn.prepareStatement("DELETE FROM order_items WHERE orderId = ?")) {
                itemStmt.setInt(1, orderId);
                itemStmt.executeUpdate();
            }

            // Delete order
            try (PreparedStatement orderStmt = conn.prepareStatement("DELETE FROM orders WHERE id = ?")) {
                orderStmt.setInt(1, orderId);
                orderStmt.executeUpdate();
            }

            conn.commit();
        }
    }

    public Order getOrderById(int orderId) throws SQLException {
        Order order = null;
        String sql = "SELECT * FROM orders WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, orderId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    order = new Order();
                    order.setId(rs.getInt("id"));
                    order.setCustomerId(rs.getInt("customerId"));
                    order.setFullName(rs.getString("fullName"));
                    order.setEmail(rs.getString("email"));
                    order.setAddress(rs.getString("address"));
                    order.setOrderDate(rs.getTimestamp("order_date"));
                    order.setItems(getOrderItems(orderId));
                }
            }
        }
        return order;
    }

    
}