package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Customer;
import java.sql.*;

public class CustomerDAO {

    private static final String INSERT_CUSTOMER_SQL =
        "INSERT INTO customers (accountNumber, name, address, telephone, userId) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_CUSTOMER_BY_USERID_SQL =
        "SELECT * FROM customers WHERE userId = ?";
    private static final String UPDATE_CUSTOMER_BY_USERID_SQL =
        "UPDATE customers SET accountNumber = ?, address = ?, telephone = ? WHERE userId = ?";
    private static final String GET_MAX_ACCOUNT_SQL =
        "SELECT MAX(accountNumber) AS maxAcc FROM customers";

    // Generate sequential account number (001, 002, …)
    public String generateAccountNumber() {
        try (Connection conn = DBConnectionFactory.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(GET_MAX_ACCOUNT_SQL)) {

            if (rs.next() && rs.getString("maxAcc") != null) {
                int max = Integer.parseInt(rs.getString("maxAcc"));
                return String.format("%03d", max + 1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return "001";
    }

    // Insert customer
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

    // Get customer by userId
    public Customer getCustomerByUserId(int userId) {
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(SELECT_CUSTOMER_BY_USERID_SQL)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                Customer customer = new Customer(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("address"),
                    rs.getString("telephone"),
                    rs.getInt("userId")
                );
                customer.setAccountNumber(rs.getString("accountNumber"));
                return customer;
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    // Get only customer ID by userId
    public int getCustomerIdByUserId(int userId) {
        String sql = "SELECT id FROM customers WHERE userId = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, userId);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                return rs.getInt("id");
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return -1; // return -1 if no customer is found
    }

    // Update customer by userId
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
