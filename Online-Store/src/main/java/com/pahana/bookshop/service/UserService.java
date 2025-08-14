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

    public void insertUser(User user) {
        userDAO.insertUser(user);
    }

    public List<User> getAllUsers() {
        return userDAO.getAllUsers();
    }

    public User getUserById(int id) {
        return userDAO.getUserById(id);
    }

    public void updateUser(User user) {
        userDAO.updateUser(user);
    }

    public void deleteUser(int id) {
        userDAO.deleteUser(id);
    }

    public User validateLogin(String email, String password) {
        return userDAO.validateLogin(email, password);
    }
}
