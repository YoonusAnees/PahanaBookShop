package com.pahana.bookshop.service;

import com.pahana.bookshop.DAO.StationeryDAO;
import com.pahana.bookshop.model.Stationery;

import java.sql.SQLException;
import java.util.List;

public class StationeryService {

    private static StationeryService instance;
    private final StationeryDAO stationeryDAO;

    
    private StationeryService() {
        this.stationeryDAO = new StationeryDAO();
    }

    // Public method to get the singleton instance
    public static StationeryService getInstance() {
        if (instance == null) {
            synchronized (StationeryService.class) {
                if (instance == null) {
                    instance = new StationeryService();
                }
            }
        }
        return instance;
    }

    // Service methods

    public void addStationery(Stationery stationery) throws SQLException {
        stationeryDAO.insertStationery(stationery);
    }

    public Stationery getStationeryById(int id) throws SQLException {
        return stationeryDAO.getStationeryById(id);
    }

    public List<Stationery> getAllStationery() throws SQLException {
        return stationeryDAO.getAllStationery();
    }

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
