package com.pahana.bookshop.DAO;

import com.pahana.bookshop.model.Stationery;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StationeryDAO {

    // Insert stationery item into DB (with quantity)
    public boolean insertStationery(Stationery stationery) {
        String sql = "INSERT INTO stationery (name, description, price, quantity) VALUES (?, ?, ?, ?)";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stationery.getName());
            ps.setString(2, stationery.getDescription());
            ps.setDouble(3, stationery.getPrice());
            if (stationery.getQuantity() != null) {
                ps.setInt(4, stationery.getQuantity());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // List all stationery items
    public List<Stationery> getAllStationery() {
        List<Stationery> list = new ArrayList<>();
        String sql = "SELECT * FROM stationery";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Stationery s = new Stationery(
                    rs.getInt("id"),
                    rs.getString("name"),
                    rs.getString("description"),
                    rs.getDouble("price"),
                    rs.getInt("quantity")
                );
                list.add(s);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    // Get stationery item by ID
    public Stationery getStationeryById(int id) {
        String sql = "SELECT * FROM stationery WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Stationery(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("quantity")
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    // Update stationery item (with quantity)
    public boolean updateStationery(Stationery stationery) {
        String sql = "UPDATE stationery SET name = ?, description = ?, price = ?, quantity = ? WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, stationery.getName());
            ps.setString(2, stationery.getDescription());
            ps.setDouble(3, stationery.getPrice());
            if (stationery.getQuantity() != null) {
                ps.setInt(4, stationery.getQuantity());
            } else {
                ps.setNull(4, Types.INTEGER);
            }
            ps.setInt(5, stationery.getId());
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    // Delete stationery item by ID
    public boolean deleteStationery(int id) {
        String sql = "DELETE FROM stationery WHERE id = ?";
        try (Connection conn = DBConnectionFactory.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
