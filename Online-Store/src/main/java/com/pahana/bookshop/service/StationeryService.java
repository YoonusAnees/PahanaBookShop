package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.StationeryDAO;
import com.pahana.bookshop.model.Stationery;

import java.sql.SQLException;
import java.util.List;

public class StationeryService {

    private final StationeryDAO stationeryDAO = new StationeryDAO();

    public void addStationery(Stationery stationery) throws SQLException {
        stationeryDAO.insertStationery(stationery);
    }

    public Stationery getStationeryById(int id) throws SQLException {
        return stationeryDAO.getStationeryById(id);
    }

    public List<Stationery> getAllStationery() throws SQLException {
        return stationeryDAO.getAllStationery();
    }
    
    // Optional method that catches exceptions and returns null if failure (like in BookService)
    public List<Stationery> getAllStationerySafe() {
        try {
            return stationeryDAO.getAllStationery();
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public void updateStationery(Stationery stationery) throws SQLException {
        stationeryDAO.updateStationery(stationery);
    }

    public void deleteStationery(int id) throws SQLException {
        stationeryDAO.deleteStationery(id);
    }
}
