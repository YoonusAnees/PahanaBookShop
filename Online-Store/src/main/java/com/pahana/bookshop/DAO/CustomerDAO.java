package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Customer;
import java.sql.*;

public class CustomerDAO {

    private static final String INSERT_CUSTOMER_SQL =
        "INSERT INTO customers (accountNumber, name, address, telephone, userId) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_CUSTOMER_BY_USERID_SQL =
        "SELECT * FROM customers WHERE userId = ?";
    private static final String SELECT_CUSTOMER_ID_BY_USERID_SQL =
        "SELECT id FROM customers WHERE userId = ?";
    private static final String UPDATE_CUSTOMER_BY_USERID_SQL =
        "UPDATE customers SET accountNumber = ?, address = ?, telephone = ? WHERE userId = ?";

    public boolean insertCustomer(Customer customer) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(INSERT_CUSTOMER_SQL)) {

            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getName());
            stmt.setString(3, customer.getAddress());
            stmt.setString(4, customer.getTelephone());
            stmt.setInt(5, customer.getUserId());

            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public Customer getCustomerByUserId(int userId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_USERID_SQL)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return new Customer(
                    rs.getInt("id"),
                    rs.getString("accountNumber"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("telephone"),
                    rs.getInt("userId")
                );
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public int getCustomerIdByUserId(int userId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_ID_BY_USERID_SQL)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();
            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return -1; // or throw exception if customer not found
    }

    public boolean updateCustomerByUserId(Customer customer) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(UPDATE_CUSTOMER_BY_USERID_SQL)) {

            stmt.setString(1, customer.getAccountNumber());
            stmt.setString(2, customer.getAddress());
            stmt.setString(3, customer.getTelephone());
            stmt.setInt(4, customer.getUserId());

            int rowsUpdated = stmt.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    
    

}
