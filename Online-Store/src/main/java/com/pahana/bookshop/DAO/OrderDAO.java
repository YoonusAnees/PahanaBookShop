package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Order;
import com.pahana.bookshop.model.OrderItem;
import java.sql.*;
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
}