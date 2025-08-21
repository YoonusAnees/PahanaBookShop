package com.pahana.test;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import com.pahana.bookshop.model.User;
import com.pahana.bookshop.service.UserService;

import java.util.List;

public class InserUser {

    private UserService userService;

    @BeforeEach
    public void setUp() {
        userService = UserService.getInstance();
    }

    @Test
    public void testInsertAndGetUser() {
        User user = new User("john_doe", "john@example.com", "password123", "customer");
        userService.insertUser(user);

        List<User> users = userService.getAllUsers();
        assertTrue(users.stream().anyMatch(u -> u.getEmail().equals("john@example.com")));
    }

   
}
