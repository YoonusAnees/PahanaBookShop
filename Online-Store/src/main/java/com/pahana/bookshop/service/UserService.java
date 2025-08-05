package com.pahana.bookshop.service;

import java.util.List;

import com.pahana.bookshop.DAO.UserDAO;
import com.pahana.bookshop.model.User;

public class UserService {

    private static UserService instance;
    private UserDAO userDAO;

    private UserService() {
        this.userDAO = new UserDAO();
    }

    public static UserService getInstance() {
        if (instance == null) {
            synchronized (UserService.class) {
                if (instance == null) {
                    instance = new UserService();
                }
            }
        }
        return instance;
    }

    // Add new user
    public void insertUser(User user) {
        userDAO.insertUser(user);
    }

    // Get all users
    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    // Get user by ID
    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    // Update user
    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    // Delete user
    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

    // Validate login
    public User validateLogin(String username, String password) {
        return userDAO.validateLogin(username, password);
    }
}
